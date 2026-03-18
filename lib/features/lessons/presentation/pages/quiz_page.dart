import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/progress/progress_bar.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../domain/entities/lesson_entity.dart';

/// Quiz page for testing knowledge
/// Loads actual quiz content from the lesson database
class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _correctAnswers = 0;
  bool _quizCompleted = false;
  bool _showExplanation = false;

  void _selectAnswer(int index, List<QuizQuestionEntity> questions) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      _showExplanation = true;
      if (index == questions[_currentQuestion].correctIndex) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion(List<QuizQuestionEntity> questions) {
    if (_currentQuestion < questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
        _showExplanation = false;
      });
    } else {
      setState(() => _quizCompleted = true);
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestion = 0;
      _selectedAnswer = null;
      _answered = false;
      _correctAnswers = 0;
      _quizCompleted = false;
      _showExplanation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the lesson first to get its database ID
    final lessonAsync = ref.watch(lessonProvider(widget.lessonId));

    return lessonAsync.when(
      data: (lesson) {
        if (lesson == null) {
          return _buildNotFound(context);
        }
        return _buildQuizContent(context, lesson);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load quiz'),
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
      appBar: AppBar(title: const Text('Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz_outlined, size: 64, color: AppColors.textHint),
            const SizedBox(height: Spacing.md),
            Text(
              'Quiz not found',
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

  Widget _buildQuizContent(BuildContext context, LessonEntity lesson) {
    // Fetch quiz questions for this lesson
    final quizAsync = ref.watch(quizQuestionsProvider(lesson.id));

    return quizAsync.when(
      data: (questions) {
        if (questions.isEmpty) {
          return _buildNoQuestions(context, lesson);
        }

        if (_quizCompleted) {
          return _buildResultsScreen(context, lesson, questions);
        }

        return _buildQuizScreen(context, lesson, questions);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              Text('Failed to load questions: $error'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(quizQuestionsProvider(lesson.id)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoQuestions(BuildContext context, LessonEntity lesson) {
    return Scaffold(
      appBar: AppBar(title: Text('${lesson.title} Quiz')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz_outlined, size: 64, color: AppColors.textHint),
              const SizedBox(height: Spacing.md),
              Text(
                'No quiz questions available',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                'This lesson doesn\'t have a quiz yet.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.xl),
              AppButton(
                text: 'Go Back',
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizScreen(
    BuildContext context,
    LessonEntity lesson,
    List<QuizQuestionEntity> questions,
  ) {
    final question = questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / questions.length;

    // Check language setting for Arabic support
    final settingsState = ref.watch(settingsControllerProvider);
    final isArabic = settingsState.settings.language == 'ar';

    // Get localized content
    final questionText = isArabic && question.questionArabic != null
        ? question.questionArabic!
        : question.question;
    final options = isArabic && question.optionsArabic != null
        ? question.optionsArabic!
        : question.options;
    final explanation = isArabic && question.explanationArabic != null
        ? question.explanationArabic
        : question.explanation;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: Spacing.md),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  '${_currentQuestion + 1}/${questions.length}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress bar
            AppProgressBar(progress: progress),
            const SizedBox(height: Spacing.xl),

            // Question card
            Container(
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 32,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: Spacing.md),
                  Text(
                    questionText,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Options
            ...List.generate(options.length, (index) {
              final isSelected = _selectedAnswer == index;
              final isCorrect = index == question.correctIndex;
              final showResult = _answered;

              Color? backgroundColor;
              Color? borderColor;
              IconData? trailingIcon;

              if (showResult) {
                if (isCorrect) {
                  backgroundColor = AppColors.success.withValues(alpha: 0.15);
                  borderColor = AppColors.success;
                  trailingIcon = Icons.check_circle;
                } else if (isSelected && !isCorrect) {
                  backgroundColor = AppColors.error.withValues(alpha: 0.15);
                  borderColor = AppColors.error;
                  trailingIcon = Icons.cancel;
                }
              } else if (isSelected) {
                backgroundColor = AppColors.primary.withValues(alpha: 0.15);
                borderColor = AppColors.primary;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: InkWell(
                  onTap: () => _selectAnswer(index, questions),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Container(
                    padding: const EdgeInsets.all(Spacing.md),
                    decoration: BoxDecoration(
                      color: backgroundColor ?? AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: borderColor ?? Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? (showResult
                                    ? (isCorrect
                                        ? AppColors.success
                                        : AppColors.error)
                                    : AppColors.primary)
                                : AppColors.surface,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : AppColors.textHint,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Spacing.md),
                        Expanded(
                          child: Text(
                            options[index],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected ? FontWeight.w600 : null,
                                ),
                            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                          ),
                        ),
                        if (showResult && trailingIcon != null)
                          Icon(
                            trailingIcon,
                            color: isCorrect ? AppColors.success : AppColors.error,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Explanation (shown after answering)
            if (_showExplanation && explanation != null) ...[
              const SizedBox(height: Spacing.md),
              Container(
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Expanded(
                      child: Text(
                        explanation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.info,
                            ),
                        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: Spacing.xl),

            // Next button
            if (_answered)
              AppButton(
                text: _currentQuestion < questions.length - 1
                    ? 'Next Question'
                    : 'See Results',
                onPressed: () => _nextQuestion(questions),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen(
    BuildContext context,
    LessonEntity lesson,
    List<QuizQuestionEntity> questions,
  ) {
    final percentage = (_correctAnswers / questions.length * 100).round();
    final passed = percentage >= 70;

    String resultEmoji;
    String resultMessage;
    Color resultColor;

    if (percentage == 100) {
      resultEmoji = '🌟';
      resultMessage = 'Perfect! Mashallah!';
      resultColor = AppColors.success;
    } else if (percentage >= 80) {
      resultEmoji = '🎉';
      resultMessage = 'Excellent work!';
      resultColor = AppColors.success;
    } else if (percentage >= 70) {
      resultEmoji = '👍';
      resultMessage = 'Good job!';
      resultColor = AppColors.success;
    } else if (percentage >= 50) {
      resultEmoji = '📚';
      resultMessage = 'Keep learning!';
      resultColor = AppColors.warning;
    } else {
      resultEmoji = '💪';
      resultMessage = 'Try again!';
      resultColor = AppColors.warning;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result emoji
            Text(
              resultEmoji,
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: Spacing.lg),

            // Result text
            Text(
              resultMessage,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
            ),
            const SizedBox(height: Spacing.md),

            // Score
            Text(
              'You got $_correctAnswers out of ${questions.length} correct!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: Spacing.lg),

            // Percentage circle
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: resultColor.withValues(alpha: 0.15),
                border: Border.all(color: resultColor, width: 4),
              ),
              child: Center(
                child: Text(
                  '$percentage%',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                ),
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Encouragement message
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Text(
                passed
                    ? 'Mashallah! You have learned the lesson well. Keep up the great work and continue learning about our beautiful faith!'
                    : 'Don\'t worry! Learning takes time. Try reading the story again and come back for another try. You can do it!',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Buttons
            if (!passed) ...[
              AppButton(
                text: 'Try Again',
                onPressed: _restartQuiz,
              ),
              const SizedBox(height: Spacing.md),
              AppOutlinedButton(
                text: 'Back to Lesson',
                onPressed: () => context.pop(),
              ),
            ] else
              AppButton(
                text: 'Continue',
                onPressed: () => context.pop(),
              ),
          ],
        ),
      ),
    );
  }
}
