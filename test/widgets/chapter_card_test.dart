import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/core/widgets/cards/chapter_card.dart';

void main() {
  group('ChapterCard', () {
    testWidgets('should display title and description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChapterCard(
              title: 'Test Chapter',
              description: 'Test Description',
              icon: Icons.book,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Chapter'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('should display lesson count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChapterCard(
              title: 'Test Chapter',
              description: 'Test Description',
              lessonCount: 15,
              completedCount: 5,
              icon: Icons.book,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('5/15'), findsOneWidget);
    });

    testWidgets('should display icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChapterCard(
              title: 'Test Chapter',
              description: 'Test Description',
              icon: Icons.star,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChapterCard(
              title: 'Test Chapter',
              description: 'Test Description',
              icon: Icons.book,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ChapterCard));
      expect(tapped, isTrue);
    });

    testWidgets('should show premium badge when isPremium is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChapterCard(
              title: 'Test Chapter',
              description: 'Test Description',
              icon: Icons.book,
              isPremium: true,
              onTap: () {},
            ),
          ),
        ),
      );

      // Star icon appears in premium badge
      expect(find.byIcon(Icons.star), findsWidgets);
    });
  });
}
