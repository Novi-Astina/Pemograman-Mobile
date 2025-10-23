import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_feedback_app/main.dart';

void main() {
  testWidgets('App builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(FormFeedbackApp());

    // Cek apakah judul halaman form muncul
    expect(find.text('💌 Feedback Form 💌'), findsOneWidget);
  });
}
