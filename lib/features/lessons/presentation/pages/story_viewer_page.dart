import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/buttons/app_button.dart';

/// Story viewer page for reading stories
/// From Issue #3 - Navigation & Routing
class StoryViewerPage extends StatefulWidget {
  const StoryViewerPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _fontSize = 18;
  bool _showControls = true;

  // Sample story content
  final List<_StoryPage> _pages = [
    _StoryPage(
      content: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      translation: 'In the name of Allah, the Most Gracious, the Most Merciful',
      imageDescription: 'Opening page with Islamic calligraphy',
    ),
    _StoryPage(
      content:
          'Long ago, in a land far away, there lived a righteous man who '
          'always remembered Allah in everything he did.',
      translation: null,
      imageDescription: 'A peaceful village scene',
    ),
    _StoryPage(
      content:
          'He would pray five times a day and always help those in need. '
          'His kindness was known throughout the land.',
      translation: null,
      imageDescription: 'Man praying at sunset',
    ),
    _StoryPage(
      content:
          'One day, Allah decided to test his faith with a great trial. '
          'But he remained patient and trusted in Allah\'s plan.',
      translation: null,
      imageDescription: 'Stormy clouds gathering',
    ),
    _StoryPage(
      content:
          'Through patience and prayer, he overcame every challenge. '
          'Allah rewarded him for his unwavering faith.',
      translation: null,
      imageDescription: 'Beautiful sunrise',
    ),
    _StoryPage(
      content:
          'The moral of this story teaches us that with faith and patience, '
          'we can overcome any difficulty in life.',
      translation: null,
      imageDescription: 'Peaceful ending scene',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Story content
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _StoryPageWidget(
                  page: _pages[index],
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
                          icon:
                              const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
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
                        IconButton(
                          icon: const Icon(
                            Icons.headphones,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // TODO: Play audio
                          },
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
                            _pages.length,
                            (index) => Container(
                              width: index == _currentPage ? 24 : 8,
                              height: 8,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2),
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
                          'Page ${_currentPage + 1} of ${_pages.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        if (_currentPage == _pages.length - 1) ...[
                          const SizedBox(height: Spacing.md),
                          AppButton(
                            text: 'Complete Lesson',
                            onPressed: () {
                              // TODO: Mark lesson as complete
                              Navigator.of(context).pop();
                            },
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

class _StoryPage {
  const _StoryPage({
    required this.content,
    this.translation,
    this.imageDescription,
  });

  final String content;
  final String? translation;
  final String? imageDescription;
}

class _StoryPageWidget extends StatelessWidget {
  const _StoryPageWidget({
    required this.page,
    required this.fontSize,
  });

  final _StoryPage page;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(page.content);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.xl),
      child: Column(
        children: [
          const SizedBox(height: 80), // Space for top controls
          // Image placeholder
          Container(
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
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Story text
          Text(
            page.content,
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
}
