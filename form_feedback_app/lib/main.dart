import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FormFeedbackApp());
}

class FormFeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cute Feedback Form 💕',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[300],
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;

  void _submitFeedback() {
    if (_nameController.text.isEmpty || _commentController.text.isEmpty || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Isi semua data dulu yaa, Novi cantik 💖")),
      );
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => ResultPage(
          name: _nameController.text,
          comment: _commentController.text,
          rating: _rating,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: const Offset(0.0, 0.2), end: Offset.zero);
          final fade = Tween(begin: 0.0, end: 1.0);
          return SlideTransition(
            position: tween.animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: FadeTransition(
              opacity: fade.animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index;
        });
      },
      icon: Icon(
        index <= _rating ? Icons.star_rounded : Icons.star_border_rounded,
        color: Colors.pinkAccent,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "💌 Feedback Form 💌",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[400],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text("Nama Kamu 🌸", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Masukkan nama kamu...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 16),
              Text("Komentar 🦋", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Tulis komentarmu di sini...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 16),
              Text("Rating ⭐", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Row(
                children: List.generate(5, (index) => _buildStar(index + 1)),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: _submitFeedback,
                  child: Text(
                    "Kirim 💌",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String name;
  final String comment;
  final int rating;

  const ResultPage({required this.name, required this.comment, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5)),
              ],
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🎀 Hasil Feedback 🎀",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.purple[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text("Nama: $name", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Komentar: $comment", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Rating: ${"⭐" * rating}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Kembali 💞", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
