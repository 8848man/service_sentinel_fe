import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:service_sentinel_fe/app/app.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ServiceSentinelApp(),
      ),
    );

    // Wait for async initialization
    await tester.pumpAndSettle();

    // Verify that the app title is rendered
    expect(find.text('ServiceSentinel'), findsOneWidget);
  });
}
