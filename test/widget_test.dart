import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sinbool/app.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: SinboolApp(),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('Sinbool'), findsWidgets);

    // Verify that the subtitle is displayed
    expect(find.text('Islamic Stories for Children'), findsOneWidget);

    // Verify that the setup complete message is displayed
    expect(find.textContaining('Project setup complete'), findsOneWidget);
  });
}
