import 'package:flutter/material.dart';

class GraphTab extends StatefulWidget {
  final VoidCallback onLogout;

  const GraphTab({super.key, required this.onLogout});

  @override
  State<GraphTab> createState() => _GraphTabState();
}

class _GraphTabState extends State<GraphTab> {
  String _selectedMetric = 'আর্দ্রতা';

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
                              'গ্রাফ বিশ্লেষণ',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1E3A27),
                                  ),
                            ),
                            const SizedBox(height: 2),
                            const Text('৭ দিনের পরিবর্তনের গ্রাফ', style: TextStyle(color: Color(0xFF5B6472), fontSize: 12)),
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
                  Row(
                    children: [
                      _MetricChip(
                        label: 'আর্দ্রতা',
                        selected: _selectedMetric == 'আর্দ্রতা',
                        color: const Color(0xFF2196F3),
                        onTap: () => setState(() => _selectedMetric = 'আর্দ্রতা'),
                      ),
                      const SizedBox(width: 8),
                      _MetricChip(
                        label: 'তাপমাত্রা',
                        selected: _selectedMetric == 'তাপমাত্রা',
                        color: const Color(0xFFFF6D00),
                        onTap: () => setState(() => _selectedMetric = 'তাপমাত্রা'),
                      ),
                      const SizedBox(width: 8),
                      _MetricChip(
                        label: 'pH',
                        selected: _selectedMetric == 'pH',
                        color: const Color(0xFF9C27B0),
                        onTap: () => setState(() => _selectedMetric = 'pH'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$_selectedMetric (গত ৭ দিন)', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
                        const SizedBox(height: 16),
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F9F1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(Icons.show_chart_rounded, size: 48, color: Color(0xFF2E7D32)),
                          ),
                        ),
                      ],
                    ),
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

class _MetricChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _MetricChip({required this.label, required this.selected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? color : Colors.white,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF6F7B6F),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
