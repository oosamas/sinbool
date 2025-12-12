import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/core/widgets/buttons/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('should display text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Click Me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Click Me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(pressed, isTrue);
    });

    testWidgets('should show loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Click Me',
              onPressed: null,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(pressed, isFalse);
    });
  });

  group('AppOutlinedButton', () {
    testWidgets('should display text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppOutlinedButton(
              text: 'Outlined',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppOutlinedButton(
              text: 'Outlined',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppOutlinedButton));
      expect(pressed, isTrue);
    });
  });

  group('AppTextButton', () {
    testWidgets('should display text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(
              text: 'Text Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(
              text: 'Text Button',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppTextButton));
      expect(pressed, isTrue);
    });
  });
}
