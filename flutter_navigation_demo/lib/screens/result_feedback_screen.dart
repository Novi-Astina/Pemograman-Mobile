import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class ResultFeedbackScreen extends StatelessWidget {
  final String hasilFeedback;

  const ResultFeedbackScreen({
    super.key,
    required this.hasilFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Hasil Feedback",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Terima kasih atas feedback kamu!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              hasilFeedback,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
