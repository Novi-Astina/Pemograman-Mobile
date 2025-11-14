import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool showShadow;
  
  const LogoWidget({
    super.key,
    this.size = 80,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 40,
      height: size + 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        boxShadow: showShadow ? [
          BoxShadow(
            color: AppTheme.primarySoftBlue.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logouin.jpg',
              width: size,
              height: size,
              fit: BoxFit.contain,
              // Jika logo tidak ditemukan, tampilkan icon default
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.school,
                  size: size * 0.7,
                  color: AppTheme.primarySoftBlue,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Logo kecil untuk header
class SmallLogoWidget extends StatelessWidget {
  const SmallLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primarySoftBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipOval(
          child: Image.asset(
            'assets/images/logouin.jpg',
            width: 34,
            height: 34,
            fit: BoxFit.contain,
            // Fallback ke icon jika logo tidak ada
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.school,
                color: Colors.white,
                size: 28,
              );
            },
          ),
        ),
      ),
    );
  }
}

// Logo untuk splash screen (lebih besar)
class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primarySoftBlue.withOpacity(0.5),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logouin.jpg',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.school,
                  size: 100,
                  color: AppTheme.primarySoftBlue,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}