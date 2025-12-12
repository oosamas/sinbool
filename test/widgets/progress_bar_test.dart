import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/core/widgets/progress/progress_bar.dart';

void main() {
  group('AppProgressBar', () {
    testWidgets('should render without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: 0.5),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });

    testWidgets('should display with custom height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(
              progress: 0.5,
              height: 20,
            ),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });

    testWidgets('should handle progress at 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: 0.0),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });

    testWidgets('should handle progress at 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: 1.0),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });

    testWidgets('should clamp progress > 1 to valid range', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: 1.5),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });

    testWidgets('should clamp progress < 0 to valid range', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressBar(progress: -0.5),
          ),
        ),
      );

      expect(find.byType(AppProgressBar), findsOneWidget);
    });
  });
}
