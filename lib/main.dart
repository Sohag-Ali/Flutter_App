import 'package:flutter/material.dart';
import 'repositories/sensor_repository.dart';
import 'screens/farmer_dashboard.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthService _authService;
  late final SensorRepository _sensorRepository;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _sensorRepository = SensorRepository();
  }

  @override
  void dispose() {
    _sensorRepository.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'স্মার্ট কৃষি ড্যাশবোর্ড',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF4CAF50),
          surface: const Color(0xFFF6F8F5),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7F2),
        cardColor: Colors.white,
        dividerColor: const Color(0xFFE2E8DF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF7FBF5),
          selectedItemColor: Color(0xFF2E7D32),
          unselectedItemColor: Color(0xFF7D9277),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: const Color(0xFF1E3A27),
              displayColor: const Color(0xFF1E3A27),
            ),
      ),
      home: _isLoggedIn
          ? FarmerDashboard(
              sensorRepository: _sensorRepository,
              onLogout: _handleLogout,
            )
          : LoginPage(
              authService: _authService,
              onLoginSuccess: _handleLogin,
            ),
    );
  }
}
