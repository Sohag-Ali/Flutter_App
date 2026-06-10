import 'package:flutter/material.dart';

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
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
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
      title: 'Soil Monitoring',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F6B3D),
          brightness: Brightness.light,
          primary: const Color(0xFF2F6B3D),
          secondary: const Color(0xFF5E8F4B),
          tertiary: const Color(0xFF8CAA5A),
          surface: const Color(0xFFF8FAF4),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F7EE),
        cardColor: const Color(0xFFF8FBF5),
        dividerColor: const Color(0xFFD9E6D0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF7FBF5),
          selectedItemColor: Color(0xFF2F6B3D),
          unselectedItemColor: Color(0xFF7D9277),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: const Color(0xFF203326),
              displayColor: const Color(0xFF203326),
            ),
      ),
      home: _isLoggedIn
          ? _FarmerDashboard(onLogout: _handleLogout)
          : LoginPage(authService: _authService, onLoginSuccess: _handleLogin),
    );
  }
}

class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> signup(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return email.isNotEmpty;
  }
}

class FieldItem {
  final String id;
  final String name;

  const FieldItem({required this.id, required this.name});
}

class FieldService extends ChangeNotifier {
  FieldService._();

  static final FieldService _instance = FieldService._();

  factory FieldService() => _instance;

  final List<FieldItem> _fields = <FieldItem>[
    const FieldItem(id: 'field-1', name: 'Field 1'),
    const FieldItem(id: 'field-2', name: 'Field 2'),
  ];

  List<FieldItem> get fields => List.unmodifiable(_fields);

  void addField(FieldItem field) {
    _fields.add(field);
    notifyListeners();
  }

  void removeField(String id) {
    _fields.removeWhere((field) => field.id == id);
    notifyListeners();
  }
}

class FriendMetric {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const FriendMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
}

class FriendProfile {
  final String name;
  final String location;
  final String weather;
  final String weatherSummary;
  final double temperatureC;
  final double moisture;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double ph;
  final double humidity;
  final double sunlight;

  const FriendProfile({
    required this.name,
    required this.location,
    required this.weather,
    required this.weatherSummary,
    required this.temperatureC,
    required this.moisture,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.ph,
    required this.humidity,
    required this.sunlight,
  });

  String get temperatureLabel => '${temperatureC.toStringAsFixed(0)}°C';

  List<FriendMetric> get metrics => [
        FriendMetric(
          title: 'Moisture',
          value: moisture.toStringAsFixed(0),
          unit: '%',
          icon: Icons.water_drop_outlined,
          color: const Color(0xFF2C7BE5),
        ),
        FriendMetric(
          title: 'Temperature',
          value: temperatureC.toStringAsFixed(1),
          unit: '°C',
          icon: Icons.thermostat_outlined,
          color: const Color(0xFFE06C4C),
        ),
        FriendMetric(
          title: 'pH',
          value: ph.toStringAsFixed(1),
          unit: '',
          icon: Icons.science_outlined,
          color: const Color(0xFF8E5CF7),
        ),
        FriendMetric(
          title: 'Nitrogen',
          value: nitrogen.toStringAsFixed(0),
          unit: 'ppm',
          icon: Icons.eco_outlined,
          color: const Color(0xFF4E8F50),
        ),
        FriendMetric(
          title: 'Phosphorus',
          value: phosphorus.toStringAsFixed(0),
          unit: 'ppm',
          icon: Icons.grass_outlined,
          color: const Color(0xFFF0A202),
        ),
        FriendMetric(
          title: 'Potassium',
          value: potassium.toStringAsFixed(0),
          unit: 'ppm',
          icon: Icons.agriculture_outlined,
          color: const Color(0xFF00897B),
        ),
        FriendMetric(
          title: 'Humidity',
          value: humidity.toStringAsFixed(0),
          unit: '%',
          icon: Icons.cloud_outlined,
          color: const Color(0xFF64748B),
        ),
        FriendMetric(
          title: 'Sunlight',
          value: sunlight.toStringAsFixed(0),
          unit: 'hrs',
          icon: Icons.wb_sunny_outlined,
          color: const Color(0xFFEA9C2D),
        ),
      ];
}

InputDecoration _inputDecoration(String hint, IconData icon, {Widget? suffix}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    suffixIcon: suffix,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFD5E4CC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF2F6B3D)),
    ),
  );
}

class LoginPage extends StatefulWidget {
  final AuthService authService;
  final VoidCallback onLoginSuccess;

  const LoginPage({
    super.key,
    required this.authService,
    required this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    final success = await widget.authService.login(
      _emailController.text,
      _passwordController.text,
    );
    setState(() => _isLoading = false);

    if (success) {
      widget.onLoginSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Check credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Welcome Back', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.6)),
                  const SizedBox(height: 8),
                  Text('Sign in to monitor your soil health', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF5B6472))),
                  const SizedBox(height: 36),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: _inputDecoration('Email address', Icons.email_outlined)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration(
                      'Password',
                      Icons.lock_outlined,
                      suffix: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(authService: widget.authService),
                            ),
                          );
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6B48),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Container(height: 1, color: const Color(0xFFE9E4D8))),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or')),
                      Expanded(child: Container(height: 1, color: const Color(0xFFE9E4D8))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(
                              authService: widget.authService,
                              onSignupSuccess: widget.onLoginSuccess,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE9E4D8)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Create an Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  final AuthService authService;
  final VoidCallback onSignupSuccess;

  const SignupPage({
    super.key,
    required this.authService,
    required this.onSignupSuccess,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => _isLoading = true);
    final success = await widget.authService.signup(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success) {
      widget.onSignupSuccess();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Create Account'),
      ),
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Join Our Community', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('Create your account to start monitoring soil health', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472))),
                  const SizedBox(height: 24),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: _inputDecoration('Email address', Icons.email_outlined)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration(
                      'Password',
                      Icons.lock_outlined,
                      suffix: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: _confirmPasswordController, obscureText: _obscurePassword, decoration: _inputDecoration('Confirm password', Icons.lock_outlined)),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6B48),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  final AuthService authService;

  const ForgotPasswordPage({super.key, required this.authService});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _resetSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    setState(() => _isLoading = true);
    final success = await widget.authService.resetPassword(_emailController.text);
    setState(() {
      _isLoading = false;
      _resetSent = success;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent to your email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Reset Password'),
      ),
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Forgot Your Password?', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  Text(
                    'Enter your email address and we\'ll send you a link to reset your password.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472), height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, enabled: !_resetSent, decoration: _inputDecoration('Email address', Icons.email_outlined)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _resetSent || _isLoading ? null : _handleReset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6B48),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Text(_resetSent ? 'Link Sent' : 'Send Reset Link', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                  if (_resetSent) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFFD4EDDA), borderRadius: BorderRadius.circular(12)),
                      child: const Text('Check your email for the password reset link. It may take a few minutes to arrive.', style: TextStyle(color: Color(0xFF155724))),
                    ),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _RoleDashboardScaffold extends StatelessWidget {
  final Widget child;
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _RoleDashboardScaffold({required this.child, required this.items, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(child: child),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3E6B48),
        unselectedItemColor: const Color(0xFF7B8794),
        items: items,
      ),
    );
  }
}

class _FarmerDashboard extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerDashboard({required this.onLogout});

  @override
  State<_FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<_FarmerDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _FarmerHomeTab(onLogout: widget.onLogout),
      _FarmerMonitorTab(onLogout: widget.onLogout),
      _FarmerGraphTab(onLogout: widget.onLogout),
      _FarmerAlertsTab(onLogout: widget.onLogout),
      _FarmerProfileTab(onLogout: widget.onLogout),
    ];

    return _RoleDashboardScaffold(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined), activeIcon: Icon(Icons.monitor_heart), label: 'Monitor'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart_outlined), activeIcon: Icon(Icons.show_chart), label: 'Graph'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), activeIcon: Icon(Icons.notifications), label: 'Alerts'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
      ],
      child: IndexedStack(index: _currentIndex, children: pages),
    );
  }
}

class _FarmerHomeTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerHomeTab({required this.onLogout});

  @override
  State<_FarmerHomeTab> createState() => _FarmerHomeTabState();
}

class _FarmerHomeTabState extends State<_FarmerHomeTab> {
  final TextEditingController _landAreaController = TextEditingController();
  final List<_FriendData> _friends = const [
    _FriendData(
      id: 'rahim',
      name: 'Rahim',
      location: 'Dhaka',
      weather: 'Sunny',
      temperature: 32,
      humidity: 58,
      compostPerSqFt: 0.42,
      metrics: [
        _FriendMetric('Moisture', '64', '%', Icons.water_drop_outlined, Color(0xFF2C7BE5)),
        _FriendMetric('Temperature', '31.5', 'C', Icons.thermostat_outlined, Color(0xFFE06C4C)),
        _FriendMetric('pH Level', '6.7', '', Icons.science_outlined, Color(0xFF8E5CF7)),
        _FriendMetric('Nitrogen', '82', 'ppm', Icons.eco_outlined, Color(0xFF4E8F50)),
        _FriendMetric('Phosphorus', '41', 'ppm', Icons.grass_outlined, Color(0xFFF0A202)),
        _FriendMetric('Potassium', '57', 'ppm', Icons.agriculture_outlined, Color(0xFF00897B)),
        _FriendMetric('Humidity', '58', '%', Icons.cloud_outlined, Color(0xFF6C63FF)),
        _FriendMetric('Soil Score', '78', '/100', Icons.assessment_outlined, Color(0xFF2F6B3D)),
      ],
    ),
    _FriendData(
      id: 'nila',
      name: 'Nila',
      location: 'Gazipur',
      weather: 'Cloudy',
      temperature: 29,
      humidity: 64,
      compostPerSqFt: 0.36,
      metrics: [
        _FriendMetric('Moisture', '72', '%', Icons.water_drop_outlined, Color(0xFF2C7BE5)),
        _FriendMetric('Temperature', '28.9', 'C', Icons.thermostat_outlined, Color(0xFFE06C4C)),
        _FriendMetric('pH Level', '6.4', '', Icons.science_outlined, Color(0xFF8E5CF7)),
        _FriendMetric('Nitrogen', '76', 'ppm', Icons.eco_outlined, Color(0xFF4E8F50)),
        _FriendMetric('Phosphorus', '39', 'ppm', Icons.grass_outlined, Color(0xFFF0A202)),
        _FriendMetric('Potassium', '52', 'ppm', Icons.agriculture_outlined, Color(0xFF00897B)),
        _FriendMetric('Humidity', '64', '%', Icons.cloud_outlined, Color(0xFF6C63FF)),
        _FriendMetric('Soil Score', '72', '/100', Icons.assessment_outlined, Color(0xFF2F6B3D)),
      ],
    ),
    _FriendData(
      id: 'sabbir',
      name: 'Sabbir',
      location: 'Mymensingh',
      weather: 'Light Rain',
      temperature: 27,
      humidity: 71,
      compostPerSqFt: 0.48,
      metrics: [
        _FriendMetric('Moisture', '59', '%', Icons.water_drop_outlined, Color(0xFF2C7BE5)),
        _FriendMetric('Temperature', '27.3', 'C', Icons.thermostat_outlined, Color(0xFFE06C4C)),
        _FriendMetric('pH Level', '6.2', '', Icons.science_outlined, Color(0xFF8E5CF7)),
        _FriendMetric('Nitrogen', '68', 'ppm', Icons.eco_outlined, Color(0xFF4E8F50)),
        _FriendMetric('Phosphorus', '37', 'ppm', Icons.grass_outlined, Color(0xFFF0A202)),
        _FriendMetric('Potassium', '46', 'ppm', Icons.agriculture_outlined, Color(0xFF00897B)),
        _FriendMetric('Humidity', '71', '%', Icons.cloud_outlined, Color(0xFF6C63FF)),
        _FriendMetric('Soil Score', '69', '/100', Icons.assessment_outlined, Color(0xFF2F6B3D)),
      ],
    ),
  ];

  String _selectedFriendId = 'rahim';
  String? _compositionResult;

  @override
  void dispose() {
    _landAreaController.dispose();
    super.dispose();
  }

  _FriendData get _selectedFriend => _friends.firstWhere((friend) => friend.id == _selectedFriendId, orElse: () => _friends.first);

  void _calculateComposition() {
    final landArea = double.tryParse(_landAreaController.text.trim());
    if (landArea == null || landArea <= 0) {
      setState(() {
        _compositionResult = 'Please enter a valid land size.';
      });
      return;
    }

    final compostAmount = landArea * _selectedFriend.compostPerSqFt;
    setState(() {
      _compositionResult = '${_selectedFriend.name} er ${landArea.toStringAsFixed(0)} sq ft land er jonno ${compostAmount.toStringAsFixed(2)} kg compost lagbe.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final friend = _selectedFriend;

    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        tooltip: 'Menu',
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              friend.location,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Home dashboard',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.wb_sunny_outlined, size: 18, color: Color(0xFFE67E22)),
                            const SizedBox(width: 6),
                            Text(
                              '${friend.weather} ${friend.temperature.toStringAsFixed(0)}°C',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Selected Friend', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF6B7280))),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedFriendId,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF8FAF4),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          ),
                          items: _friends
                              .map(
                                (friendItem) => DropdownMenuItem<String>(
                                  value: friendItem.id,
                                  child: Text('${friendItem.name} - ${friendItem.location}'),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedFriendId = value;
                              _compositionResult = null;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${friend.name} er current weather: ${friend.weather}, humidity ${friend.humidity}%',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friend.metrics.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.06,
                    ),
                    itemBuilder: (context, index) {
                      return _FriendMetricCard(metric: friend.metrics[index]);
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calculate_outlined, color: Color(0xFF2F6B3D)),
                            SizedBox(width: 8),
                            Text('Compost Calculator', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Selected friend er soil data diye land er square onujayi compost amount calculate korun.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _landAreaController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Land size (sq ft)',
                            prefixIcon: const Icon(Icons.square_foot_outlined),
                            filled: true,
                            fillColor: const Color(0xFFF8FAF4),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _calculateComposition,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6B3D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text('Enter', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        if (_compositionResult != null) ...[
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F7EE),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFDDE8D4)),
                            ),
                            child: Text(
                              _compositionResult!,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF23412B), height: 1.4),
                            ),
                          ),
                        ],
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

class _FriendData {
  final String id;
  final String name;
  final String location;
  final String weather;
  final double temperature;
  final int humidity;
  final double compostPerSqFt;
  final List<_FriendMetric> metrics;

  const _FriendData({
    required this.id,
    required this.name,
    required this.location,
    required this.weather,
    required this.temperature,
    required this.humidity,
    required this.compostPerSqFt,
    required this.metrics,
  });
}

class _FriendMetric {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _FriendMetric(this.title, this.value, this.unit, this.icon, this.color);
}

class _FriendMetricCard extends StatelessWidget {
  final _FriendMetric metric;

  const _FriendMetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: metric.color.withOpacity(0.18)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: metric.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(metric.icon, color: metric.color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(metric.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2E25))),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(metric.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: metric.color, height: 1)),
              if (metric.unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(metric.unit, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: metric.color.withOpacity(0.72))),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _FarmerMonitorTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerMonitorTab({required this.onLogout});

  @override
  State<_FarmerMonitorTab> createState() => _FarmerMonitorTabState();
}

class _FarmerMonitorTabState extends State<_FarmerMonitorTab> {
  String? _selectedFieldId;

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'Monitor',
      subtitle: 'Soil monitoring data for each field',
      onLogout: widget.onLogout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: FieldService(),
            builder: (context, _) {
              final fields = FieldService().fields;
              if (fields.isEmpty) {
                return const _InfoCard(title: 'Live sensors', subtitle: 'No fields added yet.', icon: Icons.sensors_outlined, fullWidth: true);
              }

              if (_selectedFieldId == null && fields.isNotEmpty) {
                _selectedFieldId = fields.first.id;
              }

              final selected = fields.firstWhere((f) => f.id == _selectedFieldId, orElse: () => fields.first);

              final metrics = [
                const SoilMetric(title: 'Moisture', value: '64', unit: '%', icon: Icons.water_drop_outlined, color: Color(0xFF2C7BE5), note: 'Ideal for growth'),
                const SoilMetric(title: 'Temperature', value: '24.6', unit: 'C', icon: Icons.thermostat_outlined, color: Color(0xFFE06C4C), note: 'Stable'),
                const SoilMetric(title: 'pH Level', value: '6.8', unit: '', icon: Icons.science_outlined, color: Color(0xFF8E5CF7), note: 'Slightly acidic'),
                const SoilMetric(title: 'Nitrogen', value: '82', unit: 'ppm', icon: Icons.eco_outlined, color: Color(0xFF4E8F50), note: 'Sufficient'),
                const SoilMetric(title: 'Phosphorus', value: '41', unit: 'ppm', icon: Icons.grass_outlined, color: Color(0xFFF0A202), note: 'Moderate'),
                const SoilMetric(title: 'Potassium', value: '57', unit: 'ppm', icon: Icons.agriculture_outlined, color: Color(0xFF00897B), note: 'Balanced'),
              ];
              final recommendation = _buildCompostRecommendation(metrics);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Selected field:', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedFieldId,
                        items: fields.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name))).toList(),
                        onChanged: (v) => setState(() => _selectedFieldId = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(title: 'Live sensors', subtitle: 'Showing live soil data for ${selected.name}', icon: Icons.sensors_outlined, fullWidth: true),
                  const SizedBox(height: 8),
                  _InfoCard(title: 'Field status', subtitle: 'Healthy profile and stable irrigation signals.', icon: Icons.check_circle_outline, fullWidth: true),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: metrics.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.96,
                    ),
                    itemBuilder: (context, index) => SoilMetricCard(metric: metrics[index]),
                  ),
                  const SizedBox(height: 12),
                  _CompostRecommendationCard(recommendation: recommendation),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          const _InfoCard(title: 'Irrigation window', subtitle: 'Next optimal watering window is 6:00 PM.', icon: Icons.water_drop_outlined, fullWidth: true),
        ],
      ),
    );
  }
}

class _FarmerGraphTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerGraphTab({required this.onLogout});

  @override
  State<_FarmerGraphTab> createState() => _FarmerGraphTabState();
}

class _FarmerGraphTabState extends State<_FarmerGraphTab> {
  String? _selectedFieldId;

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'Graph',
      subtitle: 'Condition trend graph for each field',
      onLogout: widget.onLogout,
      child: AnimatedBuilder(
        animation: FieldService(),
        builder: (context, _) {
          final fields = FieldService().fields;
          if (fields.isEmpty) {
            return const _InfoCard(
              title: 'No fields yet',
              subtitle: 'Add a field on the Home page to start showing graph data.',
              icon: Icons.show_chart_outlined,
              fullWidth: true,
            );
          }

          _selectedFieldId ??= fields.first.id;
          final selectedField = fields.firstWhere((field) => field.id == _selectedFieldId, orElse: () => fields.first);

          final conditionPoints = <double>[58, 62, 61, 67, 70, 74, 78];
          final moisturePoints = <double>[48, 51, 53, 55, 57, 60, 63];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Selected field:', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _selectedFieldId,
                    items: fields.map((field) => DropdownMenuItem(value: field.id, child: Text(field.name))).toList(),
                    onChanged: (value) => setState(() => _selectedFieldId = value),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: 'Condition overview',
                subtitle: 'Trend line for ${selectedField.name} over the last 7 days.',
                icon: Icons.show_chart_outlined,
                fullWidth: true,
              ),
              const SizedBox(height: 12),
              _ConditionGraphCard(
                title: 'Soil condition score',
                color: const Color(0xFF2F6B3D),
                points: conditionPoints,
                labels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              ),
              const SizedBox(height: 12),
              _ConditionGraphCard(
                title: 'Moisture trend',
                color: const Color(0xFF2C7BE5),
                points: moisturePoints,
                labels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(child: _SummaryTile(label: 'Weekly rise', value: '+20%', icon: Icons.trending_up, color: Color(0xFF2F6B3D))),
                  SizedBox(width: 12),
                  Expanded(child: _SummaryTile(label: 'Average score', value: '68', icon: Icons.analytics_outlined, color: Color(0xFF2C7BE5))),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FarmerAlertsTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _FarmerAlertsTab({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'Alerts',
      subtitle: 'Action items for soil and weather changes',
      onLogout: onLogout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _InfoCard(title: 'Low moisture alert', subtitle: 'Moisture dropped below threshold in sector B.', icon: Icons.warning_amber_outlined, fullWidth: true),
          SizedBox(height: 12),
          _InfoCard(title: 'Compost reminder', subtitle: 'Apply compost within 48 hours for best uptake.', icon: Icons.recycling_outlined, fullWidth: true),
        ],
      ),
    );
  }
}

class _FarmerProfileTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _FarmerProfileTab({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'Farmer Profile',
      subtitle: 'Farmer account and field summary',
      onLogout: onLogout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _InfoCard(title: 'Account', subtitle: 'Signed in and ready to use.', icon: Icons.verified_user_outlined, fullWidth: true),
          SizedBox(height: 12),
          _InfoCard(title: 'Farm Plot A12', subtitle: 'Role-specific profile detail', icon: Icons.chevron_right, fullWidth: true),
          SizedBox(height: 12),
          _InfoCard(title: 'Active irrigation plan', subtitle: 'Role-specific profile detail', icon: Icons.chevron_right, fullWidth: true),
          SizedBox(height: 12),
          _InfoCard(title: 'Preferred alerts enabled', subtitle: 'Role-specific profile detail', icon: Icons.chevron_right, fullWidth: true),
        ],
      ),
    );
  }
}

class _SingleTabScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLogout;
  final Widget child;
  final Widget? floatingActionButton;

  const _SingleTabScaffold({required this.title, required this.subtitle, required this.onLogout, required this.child, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DashboardTopBar(title: title, subtitle: subtitle, onLogout: onLogout),
                  const SizedBox(height: 18),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardBackdrop extends StatelessWidget {
  const _DashboardBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF1F7EB), Color(0xFFDDECD4), Color(0xFFF7FBF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(top: -60, right: -50, child: _GlowCircle(color: Color(0x334F8B57), size: 180)),
          Positioned(top: 120, left: -40, child: _GlowCircle(color: Color(0x223A7A4B), size: 120)),
          Positioned(bottom: 100, right: 20, child: _GlowCircle(color: Color(0x1A9BC27A), size: 140)),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withOpacity(0.0)]),
      ),
    );
  }
}

class SoilMetric {
  const SoilMetric({required this.title, required this.value, required this.unit, required this.icon, required this.color, required this.note});

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final String note;
}

class SoilMetricCard extends StatelessWidget {
  const SoilMetricCard({super.key, required this.metric});

  final SoilMetric metric;

  @override
  Widget build(BuildContext context) {
    final progress = _metricProgress(metric.title);
    final bgColor = metric.color.withOpacity(0.08);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top gradient bar
          Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [metric.color.withOpacity(0.6), metric.color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Header with icon, title and note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: metric.color.withOpacity(0.2), blurRadius: 8)],
                  ),
                  child: Icon(metric.icon, color: metric.color, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metric.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2E25),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        metric.note,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Metric value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                metric.value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: metric.color,
                  height: 1,
                ),
              ),
              if (metric.unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    metric.unit,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: metric.color.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(metric.color.withOpacity(0.85)),
            ),
          ),
        ],
      ),
    );
  }
}

class CompostRecommendation {
  final String title;
  final String amount;
  final String timing;
  final String reason;
  final Color color;

  const CompostRecommendation({required this.title, required this.amount, required this.timing, required this.reason, required this.color});
}

CompostRecommendation _buildCompostRecommendation(List<SoilMetric> metrics) {
  double read(String title) {
    final value = metrics.where((metric) => metric.title == title).map((metric) => double.tryParse(metric.value)).whereType<double>();
    return value.isNotEmpty ? value.first : 0.0;
  }

  final moisture = read('Moisture');
  final ph = read('pH Level');
  final nitrogen = read('Nitrogen');
  final phosphorus = read('Phosphorus');
  final potassium = read('Potassium');

  if (moisture < 50 || nitrogen < 60 || phosphorus < 35 || potassium < 45) {
    return CompostRecommendation(
      title: 'Compost recommended',
      amount: 'Apply 2.5–3.0 tons/acre',
      timing: 'Best within the next 24–48 hours',
      reason: 'Nutrients are below target or moisture is low, so compost will help restore organic matter and improve retention.',
      color: const Color(0xFF2E7D32),
    );
  }

  if (ph < 6.2 || ph > 7.4) {
    return CompostRecommendation(
      title: 'Balanced compost mix suggested',
      amount: 'Apply 1.5–2.0 tons/acre',
      timing: 'After light irrigation',
      reason: 'The pH is slightly out of the ideal range, so a lighter compost layer will support soil buffering.',
      color: const Color(0xFF8E5CF7),
    );
  }

  return CompostRecommendation(
    title: 'Maintenance compost',
    amount: 'Apply 1.0–1.5 tons/acre',
    timing: 'Any time this week',
    reason: 'Soil readings look stable, so a lighter compost application is enough to maintain long-term fertility.',
    color: const Color(0xFF4E8F50),
  );
}

class _CompostRecommendationCard extends StatelessWidget {
  final CompostRecommendation recommendation;

  const _CompostRecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: recommendation.color.withOpacity(0.2)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: recommendation.color.withOpacity(0.12), shape: BoxShape.circle),
                child: Icon(Icons.recycling_outlined, color: recommendation.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recommendation.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1F2E25))),
                    const SizedBox(height: 4),
                    Text(recommendation.amount, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: recommendation.color)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(recommendation.reason, style: const TextStyle(fontSize: 13, color: Color(0xFF556270), height: 1.4)),
          const SizedBox(height: 10),
          _RecommendationPill(text: recommendation.timing, color: recommendation.color),
        ],
      ),
    );
  }
}

class _ConditionGraphCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<double> points;
  final List<String> labels;

  const _ConditionGraphCard({required this.title, required this.color, required this.points, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1F2E25))),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineGraphPainter(points: points, color: color, labels: labels),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final List<double> points;
  final Color color;
  final List<String> labels;

  _LineGraphPainter({required this.points, required this.color, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final axisPaint = Paint()
      ..color = const Color(0xFFD9E6D0)
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.28), color.withOpacity(0.02)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const topPadding = 18.0;
    const bottomPadding = 28.0;
    const leftPadding = 8.0;
    const rightPadding = 8.0;

    final plotHeight = size.height - topPadding - bottomPadding;
    final plotWidth = size.width - leftPadding - rightPadding;
    final maxValue = points.reduce((a, b) => a > b ? a : b);
    final minValue = points.reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue).clamp(1, double.infinity);

    final path = Path();
    final fillPath = Path();

    Offset pointFor(int index, double value) {
      final dx = leftPadding + (index * (plotWidth / (points.length - 1)));
      final normalized = (value - minValue) / range;
      final dy = topPadding + (plotHeight - (normalized * plotHeight));
      return Offset(dx, dy);
    }

    final firstPoint = pointFor(0, points.first);
    path.moveTo(firstPoint.dx, firstPoint.dy);
    fillPath.moveTo(firstPoint.dx, size.height - bottomPadding);
    fillPath.lineTo(firstPoint.dx, firstPoint.dy);

    for (var i = 1; i < points.length; i++) {
      final current = pointFor(i, points[i]);
      final previous = pointFor(i - 1, points[i - 1]);
      final controlX = (previous.dx + current.dx) / 2;
      path.cubicTo(controlX, previous.dy, controlX, current.dy, current.dx, current.dy);
      fillPath.lineTo(current.dx, current.dy);
    }

    fillPath.lineTo(points.length == 1 ? firstPoint.dx : pointFor(points.length - 1, points.last).dx, size.height - bottomPadding);
    fillPath.close();

    canvas.drawLine(Offset(leftPadding, size.height - bottomPadding), Offset(size.width - rightPadding, size.height - bottomPadding), axisPaint);
    canvas.drawLine(Offset(leftPadding, topPadding), Offset(leftPadding, size.height - bottomPadding), axisPaint);
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    for (var i = 0; i < points.length; i++) {
      final current = pointFor(i, points[i]);
      canvas.drawCircle(current, 5.5, Paint()..color = Colors.white);
      canvas.drawCircle(current, 4, Paint()..color = color);

      final labelPainter = TextPainter(
        text: TextSpan(text: labels[i], style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.w600)),
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(canvas, Offset(current.dx - labelPainter.width / 2, size.height - 20));
    }
  }

  @override
  bool shouldRepaint(covariant _LineGraphPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.color != color || oldDelegate.labels != labels;
  }
}

class _RecommendationPill extends StatelessWidget {
  final String text;
  final Color color;

  const _RecommendationPill({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

double _metricProgress(String title) {
  switch (title) {
    case 'Moisture':
      return 0.64;
    case 'Temperature':
      return 0.58;
    case 'pH Level':
      return 0.68;
    case 'Nitrogen':
      return 0.82;
    case 'Phosphorus':
      return 0.41;
    case 'Potassium':
      return 0.57;
    case 'EC':
      return 0.72;
    case 'Salinity':
      return 0.36;
    default:
      return 0.5;
  }
}
 
class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value, required this.icon, required this.color});

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color.withOpacity(0.16), color.withOpacity(0.06)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showFieldDialog(BuildContext context) {
  final nameController = TextEditingController();

  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Add Field'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Field name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                final nextNumber = FieldService().fields.length + 1;
                FieldService().addField(FieldItem(id: 'field-$nextNumber-${DateTime.now().millisecondsSinceEpoch}', name: name));
              }
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

class _FieldCard extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const _FieldCard({required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F2),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: const Color(0xFF1E88E5).withOpacity(0.12), shape: BoxShape.circle),
                  child: const Icon(Icons.circle_outlined, color: Color(0xFF1E88E5)),
                ),
                const SizedBox(height: 10),
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Delete field',
            ),
          ),
        ],
      ),
    );
  }
}


class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withOpacity(0.12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFFE8F1E7), fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class _UserTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isExpanded;

  const _UserTypeButton({required this.label, required this.isSelected, required this.onTap, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3E6B48) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFF3E6B48) : const Color(0xFFE9E4D8)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, color: isSelected ? Colors.white : const Color(0xFF22303F))),
      ),
    );

    return isExpanded ? Expanded(child: button) : button;
  }
}

class _DashboardTopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLogout;

  const _DashboardTopBar({required this.title, required this.subtitle, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.4)),
              const SizedBox(height: 6),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472))),
            ],
          ),
        ),
        GestureDetector(
          onTap: onLogout,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(999), border: Border.all(color: const Color(0xFFEF5350))),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.logout, size: 14, color: Color(0xFFEF5350)), SizedBox(width: 4), Text('Logout', style: TextStyle(color: Color(0xFFEF5350), fontWeight: FontWeight.w700, fontSize: 12))]),
          ),
        ),
      ],
    );
  }
}

class _HeroPanel extends StatelessWidget {
  final String plotName;
  final String headline;
  final String description;

  const _HeroPanel({required this.plotName, required this.headline, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFF1F6F54), Color(0xFF4E8A5F), Color(0xFF87A65C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [BoxShadow(color: Color(0x334E6B3C), blurRadius: 28, offset: Offset(0, 14))],
      ),
      child: Stack(
        children: [
          Positioned(right: -8, top: -8, child: Container(width: 96, height: 96, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.12)))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.16), borderRadius: BorderRadius.circular(999)), child: Text(plotName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
              const SizedBox(height: 18),
              Text(headline, style: const TextStyle(color: Colors.white, fontSize: 30, height: 1.05, fontWeight: FontWeight.w800, letterSpacing: -0.6)),
              const SizedBox(height: 12),
              Text(description, style: const TextStyle(color: Color(0xFFF3F8F0), height: 1.5, fontSize: 14)),
              const SizedBox(height: 20),
              const Row(children: [_MiniStat(label: 'Health', value: 'Good'), SizedBox(width: 12), _MiniStat(label: 'Response', value: 'Fast')]),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String badge;
  final String description;

  const _SectionHeader({required this.title, required this.badge, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2)), const SizedBox(width: 10), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFEAF2E4), borderRadius: BorderRadius.circular(999)), child: Text(badge, style: const TextStyle(color: Color(0xFF3E6B48), fontSize: 12, fontWeight: FontWeight.w700)))]),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13, height: 1.4)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool fullWidth;

  const _InfoCard({required this.title, required this.subtitle, required this.icon, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3E6B48).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF3E6B48), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF1F2E25),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.4,
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3E6B48).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF3E6B48), size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2E25),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String label;
  final String detail;
  final String action;

  const _ActionRow({required this.label, required this.detail, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.84), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE8E3D7))),
      child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(detail, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12))])), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(999)), child: Text(action, style: const TextStyle(color: Color(0xFFB71C1C), fontWeight: FontWeight.w700, fontSize: 12)))]),
    );
  }
}

class _SimpleTimeline extends StatelessWidget {
  final List<String> items;

  const _SimpleTimeline({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.84), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE8E3D7))),
                child: Row(children: [Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF3E6B48), shape: BoxShape.circle)), const SizedBox(width: 12), Expanded(child: Text(item, style: const TextStyle(fontSize: 13, height: 1.35)))]),
              ))
          .toList(),
    );
  }
}

class _ChartPanel extends StatelessWidget {
  final String title;
  final String description;

  const _ChartPanel({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.84), borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFE8E3D7))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)), const SizedBox(height: 8), Text(description, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.35)), const SizedBox(height: 16), Container(height: 160, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(colors: [Color(0xFFEAF2E4), Color(0xFFD8E8D2), Color(0xFFF4F1E8)], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: const Center(child: Text('Chart placeholder', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF3E6B48)))))]),
    );
  }
}
