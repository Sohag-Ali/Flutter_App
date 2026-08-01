import 'package:flutter/material.dart';
import '../repositories/sensor_repository.dart';
import 'alerts_tab.dart';
import 'graph_tab.dart';
import 'home_tab.dart';
import 'monitor_tab.dart';
import 'profile_tab.dart';

class FarmerDashboard extends StatefulWidget {
  final SensorRepository sensorRepository;
  final VoidCallback onLogout;

  const FarmerDashboard({
    super.key,
    required this.sensorRepository,
    required this.onLogout,
  });

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeTab(sensorRepository: widget.sensorRepository, onLogout: widget.onLogout),
      MonitorTab(onLogout: widget.onLogout),
      GraphTab(onLogout: widget.onLogout),
      AlertsTab(onLogout: widget.onLogout),
      ProfileTab(onLogout: widget.onLogout),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7FBF5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2E7D32),
          unselectedItemColor: const Color(0xFF7B8794),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'হোম'),
            BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined), activeIcon: Icon(Icons.monitor_heart_rounded), label: 'পর্যবেক্ষণ'),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart_outlined), activeIcon: Icon(Icons.show_chart_rounded), label: 'গ্রাফ'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), activeIcon: Icon(Icons.notifications_rounded), label: 'সতর্কতা'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'প্রোফাইল'),
          ],
        ),
      ),
    );
  }
}
