import 'dart:ui';
import 'package:flutter/material.dart';

class ZodiacBadge extends StatelessWidget {
  final String label;
  final String icon;

  const ZodiacBadge({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // ~blur 50%
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.6),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
