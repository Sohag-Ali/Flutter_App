import 'package:flutter/material.dart';

class PremiumCompostCard extends StatelessWidget {
  final int totalCompostKg;
  final double perSqMeterRate;
  final int soilHealthScore;

  const PremiumCompostCard({
    super.key,
    required this.totalCompostKg,
    required this.perSqMeterRate,
    this.soilHealthScore = 89,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEAF5E9), Color(0xFFD7EBD4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.analytics_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🌱 মাটির স্বাস্থ্য ও কম্পোস্ট সুপারিশ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E3A27),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'স্মার্ট অ্যালগরিদম ভিত্তিক ফলাফল',
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Line 1: 1st Highlight Container - 1st Line: জমির অবস্থা / মাটির স্বাস্থ্য (%)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF81C784).withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.health_and_safety_rounded, color: Color(0xFF2E7D32), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'জমির অবস্থা',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF5B6472)),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'মাটির স্বাস্থ্য: ',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E3A27)),
                          ),
                          Text(
                            '$soilHealthScore%',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2E7D32)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFF81C784)),
                  ),
                  child: const Text(
                    'উত্তম অবস্থা',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32)),
                  ),
                ),
              ],
            ),
          ),

          // Line 2: 2nd Highlight Container - 2nd Line: প্রয়োজনীয় কম্পোস্ট (KG)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.inventory_2_rounded, color: Color(0xFF2E7D32), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'প্রয়োজনীয় কম্পোস্ট',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF5B6472)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$totalCompostKg কেজি',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF2E7D32)),
                      ),
                    ],
                  ),
                ),
                Text(
                  '(${perSqMeterRate.toStringAsFixed(2)} কেজি/মি²)',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
