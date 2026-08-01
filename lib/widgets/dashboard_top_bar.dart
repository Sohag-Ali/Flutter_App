import 'package:flutter/material.dart';

class DashboardTopBarHeader extends StatelessWidget {
  final String location;
  final String farmerName;
  final String weather;
  final double temperature;
  final String selectedFarmId;
  final List<FarmDropdownItem> farms;
  final ValueChanged<String?> onFarmChanged;

  const DashboardTopBarHeader({
    super.key,
    required this.location,
    required this.farmerName,
    required this.weather,
    required this.temperature,
    required this.selectedFarmId,
    required this.farms,
    required this.onFarmChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('মেনু খোলা হয়েছে')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$farmerName-এর স্মার্ট খামার',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$weather ${temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Color(0xFF1E3A27),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedFarmId,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF2E7D32)),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E3A27)),
                items: farms
                    .map(
                      (f) => DropdownMenuItem<String>(
                        value: f.id,
                        child: Text('জমি নির্বাচন: ${f.farmerName}-এর খামার (${f.location})'),
                      ),
                    )
                    .toList(),
                onChanged: onFarmChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FarmDropdownItem {
  final String id;
  final String farmerName;
  final String location;

  const FarmDropdownItem({
    required this.id,
    required this.farmerName,
    required this.location,
  });
}
