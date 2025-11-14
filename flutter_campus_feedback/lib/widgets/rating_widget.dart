import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class RatingWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int rating;
  final Function(int) onRatingChanged;

  const RatingWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _hoveredStar;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan icon dan judul
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primarySoftBlue.withOpacity(0.2),
                      AppTheme.lightCyan,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.icon,
                  color: AppTheme.primarySoftBlue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.lightCyan,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Rating stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              final isSelected = starNumber <= widget.rating;
              final isHovered = _hoveredStar != null && starNumber <= _hoveredStar!;
              
              return GestureDetector(
                onTap: () {
                  widget.onRatingChanged(starNumber);
                  _controller.forward().then((_) => _controller.reverse());
                },
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredStar = starNumber),
                  onExit: (_) => setState(() => _hoveredStar = null),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedScale(
                      scale: (isSelected || isHovered) ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 44,
                        color: isSelected || isHovered 
                            ? AppTheme.accentOrange 
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          
          // Label rating
          if (widget.rating > 0) ...[
            const SizedBox(height: 16),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getRatingColor(widget.rating).withOpacity(0.2),
                      _getRatingColor(widget.rating).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getRatingColor(widget.rating).withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getRatingIcon(widget.rating),
                      size: 20,
                      color: _getRatingColor(widget.rating),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getRatingText(widget.rating),
                      style: TextStyle(
                        fontSize: 14,
                        color: _getRatingColor(widget.rating),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  // Mendapatkan text label berdasarkan rating
  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Sangat Tidak Puas';
      case 2:
        return 'Tidak Puas';
      case 3:
        return 'Cukup';
      case 4:
        return 'Puas';
      case 5:
        return 'Sangat Puas';
      default:
        return '';
    }
  }
  
  // Mendapatkan icon berdasarkan rating
  IconData _getRatingIcon(int rating) {
    switch (rating) {
      case 1:
        return Icons.sentiment_very_dissatisfied;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
        return Icons.sentiment_satisfied;
      case 5:
        return Icons.sentiment_very_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
  
  // Mendapatkan warna berdasarkan rating
  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
        return AppTheme.accentPink;
      case 2:
        return Colors.orange;
      case 3:
        return AppTheme.accentOrange;
      case 4:
        return AppTheme.primarySoftBlue;
      case 5:
        return AppTheme.accentGreen;
      default:
        return Colors.grey;
    }
  }
}