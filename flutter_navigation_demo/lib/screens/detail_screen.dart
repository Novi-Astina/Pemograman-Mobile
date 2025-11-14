import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String message;

  const DetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
      ),
      body: Center(
        child: Text(
          "Data diterima: $message",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
