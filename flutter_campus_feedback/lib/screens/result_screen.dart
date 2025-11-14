import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feedback_provider.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';
import 'dart:math' as math;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  late AnimationController _checkAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _checkAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _checkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _checkAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    
    _checkAnimationController.forward();
    _cardAnimationController.forward();
  }
  
  @override
  void dispose() {
    _checkAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackProvider>(context);
    final feedback = provider.feedbackHistory.last;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Success Icon dengan animasi
                AnimatedBuilder(
                  animation: _checkAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _checkAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.accentGreen,
                              AppTheme.accentGreen.withOpacity(0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accentGreen.withOpacity(0.4),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Success Message
                const Text(
                  'Terima Kasih! 🎉',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Feedback Anda telah berhasil dikirim',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Card Biodata
                _buildAnimatedCard(
                  delay: 0,
                  child: _buildBiodataCard(feedback),
                ),
                
                const SizedBox(height: 20),
                
                // Card Score dengan grafik lingkaran
                _buildAnimatedCard(
                  delay: 200,
                  child: _buildScoreCard(feedback),
                ),
                
                const SizedBox(height: 20),
                
                // Card Detail Ratings
                _buildAnimatedCard(
                  delay: 400,
                  child: _buildDetailRatings(feedback),
                ),
                
                const SizedBox(height: 20),
                
                // Card Saran
                if (feedback.saran.isNotEmpty)
                  _buildAnimatedCard(
                    delay: 600,
                    child: _buildSaranCard(feedback),
                  ),
                
                const SizedBox(height: 30),
                
                // Tombol Kembali
                _buildAnimatedCard(
                  delay: 800,
                  child: _buildBackButton(),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildAnimatedCard({required int delay, required Widget child}) {
    return FadeTransition(
      opacity: _cardAnimationController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _cardAnimationController,
            curve: Interval(
              delay / 1000,
              (delay + 200) / 1000,
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
  
  Widget _buildBiodataCard(feedback) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Data Mahasiswa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.person_outline, 'Nama', feedback.name),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.badge_outlined, 'NIM', feedback.nim),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.school_outlined, 'Prodi', feedback.prodi),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.calendar_today_outlined, 'Semester', '${feedback.semester}'),
        ],
      ),
    );
  }
  
  Widget _buildScoreCard(feedback) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          const Text(
            'Skor Keseluruhan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          
          // Circular progress dengan score
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: feedback.overallAverage / 5,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      feedback.overallAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '/ 5.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: _buildMiniScore(
                  'Fasilitas',
                  feedback.fasilitasAverage,
                  Icons.apartment_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMiniScore(
                  'Layanan',
                  feedback.layananAverage,
                  Icons.support_agent_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildMiniScore(String label, double score, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            score.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRatings(feedback) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lightCyan,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics_rounded,
                  color: AppTheme.primarySoftBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Detail Penilaian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          const Text(
            'Fasilitas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBlue,
            ),
          ),
          const SizedBox(height: 12),
          _buildRatingBar('Perpustakaan', feedback.perpustakaanRating),
          _buildRatingBar('Laboratorium', feedback.labRating),
          _buildRatingBar('Kantin', feedback.kantinRating),
          _buildRatingBar('Toilet', feedback.toiletRating),
          _buildRatingBar('Parkir', feedback.parkirRating),
          
          const SizedBox(height: 20),
          const Text(
            'Layanan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBlue,
            ),
          ),
          const SizedBox(height: 12),
          _buildRatingBar('Dosen', feedback.dosenRating),
          _buildRatingBar('Staff Akademik', feedback.staffRating),
          _buildRatingBar('Administrasi', feedback.administrasiRating),
        ],
      ),
    );
  }
  
  Widget _buildRatingBar(String label, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 18,
                color: AppTheme.accentOrange,
              );
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSaranCard(feedback) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lightCyan,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.feedback_rounded,
                  color: AppTheme.primarySoftBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Saran & Kritik',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.veryLightBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              feedback.saran,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          final provider = Provider.of<FeedbackProvider>(context, listen: false);
          provider.resetFeedback();
          
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.darkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_rounded, size: 24),
            SizedBox(width: 12),
            Text(
              'Kembali ke Beranda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primarySoftBlue),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBlue,
          ),
        ),
      ],
    );
  }
}