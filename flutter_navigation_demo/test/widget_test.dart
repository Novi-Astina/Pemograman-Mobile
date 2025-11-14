import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_navigation_demo/main.dart';

void main() {
  testWidgets('App memuat halaman Home secara default', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNavigationDemoApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Firebase'), findsOneWidget);
  });
}
