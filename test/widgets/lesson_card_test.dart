import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/core/widgets/cards/lesson_card.dart';

void main() {
  group('LessonCard', () {
    testWidgets('should display title and subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Lesson'), findsOneWidget);
      expect(find.text('Test Chapter'), findsOneWidget);
    });

    testWidgets('should display duration when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              duration: '10 min',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('10 min'), findsOneWidget);
    });

    testWidgets('should show audio icon when hasAudio is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              hasAudio: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.headphones), findsOneWidget);
    });

    testWidgets('should show quiz icon when hasQuiz is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              hasQuiz: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.quiz), findsOneWidget);
    });

    testWidgets('should show check icon when completed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              isCompleted: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(LessonCard));
      expect(tapped, isTrue);
    });

    testWidgets('should show lock icon when isLocked is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCard(
              title: 'Test Lesson',
              subtitle: 'Test Chapter',
              isLocked: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.lock), findsOneWidget);
    });
  });
}
