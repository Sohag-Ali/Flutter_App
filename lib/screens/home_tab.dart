import 'package:flutter/material.dart';
import '../repositories/sensor_repository.dart';
import '../widgets/dashboard_top_bar.dart';
import '../widgets/premium_compost_card.dart';
import '../widgets/sensor_card.dart';

class HomeTab extends StatefulWidget {
  final SensorRepository sensorRepository;
  final VoidCallback onLogout;

  const HomeTab({
    super.key,
    required this.sensorRepository,
    required this.onLogout,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _selectedFarmId = 'rahim';

  final List<FarmDropdownItem> _farms = const [
    FarmDropdownItem(id: 'rahim', farmerName: 'রহিম', location: 'গাজীপুর'),
    FarmDropdownItem(id: 'nila', farmerName: 'নীলা', location: 'সাভার'),
    FarmDropdownItem(id: 'sabbir', farmerName: 'সাব্বির', location: 'ময়মনসিংহ'),
  ];

  @override
  void initState() {
    super.initState();
    // Start 30s auto-refresh timer and fetch initial data
    widget.sensorRepository.startAutoRefresh();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.sensorRepository.fetchSensorData(showLoadingIndicator: true);
    });
  }

  FarmDropdownItem get _selectedFarm =>
      _farms.firstWhere((f) => f.id == _selectedFarmId, orElse: () => _farms.first);

  Future<void> _handleRefresh() async {
    await widget.sensorRepository.fetchSensorData(showLoadingIndicator: false);
  }

  @override
  Widget build(BuildContext context) {
    final farm = _selectedFarm;

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
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: const Color(0xFF2E7D32),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Section Header
                    DashboardTopBarHeader(
                      location: farm.location,
                      farmerName: farm.farmerName,
                      weather: '☀️ রৌদ্রোজ্জ্বল',
                      temperature: 31.5,
                      selectedFarmId: _selectedFarmId,
                      farms: _farms,
                      onFarmChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedFarmId = val);
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // Section Header with Live Update Time
                    ListenableBuilder(
                      listenable: widget.sensorRepository,
                      builder: (context, _) {
                        final lastTime = widget.sensorRepository.lastRefreshed;
                        final formattedTime = lastTime != null
                            ? '${lastTime.hour.toString().padLeft(2, '0')}:${lastTime.minute.toString().padLeft(2, '0')}:${lastTime.second.toString().padLeft(2, '0')}'
                            : '';

                        return Row(
                          children: [
                            const Text(
                              'সেন্সর প্যারামিটার (৮টি)',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E3A27)),
                            ),
                            const Spacer(),
                            if (formattedTime.isNotEmpty)
                              Text(
                                'আপডেট: $formattedTime (৩০ সে. পর পর অটো)',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF5B6472)),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Live Sensor Cards Grid with State Handling
                    ListenableBuilder(
                      listenable: widget.sensorRepository,
                      builder: (context, _) {
                        final repo = widget.sensorRepository;

                        if (repo.isLoading) {
                          return Container(
                            height: 220,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Color(0xFF2E7D32)),
                                SizedBox(height: 14),
                                Text('লাইভ সেন্সর তথ্য লোড করা হচ্ছে...', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
                              ],
                            ),
                          );
                        }

                        if (repo.isError) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFEF5350).withValues(alpha: 0.4)),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.error_outline_rounded, color: Color(0xFFEF5350), size: 42),
                                const SizedBox(height: 10),
                                const Text(
                                  'তথ্য লোড করতে সমস্যা হয়েছে!',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E3A27)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  repo.errorMessage.isNotEmpty
                                      ? repo.errorMessage
                                      : 'ইন্টারনেট বা API সংযোগ পরীক্ষা করুন।',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () => repo.fetchSensorData(showLoadingIndicator: true),
                                  icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
                                  label: const Text('আবার চেষ্টা করুন', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E7D32),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final metrics = repo.metrics;

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: metrics.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, index) {
                                final metric = metrics[index];
                                return SensorCard(
                                  icon: metric.icon,
                                  value: metric.value,
                                  unit: metric.unit,
                                  title: metric.title,
                                  color: metric.color,
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${metric.title}: ${metric.value}${metric.unit}')),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Compost & Soil Health Recommendation Summary Card
                    ListenableBuilder(
                      listenable: widget.sensorRepository,
                      builder: (context, _) {
                        return const PremiumCompostCard(
                          totalCompostKg: 1175,
                          perSqMeterRate: 2.35,
                          soilHealthScore: 89,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
