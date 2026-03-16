/// One-time CLI script to generate audio narrations using Gemini 2.5 Flash TTS
/// and upload them to Firebase Storage.
///
/// Usage:
///   1. Set environment variable: export GEMINI_API_KEY=your_key_here
///   2. Install Firebase CLI and login: firebase login
///   3. Run: dart run tools/generate_audio.dart [--language en] [--lesson prophet_ayyub_lesson_1]
///
/// The script will:
///   - Read all lesson content from assets/content/*.json
///   - Generate audio using Gemini 2.5 Flash with audio output modality
///   - Save audio files locally to tools/generated_audio/
///   - Upload to Firebase Storage at: audio/{language}/{lessonServerId}.mp3
///
/// Firebase Storage structure:
///   audio/
///     en/
///       prophet_adam_lesson_1.mp3
///       prophet_adam_lesson_2.mp3
///       ...
///     ar/
///       prophet_adam_lesson_1.mp3
///       ...

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const String geminiApiBase =
    'https://generativelanguage.googleapis.com/v1beta/models';
const String model = 'gemini-2.5-flash-preview-tts';

void main(List<String> args) async {
  final apiKey = Platform.environment['GEMINI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    stderr.writeln('Error: Set GEMINI_API_KEY environment variable');
    stderr.writeln('  export GEMINI_API_KEY=your_key_here');
    exit(1);
  }

  // Parse arguments
  String language = 'en';
  String? specificLesson;

  for (int i = 0; i < args.length; i++) {
    if (args[i] == '--language' && i + 1 < args.length) {
      language = args[i + 1];
      i++;
    } else if (args[i] == '--lesson' && i + 1 < args.length) {
      specificLesson = args[i + 1];
      i++;
    }
  }

  print('=== Sinbool Audio Generation Tool ===');
  print('Language: $language');
  print('Model: $model');
  if (specificLesson != null) {
    print('Generating for: $specificLesson only');
  }
  print('');

  // Create output directory
  final outputDir = Directory('tools/generated_audio/$language');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Read all content files
  final contentDir = Directory('assets/content');
  if (!contentDir.existsSync()) {
    stderr.writeln('Error: assets/content/ directory not found');
    exit(1);
  }

  final jsonFiles = contentDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  print('Found ${jsonFiles.length} content files');
  print('');

  int generated = 0;
  int skipped = 0;
  int failed = 0;

  for (final file in jsonFiles) {
    final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final lessons = content['lessons'] as List<dynamic>;

    for (final lesson in lessons) {
      final serverId = lesson['serverId'] as String;

      if (specificLesson != null && serverId != specificLesson) {
        continue;
      }

      final outputFile = File('${outputDir.path}/$serverId.mp3');
      if (outputFile.existsSync()) {
        print('SKIP $serverId (already exists)');
        skipped++;
        continue;
      }

      // Combine all pages into narration text
      final pages = lesson['content'] as List<dynamic>;
      final text = pages.map((page) {
        if (language == 'ar' && page['contentTextArabic'] != null) {
          return page['contentTextArabic'] as String;
        }
        return page['contentText'] as String;
      }).join('\n\n');

      final title = language == 'ar'
          ? (lesson['titleArabic'] ?? lesson['title'])
          : lesson['title'];

      print('GENERATING $serverId ($title) ...');

      final audioBytes = await generateAudio(apiKey, text, language);
      if (audioBytes != null) {
        outputFile.writeAsBytesSync(audioBytes);
        final sizeKb = (audioBytes.length / 1024).toStringAsFixed(1);
        print('  -> Saved ${outputFile.path} ($sizeKb KB)');
        generated++;
      } else {
        print('  -> FAILED');
        failed++;
      }

      // Rate limiting - Gemini free tier has limits
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  print('');
  print('=== Summary ===');
  print('Generated: $generated');
  print('Skipped: $skipped');
  print('Failed: $failed');
  print('');
  print('Audio files saved to: ${outputDir.path}/');
  print('');
  print('Next step: Upload to Firebase Storage');
  print('Run: dart run tools/generate_audio.dart --upload');
  print('Or manually upload with:');
  print('  firebase storage:upload tools/generated_audio/ audio/ --project YOUR_PROJECT_ID');
}

/// Generate audio using Gemini 2.5 Flash TTS
Future<Uint8List?> generateAudio(
    String apiKey, String text, String language) async {
  final client = HttpClient();

  try {
    final languageInstruction = language == 'ar'
        ? 'Read the following Arabic story clearly and naturally, as if narrating to children. Use a warm, engaging, storytelling tone.'
        : 'Read the following story clearly and naturally, as if narrating to children. Use a warm, engaging, storytelling tone with gentle expression.';

    final requestBody = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': '$languageInstruction\n\n$text',
            }
          ]
        }
      ],
      'generationConfig': {
        'response_modalities': ['AUDIO'],
        'speech_config': {
          'voice_config': {
            'prebuilt_voice_config': {
              'voice_name': language == 'ar' ? 'Sadaltager' : 'Kore',
            }
          }
        }
      }
    });

    final uri = Uri.parse(
        '$geminiApiBase/$model:generateContent?key=$apiKey');
    final request = await client.postUrl(uri);
    request.headers.set('Content-Type', 'application/json; charset=utf-8');
    request.add(utf8.encode(requestBody));

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      stderr.writeln('  API error ${response.statusCode}: $responseBody');
      return null;
    }

    final json = jsonDecode(responseBody) as Map<String, dynamic>;
    final candidates = json['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      stderr.writeln('  No candidates in response');
      return null;
    }

    final parts = candidates[0]['content']['parts'] as List<dynamic>;
    for (final part in parts) {
      if (part.containsKey('inlineData')) {
        final inlineData = part['inlineData'] as Map<String, dynamic>;
        final base64Audio = inlineData['data'] as String;
        // Gemini returns audio as WAV/PCM - we'll convert or use as-is
        // The mime type tells us the format
        final mimeType = inlineData['mimeType'] as String? ?? 'audio/wav';
        stdout.writeln('  Audio format: $mimeType');
        return base64Decode(base64Audio);
      }
    }

    stderr.writeln('  No audio data in response');
    return null;
  } catch (e) {
    stderr.writeln('  Error: $e');
    return null;
  } finally {
    client.close();
  }
}
