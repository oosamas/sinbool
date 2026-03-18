import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../audio/data/services/tts_service.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../domain/entities/lesson_entity.dart';

/// Story viewer page for reading stories
/// From Issue #3 - Navigation & Routing
class StoryViewerPage extends ConsumerStatefulWidget {
  const StoryViewerPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  ConsumerState<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends ConsumerState<StoryViewerPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _fontSize = 18;
  bool _showControls = true;
  bool _isMarkingComplete = false;
  bool _isReadingAloud = false;
  bool _autoReadEnabled = false;

  @override
  void dispose() {
    // Stop TTS when leaving the page
    ref.read(ttsServiceProvider).stop();
    _pageController.dispose();
    super.dispose();
  }

  /// Start reading the current page aloud using TTS
  Future<void> _readCurrentPageAloud(List<LessonContentEntity> pages) async {
    if (_currentPage >= pages.length) return;

    final ttsService = ref.read(ttsServiceProvider);
    final settingsState = ref.read(settingsControllerProvider);
    final language = settingsState.settings.language;

    // Set language for TTS
    await ttsService.setLanguage(language);

    // Get content based on language
    final page = pages[_currentPage];
    String textToRead;

    if (language == 'ar' && page.contentTextArabic != null) {
      textToRead = page.contentTextArabic!;
    } else {
      textToRead = page.contentText;
    }

    setState(() => _isReadingAloud = true);

    await ttsService.speak(textToRead);
  }

  /// Read all pages aloud starting from current page
  Future<void> _readAllPagesAloud(List<LessonContentEntity> pages) async {
    final ttsService = ref.read(ttsServiceProvider);
    final settingsState = ref.read(settingsControllerProvider);
    final language = settingsState.settings.language;

    await ttsService.setLanguage(language);

    setState(() {
      _isReadingAloud = true;
      _autoReadEnabled = true;
    });

    for (int i = _currentPage; i < pages.length; i++) {
      if (!_autoReadEnabled) break;

      // Navigate to page
      if (_pageController.hasClients && i != _currentPage) {
        _pageController.animateToPage(
          i,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }

      final page = pages[i];
      String textToRead;

      if (language == 'ar' && page.contentTextArabic != null) {
        textToRead = page.contentTextArabic!;
      } else {
        textToRead = page.contentText;
      }

      await ttsService.speak(textToRead);

      // Wait for speech to complete before moving to next page
      await _waitForSpeechComplete();
    }

    setState(() {
      _isReadingAloud = false;
      _autoReadEnabled = false;
    });
  }

  Future<void> _waitForSpeechComplete() async {
    final ttsService = ref.read(ttsServiceProvider);
    while (ttsService.isPlaying && _autoReadEnabled) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Stop reading aloud
  Future<void> _stopReading() async {
    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.stop();
    setState(() {
      _isReadingAloud = false;
      _autoReadEnabled = false;
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  void _increaseFontSize() {
    if (_fontSize < 28) {
      setState(() => _fontSize += 2);
    }
  }

  void _decreaseFontSize() {
    if (_fontSize > 14) {
      setState(() => _fontSize -= 2);
    }
  }

  Future<void> _onPageChanged(int index, int lessonId) async {
    setState(() => _currentPage = index);

    // Update last page viewed in database
    try {
      final repository = ref.read(lessonRepositoryProvider);
      await repository.updateLastPage(lessonId, index + 1);
    } catch (e) {
      // Silently fail - page tracking is not critical
      debugPrint('Failed to update page progress: $e');
    }
  }

  Future<void> _markLessonComplete(int lessonId) async {
    if (_isMarkingComplete) return;

    setState(() => _isMarkingComplete = true);

    try {
      final repository = ref.read(lessonRepositoryProvider);
      await repository.markLessonCompleted(lessonId);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: Spacing.sm),
                Text('Lesson completed! Great job!'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Return to previous screen
        Navigator.of(context).pop(true); // Return true to indicate completion
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save progress: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isMarkingComplete = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonAsync = ref.watch(lessonProvider(widget.lessonId));

    return lessonAsync.when(
      data: (lesson) {
        if (lesson == null) {
          return _buildNotFound(context);
        }
        return _buildContent(context, lesson);
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load lesson'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(lessonProvider(widget.lessonId)),
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
      backgroundColor: AppColors.surface,
      appBar: AppBar(backgroundColor: Colors.transparent),
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LessonEntity lesson) {
    final contentAsync = ref.watch(lessonContentProvider(lesson.id));

    return contentAsync.when(
      data: (pages) {
        if (pages.isEmpty) {
          return _buildEmptyContent(context, lesson);
        }
        return _buildStoryViewer(context, lesson, pages);
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load content'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(lessonContentProvider(lesson.id)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyContent(BuildContext context, LessonEntity lesson) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(lesson.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book_outlined, size: 64, color: AppColors.textHint),
            const SizedBox(height: Spacing.md),
            Text(
              'No content available yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.lg),
            AppButton(
              text: 'Mark as Complete Anyway',
              onPressed: () => _markLessonComplete(lesson.id),
              isLoading: _isMarkingComplete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryViewer(
    BuildContext context,
    LessonEntity lesson,
    List<LessonContentEntity> pages,
  ) {
    // Initialize page controller to last viewed page
    if (_currentPage == 0 && lesson.lastPageViewed > 0 && lesson.lastPageViewed <= pages.length) {
      final targetPage = lesson.lastPageViewed - 1;
      if (targetPage >= 0 && targetPage < pages.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients) {
            _pageController.jumpToPage(targetPage);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Story content
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => _onPageChanged(index, lesson.id),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return _StoryPageWidget(
                  page: pages[index],
                  fontSize: _fontSize,
                );
              },
            ),

            // Top controls
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: _showControls ? 0 : -100,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.md),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.text_decrease,
                            color: Colors.white,
                          ),
                          onPressed: _decreaseFontSize,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.text_increase,
                            color: Colors.white,
                          ),
                          onPressed: _increaseFontSize,
                        ),
                        // Read Aloud TTS button - reads the story text aloud
                        _ReadAloudButton(
                          isReading: _isReadingAloud,
                          onReadPage: () => _readCurrentPageAloud(pages),
                          onReadAll: () => _readAllPagesAloud(pages),
                          onStop: _stopReading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom controls
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: _showControls ? 0 : -100,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Page indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (index) => Container(
                              width: index == _currentPage ? 24 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index == _currentPage
                                    ? AppColors.primary
                                    : Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Spacing.md),
                        // Page number
                        Text(
                          'Page ${_currentPage + 1} of ${pages.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        // Complete button on last page
                        if (_currentPage == pages.length - 1) ...[
                          const SizedBox(height: Spacing.md),
                          AppButton(
                            text: lesson.isCompleted
                                ? 'Read Again ✓'
                                : 'Complete Lesson',
                            onPressed: _isMarkingComplete
                                ? null
                                : () => _markLessonComplete(lesson.id),
                            isLoading: _isMarkingComplete,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryPageWidget extends StatelessWidget {
  const _StoryPageWidget({
    required this.page,
    required this.fontSize,
  });

  final LessonContentEntity page;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final content = page.contentText;
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(content);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.xl),
      child: Column(
        children: [
          const SizedBox(height: 80), // Space for top controls

          // Image placeholder
          if (page.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Image.network(
                page.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildImagePlaceholder(context),
              ),
            )
          else
            _buildImagePlaceholder(context),

          const SizedBox(height: Spacing.xl),

          // Story text
          Text(
            content,
            style: isArabic
                ? AppTypography.quranArabic(fontSize: fontSize + 8)
                : TextStyle(
                    fontSize: fontSize,
                    height: 1.8,
                    color: AppColors.textPrimary,
                  ),
            textAlign: isArabic ? TextAlign.center : TextAlign.left,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),

          // Translation if available
          if (page.translation != null) ...[
            const SizedBox(height: Spacing.lg),
            Text(
              page.translation!,
              style: AppTypography.quranTranslation(fontSize: fontSize - 2),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 120), // Space for bottom controls
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image,
              size: 48,
              color: AppColors.textHint,
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              page.imageDescription ?? 'Story illustration',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Read Aloud button with TTS functionality
class _ReadAloudButton extends StatelessWidget {
  const _ReadAloudButton({
    required this.isReading,
    required this.onReadPage,
    required this.onReadAll,
    required this.onStop,
  });

  final bool isReading;
  final VoidCallback onReadPage;
  final VoidCallback onReadAll;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isReading ? Icons.stop_circle : Icons.headphones,
        color: isReading ? Colors.orange : Colors.white,
      ),
      onPressed: isReading ? onStop : () => _showReadOptions(context),
      tooltip: isReading ? 'Stop Reading' : 'Listen to Story',
    );
  }

  void _showReadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            Row(
              children: [
                const Icon(Icons.record_voice_over, color: AppColors.primary),
                const SizedBox(width: Spacing.sm),
                Text(
                  'Read Aloud',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              'Listen to the story being read aloud - perfect for car rides!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: Spacing.lg),
            // Read this page
            Card(
              margin: const EdgeInsets.only(bottom: Spacing.sm),
              child: ListTile(
                leading: const Icon(Icons.article, color: AppColors.primary),
                title: const Text('Read This Page'),
                subtitle: const Text('Listen to the current page only'),
                trailing: const Icon(Icons.play_arrow, color: AppColors.primary),
                onTap: () {
                  Navigator.pop(context);
                  onReadPage();
                },
              ),
            ),
            // Read entire story
            Card(
              margin: const EdgeInsets.only(bottom: Spacing.sm),
              child: ListTile(
                leading: const Icon(Icons.auto_stories, color: AppColors.primary),
                title: const Text('Read Entire Story'),
                subtitle: const Text('Listen to all pages automatically'),
                trailing: const Icon(Icons.play_arrow, color: AppColors.primary),
                onTap: () {
                  Navigator.pop(context);
                  onReadAll();
                },
              ),
            ),
            const SizedBox(height: Spacing.md),
          ],
        ),
      ),
    );
  }
}
