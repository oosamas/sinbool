import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/progress/progress_bar.dart';

/// Quiz page for testing knowledge
/// From Issue #3 - Navigation & Routing
class QuizPage extends StatefulWidget {
  const QuizPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _correctAnswers = 0;
  bool _quizCompleted = false;

  final List<_QuizQuestion> _questions = [
    _QuizQuestion(
      question: 'What is the most important thing the Prophet taught us?',
      options: [
        'To be kind to others',
        'To worship only Allah',
        'To pray sometimes',
        'To be rich',
      ],
      correctIndex: 1,
    ),
    _QuizQuestion(
      question: 'How many times a day should Muslims pray?',
      options: ['3 times', '4 times', '5 times', '2 times'],
      correctIndex: 2,
    ),
    _QuizQuestion(
      question: 'What should we say before eating?',
      options: [
        'Alhamdulillah',
        'Bismillah',
        'SubhanAllah',
        'Assalamu Alaikum',
      ],
      correctIndex: 1,
    ),
    _QuizQuestion(
      question: 'What does patience mean?',
      options: [
        'Getting angry quickly',
        'Waiting calmly and trusting Allah',
        'Running away from problems',
        'Complaining all the time',
      ],
      correctIndex: 1,
    ),
  ];

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestion].correctIndex) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizCompleted) {
      return _buildResultsScreen();
    }

    final question = _questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: Spacing.md),
              child: Text(
                '${_currentQuestion + 1}/${_questions.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress bar
            AppProgressBar(progress: progress),
            const SizedBox(height: Spacing.xl),

            // Question
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.xl),

            // Options
            ...List.generate(question.options.length, (index) {
              final isSelected = _selectedAnswer == index;
              final isCorrect = index == question.correctIndex;
              final showResult = _answered;

              Color? backgroundColor;
              Color? borderColor;

              if (showResult) {
                if (isCorrect) {
                  backgroundColor = AppColors.success.withValues(alpha: 0.15);
                  borderColor = AppColors.success;
                } else if (isSelected && !isCorrect) {
                  backgroundColor = AppColors.error.withValues(alpha: 0.15);
                  borderColor = AppColors.error;
                }
              } else if (isSelected) {
                backgroundColor = AppColors.primary.withValues(alpha: 0.15);
                borderColor = AppColors.primary;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: InkWell(
                  onTap: () => _selectAnswer(index),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Container(
                    padding: const EdgeInsets.all(Spacing.md),
                    decoration: BoxDecoration(
                      color: backgroundColor ?? AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: borderColor != null
                          ? Border.all(color: borderColor, width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
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
                            ),
                          ),
                          child: Center(
                            child: isSelected && showResult
                                ? Icon(
                                    isCorrect ? Icons.check : Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : Text(
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
                            question.options[index],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Next button
            if (_answered)
              AppButton(
                text: _currentQuestion < _questions.length - 1
                    ? 'Next Question'
                    : 'See Results',
                onPressed: _nextQuestion,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final percentage = (_correctAnswers / _questions.length * 100).round();
    final passed = percentage >= 70;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: (passed ? AppColors.success : AppColors.warning)
                    .withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                passed ? Icons.celebration : Icons.refresh,
                size: 64,
                color: passed ? AppColors.success : AppColors.warning,
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Result text
            Text(
              passed ? 'Great Job!' : 'Keep Learning!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.md),

            // Score
            Text(
              'You got $_correctAnswers out of ${_questions.length} correct!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: Spacing.sm),

            // Percentage
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: passed ? AppColors.success : AppColors.warning,
                  ),
            ),
            const SizedBox(height: Spacing.xl),

            // Message
            Text(
              passed
                  ? 'Mashallah! You have learned well. Keep up the great work!'
                  : 'Don\'t worry! Learning takes time. Try reading the story '
                      'again and come back for another try.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.xl),

            // Buttons
            if (!passed) ...[
              AppButton(
                text: 'Try Again',
                onPressed: _restartQuiz,
              ),
              const SizedBox(height: Spacing.md),
            ],
            AppOutlinedButton(
              text: passed ? 'Continue' : 'Back to Lesson',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizQuestion {
  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  final String question;
  final List<String> options;
  final int correctIndex;
}
