import 'package:flutter/material.dart';

class AlertsTab extends StatefulWidget {
  final VoidCallback onLogout;

  const AlertsTab({super.key, required this.onLogout});

  @override
  State<AlertsTab> createState() => _AlertsTabState();
}

class _AlertsTabState extends State<AlertsTab> {
  final List<_AlertItem> _alerts = const [
    _AlertItem(
      id: 'low-phosphorus',
      title: 'ফসফরাস কম — উত্তর মাঠ',
      message: 'মাত্রা ২৮ ppm-এ নেমেছে। সার প্রয়োগ বিবেচনা করুন।',
      color: Color(0xFFE45B5B),
      icon: Icons.water_drop_rounded,
    ),
    _AlertItem(
      id: 'high-moisture',
      title: 'উচ্চ আর্দ্রতা — দক্ষিণ মাঠ',
      message: 'আর্দ্রতা ৮৯%। নিষ্কাশন ব্যবস্থা না থাকলে মূল পচনের ঝুঁকি।',
      color: Color(0xFFC97A1F),
      icon: Icons.water_rounded,
    ),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
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
                              'সতর্কতা',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1E3A27),
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text('${_alerts.length}টি সক্রিয় সতর্কতা', style: const TextStyle(color: Color(0xFF5B6472), fontSize: 12)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onLogout,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0xFFEF5350).withValues(alpha: 0.5)),
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
                  const SizedBox(height: 16),
                  Column(
                    children: _alerts
                        .map((alert) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Icon(alert.icon, color: alert.color, size: 24),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(alert.title, style: TextStyle(fontWeight: FontWeight.w800, color: alert.color)),
                                        const SizedBox(height: 2),
                                        Text(alert.message, style: const TextStyle(fontSize: 12, color: Color(0xFF5B6472))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertItem {
  final String id;
  final String title;
  final String message;
  final Color color;
  final IconData icon;

  const _AlertItem({
    required this.id,
    required this.title,
    required this.message,
    required this.color,
    required this.icon,
  });
}
