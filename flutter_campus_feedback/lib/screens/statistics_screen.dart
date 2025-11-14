import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feedback_provider.dart';
import '../utils/app_theme.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik & Analisis'),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Consumer<FeedbackProvider>(
          builder: (context, provider, child) {
            if (provider.feedbackHistory.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.analytics_outlined,
                      size: 100,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Belum ada data statistik',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Isi kuesioner untuk melihat statistik',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }
            
            // Hitung statistik
            final totalFeedback = provider.feedbackHistory.length;
            double avgFasilitas = 0;
            double avgLayanan = 0;
            double avgOverall = 0;
            
            for (var feedback in provider.feedbackHistory) {
              avgFasilitas += feedback.fasilitasAverage;
              avgLayanan += feedback.layananAverage;
              avgOverall += feedback.overallAverage;
            }
            
            avgFasilitas /= totalFeedback;
            avgLayanan /= totalFeedback;
            avgOverall /= totalFeedback;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  _buildHeaderCard(totalFeedback, avgOverall),
                  
                  const SizedBox(height: 24),
                  
                  // Average Ratings
                  const Text(
                    'Rata-rata Penilaian',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildRatingCard(
                    'Fasilitas',
                    avgFasilitas,
                    Icons.apartment,
                    AppTheme.primarySoftBlue,
                  ),
                  const SizedBox(height: 12),
                  
                  _buildRatingCard(
                    'Layanan',
                    avgLayanan,
                    Icons.support_agent,
                    AppTheme.accentBlue,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Detailed Statistics
                  const Text(
                    'Statistik Detail',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildDetailedStats(provider),
                  
                  const SizedBox(height: 24),
                  
                  // Rating Distribution
                  _buildRatingDistribution(provider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildHeaderCard(int total, double avg) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            Icons.assignment_turned_in,
            '$total',
            'Total Feedback',
          ),
          Container(
            width: 1,
            height: 60,
            color: Colors.white.withOpacity(0.3),
          ),
          _buildStatColumn(
            Icons.star_rounded,
            avg.toStringAsFixed(1),
            'Rata-rata',
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 36),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
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
    );
  }
  
  Widget _buildRatingCard(String title, double rating, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: rating / 5,
                          minHeight: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailedStats(FeedbackProvider provider) {
    // Hitung rata-rata untuk setiap item
    Map<String, double> stats = {};
    
    for (var feedback in provider.feedbackHistory) {
      stats['Perpustakaan'] = (stats['Perpustakaan'] ?? 0) + feedback.perpustakaanRating;
      stats['Laboratorium'] = (stats['Laboratorium'] ?? 0) + feedback.labRating;
      stats['Kantin'] = (stats['Kantin'] ?? 0) + feedback.kantinRating;
      stats['Toilet'] = (stats['Toilet'] ?? 0) + feedback.toiletRating;
      stats['Parkir'] = (stats['Parkir'] ?? 0) + feedback.parkirRating;
      stats['Dosen'] = (stats['Dosen'] ?? 0) + feedback.dosenRating;
      stats['Staff'] = (stats['Staff'] ?? 0) + feedback.staffRating;
      stats['Administrasi'] = (stats['Administrasi'] ?? 0) + feedback.administrasiRating;
    }
    
    stats.forEach((key, value) {
      stats[key] = value / provider.feedbackHistory.length;
    });
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stats.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildStatBar(entry.key, entry.value),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildStatBar(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkBlue,
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primarySoftBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 5,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getColorForRating(value),
            ),
          ),
        ),
      ],
    );
  }
  
  Color _getColorForRating(double rating) {
    if (rating >= 4.0) return AppTheme.accentGreen;
    if (rating >= 3.0) return AppTheme.primarySoftBlue;
    if (rating >= 2.0) return AppTheme.accentOrange;
    return AppTheme.accentPink;
  }
  
  Widget _buildRatingDistribution(FeedbackProvider provider) {
    // Hitung distribusi rating
    Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    
    for (var feedback in provider.feedbackHistory) {
      int rating = feedback.overallAverage.round();
      distribution[rating] = (distribution[rating] ?? 0) + 1;
    }
    
    int maxCount = distribution.values.reduce((a, b) => a > b ? a : b);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Distribusi Rating',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBlue,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(5, (index) {
            int stars = 5 - index;
            int count = distribution[stars] ?? 0;
            double percentage = maxCount > 0 ? count / maxCount : 0;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      stars,
                      (i) => const Icon(
                        Icons.star,
                        size: 16,
                        color: AppTheme.accentOrange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: percentage,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.primarySoftBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBlue,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}