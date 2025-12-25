import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../audio/data/services/tts_service.dart';
import '../../../bookmarks/data/repositories/bookmark_repository.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../domain/entities/lesson_entity.dart';

/// Lesson detail page with content options
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #8 - Bookmarks Feature
class LessonDetailPage extends ConsumerWidget {
  const LessonDetailPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonProvider(lessonId));

    return lessonAsync.when(
      data: (lesson) {
        if (lesson == null) {
          return _buildNotFound(context);
        }
        return _LessonDetailContent(
          chapterId: chapterId,
          lesson: lesson,
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load lesson'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(lessonProvider(lessonId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textHint),
            const SizedBox(height: Spacing.md),
            Text(
              'Lesson not found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonDetailContent extends ConsumerStatefulWidget {
  const _LessonDetailContent({
    required this.chapterId,
    required this.lesson,
  });

  final String chapterId;
  final LessonEntity lesson;

  @override
  ConsumerState<_LessonDetailContent> createState() => _LessonDetailContentState();
}

class _LessonDetailContentState extends ConsumerState<_LessonDetailContent> {
  bool _isReadingAloud = false;
  TtsService? _ttsService;

  @override
  void initState() {
    super.initState();
    // Cache reference to TTS service for use in dispose
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ttsService = ref.read(ttsServiceProvider);
    });
  }

  @override
  void dispose() {
    // Stop TTS when leaving - use cached reference
    _ttsService?.stop();
    super.dispose();
  }

  String get chapterId => widget.chapterId;
  LessonEntity get lesson => widget.lesson;

  @override
  Widget build(BuildContext context) {
    // Watch bookmark state
    final isBookmarkedAsync = ref.watch(isLessonBookmarkedProvider(lesson.id));
    final isBookmarked = isBookmarkedAsync.valueOrNull ?? false;

    // Watch TTS state
    final ttsStateAsync = ref.watch(ttsStateStreamProvider);
    final ttsState = ttsStateAsync.valueOrNull;
    final isPlaying = ttsState == TtsState.playing;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.secondary : null,
            ),
            onPressed: () async {
              final repo = ref.read(bookmarkRepositoryProvider);
              final wasBookmarked = await repo.toggleBookmark(lesson.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasBookmarked
                          ? 'Added to bookmarks'
                          : 'Removed from bookmarks',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson header image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                image: lesson.thumbnailUrl != null
                    ? DecorationImage(
                        image: NetworkImage(lesson.thumbnailUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: lesson.thumbnailUrl == null
                  ? const Center(
                      child: Icon(
                        Icons.auto_stories,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: Spacing.lg),

            // Completion badge
            if (lesson.isCompleted)
              Container(
                margin: const EdgeInsets.only(bottom: Spacing.md),
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    SizedBox(width: Spacing.xs),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Lesson title
            Text(
              lesson.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.sm),

            // Lesson meta info
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  lesson.duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                if (lesson.hasAudio) ...[
                  const SizedBox(width: Spacing.md),
                  const Icon(
                    Icons.headphones,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Audio available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
                if (lesson.hasQuiz) ...[
                  const SizedBox(width: Spacing.md),
                  const Icon(
                    Icons.quiz,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Quiz available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Spacing.lg),

            // Lesson description
            Text(
              lesson.subtitle ??
                  'In this lesson, you will learn an important story '
                      'with valuable lessons about faith and patience.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: Spacing.xl),

            // Action buttons
            Text(
              'Choose how to learn',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),

            // Read story button
            _LessonOptionCard(
              icon: Icons.menu_book,
              title: 'Read Story',
              subtitle: 'Read the story with illustrations',
              color: AppColors.primary,
              onTap: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lesson.serverId),
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Listen button - uses TTS to read the story
            _LessonOptionCard(
              icon: isPlaying ? Icons.stop_circle : Icons.headphones,
              title: isPlaying ? 'Stop Reading' : 'Listen to Story',
              subtitle: isPlaying
                  ? 'Tap to stop narration'
                  : 'Listen to the story read aloud',
              color: AppColors.secondary,
              onTap: () => _handleListenTap(context),
            ),
            const SizedBox(height: Spacing.md),

            // Quiz button
            if (lesson.hasQuiz)
              _LessonOptionCard(
                icon: Icons.quiz,
                title: 'Take Quiz',
                subtitle: 'Test your knowledge',
                color: AppColors.success,
                onTap: () => context.push(
                  AppRoutes.quizScreenPath(chapterId, lesson.serverId),
                ),
              ),
            if (lesson.hasQuiz) const SizedBox(height: Spacing.xl),

            // Continue button
            AppButton(
              text: lesson.isCompleted ? 'Read Again' : 'Start Reading',
              onPressed: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lesson.serverId),
              ),
            ),
          ],
        ),
      ),
      // Show TTS status at bottom when playing
      bottomNavigationBar: isPlaying
          ? Container(
              padding: const EdgeInsets.all(Spacing.md),
              color: AppColors.secondary.withValues(alpha: 0.1),
              child: SafeArea(
                child: Row(
                  children: [
                    const Icon(Icons.record_voice_over, color: AppColors.secondary),
                    const SizedBox(width: Spacing.sm),
                    const Expanded(
                      child: Text(
                        'Reading story aloud...',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.stop_circle, color: AppColors.secondary),
                      onPressed: () => ref.read(ttsServiceProvider).stop(),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  /// Handle tap on "Listen to Story" button
  Future<void> _handleListenTap(BuildContext context) async {
    final ttsService = ref.read(ttsServiceProvider);

    // If already playing, stop
    if (ttsService.isPlaying) {
      await ttsService.stop();
      return;
    }

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Loading story content...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Get lesson content from repository (await the future)
    final repository = ref.read(lessonRepositoryProvider);
    final content = await repository.getContentForLesson(lesson.id);

    if (content.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No content available to read')),
        );
      }
      return;
    }

    // Get current language setting
    final settingsState = ref.read(settingsControllerProvider);
    final language = settingsState.settings.language;

    // Configure TTS for natural storytelling voice
    await ttsService.setLanguage(language);
    // Natural speech rate - 0.5 is conversational pace
    await ttsService.setSpeechRate(0.5);
    // Keep pitch at 1.0 for natural tone
    await ttsService.setPitch(1.0);

    // Combine all pages into one text with proper pauses
    final rawText = content.map((page) {
      if (language == 'ar' && page.contentTextArabic != null) {
        return page.contentTextArabic!;
      }
      return page.contentText;
    }).join('\n\n');

    // Clean text for speech - removes Arabic script when reading in English
    final cleanedText = ttsService.cleanTextForSpeech(rawText, language);

    if (cleanedText.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No readable content available')),
        );
      }
      return;
    }

    // Show confirmation and start reading
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.record_voice_over, color: Colors.white),
              const SizedBox(width: Spacing.sm),
              Expanded(child: Text('Reading "${lesson.title}"...')),
            ],
          ),
          backgroundColor: AppColors.secondary,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    await ttsService.speak(cleanedText);
  }
}

class _LessonOptionCard extends StatelessWidget {
  const _LessonOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
