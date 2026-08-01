import 'package:flutter/material.dart';

class MonitorTab extends StatefulWidget {
  final VoidCallback onLogout;

  const MonitorTab({super.key, required this.onLogout});

  @override
  State<MonitorTab> createState() => _MonitorTabState();
}

class _MonitorTabState extends State<MonitorTab> {
  int _tabIndex = 0;

  static const List<_MonitorSensor> _liveSensors = [
    _MonitorSensor(title: 'আর্দ্রতা', value: '72', unit: '%', icon: Icons.water_drop_rounded, color: Color(0xFF2196F3)),
    _MonitorSensor(title: 'তাপমাত্রা', value: '28.9', unit: '°C', icon: Icons.thermostat_rounded, color: Color(0xFFFF6D00)),
    _MonitorSensor(title: 'pH মাত্রা', value: '6.4', unit: '', icon: Icons.science_rounded, color: Color(0xFF9C27B0)),
    _MonitorSensor(title: 'নাইট্রোজেন', value: '76', unit: 'ppm', icon: Icons.eco_rounded, color: Color(0xFF4CAF50)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF1F7EB), Color(0xFFDDECD4), Color(0xFFF7FBF5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'পর্যবেক্ষণ',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                const Text('উত্তর মাঠ · ৩টি জমি যুক্ত', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onLogout,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.logout, size: 14, color: Color(0xFFEF5350)),
                                  SizedBox(width: 4),
                                  Text('লগআউট', style: TextStyle(color: Color(0xFFEF5350), fontWeight: FontWeight.w700, fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _tabIndex = 0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _tabIndex == 0 ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text('লাইভ', textAlign: TextAlign.center, style: TextStyle(color: _tabIndex == 0 ? const Color(0xFF2E7D32) : Colors.white, fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _tabIndex = 1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _tabIndex == 1 ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text('তুলনা', textAlign: TextAlign.center, style: TextStyle(color: _tabIndex == 1 ? const Color(0xFF2E7D32) : Colors.white, fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._liveSensors.map((sensor) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: sensor.color.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(sensor.icon, color: sensor.color, size: 24),
                                  const SizedBox(width: 12),
                                  Text(sensor.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                                  const Spacer(),
                                  Text('${sensor.value}${sensor.unit}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: sensor.color)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonitorSensor {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _MonitorSensor({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
}
