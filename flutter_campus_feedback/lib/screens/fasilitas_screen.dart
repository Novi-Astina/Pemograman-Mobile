import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feedback_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/rating_widget.dart';
import 'layanan_screen.dart';

class FasilitasScreen extends StatefulWidget {
  const FasilitasScreen({super.key});

  @override
  State<FasilitasScreen> createState() => _FasilitasScreenState();
}

class _FasilitasScreenState extends State<FasilitasScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penilaian Fasilitas'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            // Header dengan progress
            _buildHeader(),
            
            // Form rating
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: FadeTransition(
                  opacity: _animationController,
                  child: Consumer<FeedbackProvider>(
                    builder: (context, provider, child) {
                      return Column(
                        children: [
                          // Rating Perpustakaan
                          RatingWidget(
                            icon: Icons.local_library_rounded,
                            title: 'Perpustakaan',
                            description: 'Koleksi buku, ruang baca, fasilitas',
                            rating: provider.feedback.perpustakaanRating,
                            onRatingChanged: (rating) {
                              provider.updatePerpustakaanRating(rating);
                            },
                          ),
                          
                          // Rating Laboratorium
                          RatingWidget(
                            icon: Icons.science_rounded,
                            title: 'Laboratorium',
                            description: 'Peralatan lab, kebersihan, kelengkapan',
                            rating: provider.feedback.labRating,
                            onRatingChanged: (rating) {
                              provider.updateLabRating(rating);
                            },
                          ),
                          
                          // Rating Kantin
                          RatingWidget(
                            icon: Icons.restaurant_rounded,
                            title: 'Kantin',
                            description: 'Kebersihan, variasi menu, harga',
                            rating: provider.feedback.kantinRating,
                            onRatingChanged: (rating) {
                              provider.updateKantinRating(rating);
                            },
                          ),
                          
                          // Rating Toilet
                          RatingWidget(
                            icon: Icons.wc_rounded,
                            title: 'Toilet',
                            description: 'Kebersihan, ketersediaan, kelayakan',
                            rating: provider.feedback.toiletRating,
                            onRatingChanged: (rating) {
                              provider.updateToiletRating(rating);
                            },
                          ),
                          
                          // Rating Area Parkir
                          RatingWidget(
                            icon: Icons.local_parking_rounded,
                            title: 'Area Parkir',
                            description: 'Keamanan, kapasitas, kemudahan akses',
                            rating: provider.feedback.parkirRating,
                            onRatingChanged: (rating) {
                              provider.updateParkirRating(rating);
                            },
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // Tombol Lanjut
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validateRatings(provider)) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          const LayananScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Row(
                                        children: [
                                          Icon(Icons.warning_rounded, color: Colors.white),
                                          SizedBox(width: 12),
                                          Text('Mohon isi semua penilaian fasilitas'),
                                        ],
                                      ),
                                      backgroundColor: AppTheme.accentPink,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: const EdgeInsets.all(20),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primarySoftBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lanjut ke Penilaian Layanan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_rounded),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primarySoftBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.apartment_rounded,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          
          // Title
          const Text(
            'Fasilitas Kampus',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          
          // Subtitle
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Berikan penilaian untuk setiap fasilitas',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress indicator
          Consumer<FeedbackProvider>(
            builder: (context, provider, child) {
              int completed = 0;
              if (provider.feedback.perpustakaanRating > 0) completed++;
              if (provider.feedback.labRating > 0) completed++;
              if (provider.feedback.kantinRating > 0) completed++;
              if (provider.feedback.toiletRating > 0) completed++;
              if (provider.feedback.parkirRating > 0) completed++;
              
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        '$completed/5',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: completed / 5,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  bool _validateRatings(FeedbackProvider provider) {
    return provider.feedback.perpustakaanRating > 0 &&
        provider.feedback.labRating > 0 &&
        provider.feedback.kantinRating > 0 &&
        provider.feedback.toiletRating > 0 &&
        provider.feedback.parkirRating > 0;
  }
}