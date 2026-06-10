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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2F6B3D), Color(0xFF4F8A5A), Color(0xFFEAF4DF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 16, offset: Offset(0, 6))],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu, color: Colors.white),
                          tooltip: 'Menu',
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                friend.location,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Home dashboard',
                                style: TextStyle(color: Colors.white.withOpacity(0.84), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.wb_sunny_outlined, size: 18, color: Color(0xFFE67E22)),
                              const SizedBox(width: 6),
                              Text(
                                '${friend.weather} ${friend.temperature.toStringAsFixed(0)}°C',
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF314036)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

String _metricHint(String title) {
  switch (title) {
    case 'Moisture':
      return 'Ideal for growth';
    case 'Temperature':
      return 'Stable';
    case 'pH Level':
    case 'pH':
      return 'Slightly acidic';
    case 'Nitrogen':
      return 'Sufficient';
    case 'Phosphorus':
      return 'Moderate';
    case 'Potassium':
      return 'Balanced';
    case 'Humidity':
      return 'Comfortable';
    case 'Soil Score':
      return 'Healthy';
    default:
      return 'Local data';
  }
}

double _metricRatio(_FriendMetric metric) {
  final parsed = double.tryParse(metric.value);
  if (parsed == null) {
    return 0.5;
  }

  switch (metric.title) {
    case 'Moisture':
      return (parsed / 100).clamp(0.0, 1.0);
    case 'Temperature':
      return (parsed / 40).clamp(0.0, 1.0);
    case 'pH Level':
    case 'pH':
      return ((parsed - 4.0) / 4.0).clamp(0.0, 1.0);
    case 'Nitrogen':
      return (parsed / 100).clamp(0.0, 1.0);
    case 'Phosphorus':
      return (parsed / 60).clamp(0.0, 1.0);
    case 'Potassium':
      return (parsed / 80).clamp(0.0, 1.0);
    case 'Humidity':
      return (parsed / 100).clamp(0.0, 1.0);
    case 'Soil Score':
      return (parsed / 100).clamp(0.0, 1.0);
    default:
      return 0.55;
  }
}

class _FriendMetricCard extends StatefulWidget {
  final _FriendMetric metric;

  const _FriendMetricCard({required this.metric});

  @override
  State<_FriendMetricCard> createState() => _FriendMetricCardState();
}

class _FriendMetricCardState extends State<_FriendMetricCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final progress = _metricRatio(widget.metric);

    return AnimatedScale(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      scale: _pressed ? 0.985 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: widget.metric.color.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: widget.metric.color.withOpacity(_pressed ? 0.14 : 0.08),
              blurRadius: _pressed ? 18 : 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTapDown: (_) => setState(() => _pressed = true),
            onTapCancel: () => setState(() => _pressed = false),
            onTapUp: (_) => setState(() => _pressed = false),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.metric.title}: ${widget.metric.value}${widget.metric.unit}')),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [widget.metric.color.withOpacity(0.12), widget.metric.color.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: widget.metric.color.withOpacity(0.18), blurRadius: 8)],
                        ),
                        child: Icon(widget.metric.icon, color: widget.metric.color, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.metric.title,
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF263238)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _metricHint(widget.metric.title),
                              style: const TextStyle(fontSize: 10.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: double.tryParse(widget.metric.value) ?? 0),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return Text(
                          value.toStringAsFixed(widget.metric.value.contains('.') ? 1 : 0),
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: widget.metric.color, height: 1),
                        );
                      },
                    ),
                    if (widget.metric.unit.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          widget.metric.unit,
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: widget.metric.color.withOpacity(0.75)),
                        ),
                      ),
                    ],
                  ],
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE8ECF1),
                    valueColor: AlwaysStoppedAnimation<Color>(widget.metric.color),
                  ),
                ),
              ],
            ),
          ),
        ),
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
  int _tabIndex = 0;

  static const List<_MonitorSensor> _liveSensors = [
    _MonitorSensor(
      title: 'Moisture',
      value: '72',
      unit: '%',
      note: 'Ideal for growth',
      icon: Icons.water_drop_outlined,
      color: Color(0xFF22A06B),
      sparkValues: [36, 40, 38, 45, 42, 48, 52, 49],
      warning: false,
    ),
    _MonitorSensor(
      title: 'Temperature',
      value: '28.9',
      unit: '°C',
      note: 'Stable',
      icon: Icons.thermostat_outlined,
      color: Color(0xFFE46E45),
      sparkValues: [22, 24, 25, 26, 26, 27, 27, 28],
      warning: false,
    ),
    _MonitorSensor(
      title: 'pH Level',
      value: '6.4',
      unit: '',
      note: 'Slightly acidic',
      icon: Icons.science_outlined,
      color: Color(0xFF8A63F7),
      sparkValues: [7, 7, 6.8, 6.7, 6.6, 6.5, 6.4, 6.4],
      warning: false,
    ),
    _MonitorSensor(
      title: 'Nitrogen',
      value: '76',
      unit: 'ppm',
      note: 'Sufficient',
      icon: Icons.eco_outlined,
      color: Color(0xFF70A62E),
      sparkValues: [62, 64, 65, 66, 68, 71, 73, 76],
      warning: false,
    ),
    _MonitorSensor(
      title: 'Phosphorus',
      value: '39',
      unit: 'ppm',
      note: 'Low - needs attention',
      icon: Icons.grass_outlined,
      color: Color(0xFFF0A935),
      sparkValues: [52, 49, 46, 44, 43, 41, 40, 39],
      warning: true,
    ),
    _MonitorSensor(
      title: 'Potassium',
      value: '52',
      unit: 'ppm',
      note: 'Balanced',
      icon: Icons.agriculture_outlined,
      color: Color(0xFF23B38A),
      sparkValues: [46, 47, 48, 48, 50, 51, 52, 52],
      warning: false,
    ),
  ];

  static const List<_CompareField> _compareFields = [
    _CompareField(name: 'Field A', moisture: 64, status: 'Stable', color: Color(0xFF2C7BE5)),
    _CompareField(name: 'Field B', moisture: 89, status: 'Warning', color: Color(0xFFE46E45), isWarning: true),
    _CompareField(name: 'Field C', moisture: 71, status: 'Balanced', color: Color(0xFF22A06B)),
  ];

  static const List<_DetailSensor> _detailSensors = [
    _DetailSensor(
      title: 'Moisture',
      current: '72%',
      average: '68%',
      peak: '84%',
      low: '54%',
      color: Color(0xFF22A06B),
      bars: [32, 36, 40, 44, 42, 48, 52, 49, 54, 58, 60, 62],
    ),
    _DetailSensor(
      title: 'Temperature',
      current: '28.9°C',
      average: '28.2°C',
      peak: '31.4°C',
      low: '25.8°C',
      color: Color(0xFFE46E45),
      bars: [22, 23, 24, 25, 25, 26, 27, 28, 27, 29, 30, 28],
    ),
    _DetailSensor(
      title: 'pH Level',
      current: '6.4',
      average: '6.5',
      peak: '6.9',
      low: '6.1',
      color: Color(0xFF8A63F7),
      bars: [6, 6, 7, 7, 6, 6, 7, 7, 6, 6, 7, 6],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MonitorBackdrop(),
          SafeArea(
            child: AnimatedBuilder(
              animation: FieldService(),
              builder: (context, _) {
                final fields = FieldService().fields;
                if (fields.isEmpty) {
                  return const _InfoCard(
                    title: 'No fields yet',
                    subtitle: 'Add a friend on the Home page to start showing monitor data.',
                    icon: Icons.sensors_outlined,
                    fullWidth: true,
                  );
                }

                _selectedFieldId ??= fields.first.id;
                final selectedField = fields.firstWhere((field) => field.id == _selectedFieldId, orElse: () => fields.first);

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF245C31), Color(0xFF32713D), Color(0xFF4D8B56)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 24, offset: Offset(0, 12))],
                      ),
                      child: Stack(
                        children: [
                          Positioned(top: -26, right: -22, child: _GlowCircle(color: Color(0x22FFFFFF), size: 88)),
                          Positioned(bottom: -18, left: -12, child: _GlowCircle(color: Color(0x18FFFFFF), size: 64)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _DashboardTopBar(title: 'Monitor', subtitle: '${selectedField.name} · 3 fields connected', onLogout: widget.onLogout),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                                ),
                                child: Row(
                                  children: [
                                    _MonitorTabButton(
                                      label: 'Live',
                                      selected: _tabIndex == 0,
                                      onTap: () => setState(() => _tabIndex = 0),
                                    ),
                                    _MonitorTabButton(
                                      label: 'Compare',
                                      selected: _tabIndex == 1,
                                      onTap: () => setState(() => _tabIndex = 1),
                                    ),
                                    _MonitorTabButton(
                                      label: 'Details',
                                      selected: _tabIndex == 2,
                                      onTap: () => setState(() => _tabIndex = 2),
                                    ),
                                    _MonitorTabButton(
                                      label: 'Export',
                                      selected: _tabIndex == 3,
                                      onTap: () => setState(() => _tabIndex = 3),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF3D9),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: const Color(0xFFB7D08E)),
                              ),
                              child: Text(
                                _tabIndex == 0
                                    ? 'Live · updated 12s ago'
                                    : _tabIndex == 1
                                        ? 'Compare · 3 fields side by side'
                                        : _tabIndex == 2
                                            ? 'Details · 24h sensor bars'
                                            : 'Export · report & share options',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B8B34)),
                              ),
                            ),
                            const SizedBox(height: 12),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              child: _tabIndex == 0
                                  ? _MonitorLiveView(
                                      key: const ValueKey('live'),
                                      sensors: _liveSensors,
                                      selectedField: selectedField,
                                    )
                                  : _tabIndex == 1
                                      ? _MonitorCompareView(
                                          key: const ValueKey('compare'),
                                          fields: _compareFields,
                                        )
                                      : _tabIndex == 2
                                          ? _MonitorDetailsView(
                                              key: const ValueKey('details'),
                                              sensors: _detailSensors,
                                            )
                                          : _MonitorExportView(
                                              key: const ValueKey('export'),
                                              onShare: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Live data shared with friend')),
                                                );
                                              },
                                            ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.88),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFE4E7DD)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Last updated: ${DateTime(2026, 6, 10, 9, 41).hour}:${DateTime(2026, 6, 10, 9, 41).minute.toString().padLeft(2, '0')} AM', style: const TextStyle(fontSize: 12, color: Color(0xFF8A938B), fontWeight: FontWeight.w600)),
                                  const Icon(Icons.sync, size: 18, color: Color(0xFF91A37E)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MonitorBackdrop extends StatelessWidget {
  const _MonitorBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF6FAF0), Color(0xFFEAF3E2), Color(0xFFD9E9D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(top: -70, right: -45, child: _GlowCircle(color: Color(0x334D8E55), size: 190)),
          Positioned(top: 18, left: -35, child: _GlowCircle(color: Color(0x224F8B57), size: 130)),
          Positioned(bottom: 90, right: 16, child: _GlowCircle(color: Color(0x1E7AB26C), size: 150)),
          Positioned(bottom: -30, left: 25, child: _GlowCircle(color: Color(0x18FFFFFF), size: 110)),
        ],
      ),
    );
  }
}

class _MonitorTabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _MonitorTabButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? Colors.white.withOpacity(0.92) : Colors.transparent),
              boxShadow: selected ? const [BoxShadow(color: Color(0x16000000), blurRadius: 10, offset: Offset(0, 4))] : const [],
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? const Color(0xFF255E33) : Colors.white.withOpacity(0.88),
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MonitorSensor {
  final String title;
  final String value;
  final String unit;
  final String note;
  final IconData icon;
  final Color color;
  final List<double> sparkValues;
  final bool warning;

  const _MonitorSensor({required this.title, required this.value, required this.unit, required this.note, required this.icon, required this.color, required this.sparkValues, required this.warning});
}

class _CompareField {
  final String name;
  final int moisture;
  final String status;
  final Color color;
  final bool isWarning;

  const _CompareField({required this.name, required this.moisture, required this.status, required this.color, this.isWarning = false});
}

class _DetailSensor {
  final String title;
  final String current;
  final String average;
  final String peak;
  final String low;
  final Color color;
  final List<double> bars;

  const _DetailSensor({required this.title, required this.current, required this.average, required this.peak, required this.low, required this.color, required this.bars});
}

class _MonitorLiveView extends StatelessWidget {
  final List<_MonitorSensor> sensors;
  final FieldItem selectedField;

  const _MonitorLiveView({super.key, required this.sensors, required this.selectedField});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3D9),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFB6D08C)),
          ),
          child: const Text('Live · updated 12s ago', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF7A9936))),
        ),
        const SizedBox(height: 12),
        ...sensors.map((sensor) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _MonitorSensorCard(sensor: sensor),
            )),
        const SizedBox(height: 4),
        Text(
          'Current field: ${selectedField.name}',
          style: const TextStyle(fontSize: 12, color: Color(0xFF8A938B), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _MonitorSensorCard extends StatelessWidget {
  final _MonitorSensor sensor;

  const _MonitorSensorCard({required this.sensor});

  @override
  Widget build(BuildContext context) {
    final maxValue = sensor.sparkValues.reduce((a, b) => a > b ? a : b);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: sensor.color.withOpacity(0.18)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: sensor.color.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
            child: Icon(sensor.icon, color: sensor.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sensor.title, style: const TextStyle(fontSize: 13, color: Color(0xFF465155), fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(sensor.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: sensor.warning ? const Color(0xFFE24A4A) : sensor.color, height: 1)),
                    if (sensor.unit.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(sensor.unit, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: sensor.warning ? const Color(0xFFE24A4A) : sensor.color)),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  sensor.warning ? 'Low — needs attention' : sensor.note,
                  style: TextStyle(fontSize: 12, color: sensor.warning ? const Color(0xFFE24A4A) : const Color(0xFF5E7B67), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 58,
            height: 42,
            child: CustomPaint(
              painter: _SparklinePainter(values: sensor.sparkValues, color: sensor.warning ? const Color(0xFFE24A4A) : sensor.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> values;
  final Color color;

  _SparklinePainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue).clamp(1, double.infinity);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final dx = (size.width / (values.length - 1)) * i;
      final dy = size.height - (((values[i] - minValue) / range) * size.height);
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) => oldDelegate.values != values || oldDelegate.color != color;
}

class _MonitorCompareView extends StatelessWidget {
  final List<_CompareField> fields;

  const _MonitorCompareView({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Compare', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF22302A))),
        const SizedBox(height: 12),
        Row(
          children: fields
              .map(
                (field) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _CompareFieldCard(field: field),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CompareFieldCard extends StatelessWidget {
  final _CompareField field;

  const _CompareFieldCard({required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: field.isWarning ? const Color(0xFFF0B28C) : const Color(0xFFE3E8DF)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(field.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF22302A))),
              const Spacer(),
              if (field.isWarning)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFFDEBE3), borderRadius: BorderRadius.circular(999)),
                  child: const Text('Warning', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFD45B2E))),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text('${field.moisture}%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: field.color, height: 1)),
          const SizedBox(height: 4),
          Text('Moisture', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: field.color.withOpacity(0.8))),
          const SizedBox(height: 8),
          Text(field.status, style: TextStyle(fontSize: 12, color: field.isWarning ? const Color(0xFFD45B2E) : const Color(0xFF5E7B67), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MonitorDetailsView extends StatelessWidget {
  final List<_DetailSensor> sensors;

  const _MonitorDetailsView({super.key, required this.sensors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF22302A))),
        const SizedBox(height: 12),
        ...sensors.map((sensor) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _DetailSensorCard(sensor: sensor),
            )),
      ],
    );
  }
}

class _DetailSensorCard extends StatelessWidget {
  final _DetailSensor sensor;

  const _DetailSensorCard({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: sensor.color.withOpacity(0.16)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(sensor.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF22302A))),
              const Spacer(),
              _SmallStat(label: 'Current', value: sensor.current, color: sensor.color),
              const SizedBox(width: 8),
              _SmallStat(label: 'Avg', value: sensor.average, color: sensor.color),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(
              painter: _BarSeriesPainter(values: sensor.bars, color: sensor.color),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _SmallStat(label: 'Peak', value: sensor.peak, color: sensor.color),
              const SizedBox(width: 8),
              _SmallStat(label: 'Low', value: sensor.low, color: sensor.color),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SmallStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: color.withOpacity(0.72), fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _BarSeriesPainter extends CustomPainter {
  final List<double> values;
  final Color color;

  _BarSeriesPainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final gap = 4.0;
    final barWidth = (size.width - gap * (values.length - 1)) / values.length;
    final paint = Paint()
      ..shader = LinearGradient(colors: [color.withOpacity(0.4), color], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    for (var i = 0; i < values.length; i++) {
      final barHeight = (values[i] / maxValue) * (size.height - 16);
      final left = i * (barWidth + gap);
      final top = size.height - barHeight;
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(left, top, barWidth, barHeight), const Radius.circular(6)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarSeriesPainter oldDelegate) => oldDelegate.values != values || oldDelegate.color != color;
}

class _MonitorExportView extends StatelessWidget {
  final VoidCallback onShare;

  const _MonitorExportView({super.key, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Export', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF22302A))),
        const SizedBox(height: 12),
        _ExportActionCard(icon: Icons.picture_as_pdf_outlined, title: 'PDF report', subtitle: 'Download a printable report', color: const Color(0xFFE46E45), onTap: onShare),
        const SizedBox(height: 10),
        _ExportActionCard(icon: Icons.table_chart_outlined, title: 'CSV data', subtitle: 'Export sensor rows for analysis', color: const Color(0xFF22A06B), onTap: onShare),
        const SizedBox(height: 10),
        _ExportActionCard(icon: Icons.image_outlined, title: 'PNG chart', subtitle: 'Save the current chart snapshot', color: const Color(0xFF8A63F7), onTap: onShare),
        const SizedBox(height: 10),
        _ExportActionCard(icon: Icons.share_outlined, title: 'Share live data', subtitle: 'Send live data to a friend', color: const Color(0xFF2F6B3D), onTap: onShare),
      ],
    );
  }
}

class _ExportActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ExportActionCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.16)),
            boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF22302A))),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF78837A), height: 1.3)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFB9BFB7)),
            ],
          ),
        ),
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
  String _selectedMetric = 'Moisture';

  static const Map<String, _GraphMetricData> _metricData = {
    'Moisture': _GraphMetricData(
      label: 'Moisture %',
      subtitle: 'last 7 days',
      color: Color(0xFF47B890),
      accent: Color(0xFFDDF6EE),
      values: [62, 70, 58, 79, 68, 83, 71],
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      average: '68%',
      trend: '+4% vs last week',
      trendColor: Color(0xFF159A69),
      summaryOne: 'Avg moisture',
      summaryTwo: 'Stable uptake',
    ),
    'Temp': _GraphMetricData(
      label: 'Temp °C',
      subtitle: 'last 7 days',
      color: Color(0xFFE46E45),
      accent: Color(0xFFFDE9E0),
      values: [27, 28, 26, 29, 27, 30, 28],
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      average: '28.2°C',
      trend: 'Stable range',
      trendColor: Color(0xFFE46E45),
      summaryOne: 'Avg temp',
      summaryTwo: 'Comfort zone',
    ),
    'pH': _GraphMetricData(
      label: 'pH level',
      subtitle: 'last 7 days',
      color: Color(0xFF8A63F7),
      accent: Color(0xFFF0EAFF),
      values: [6.2, 6.4, 6.5, 6.6, 6.5, 6.8, 6.7],
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      average: '6.5',
      trend: 'Slightly acidic',
      trendColor: Color(0xFF8A63F7),
      summaryOne: 'Avg pH',
      summaryTwo: 'Balanced soil',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'Graph',
      subtitle: '7-day trends',
      onLogout: widget.onLogout,
      child: AnimatedBuilder(
        animation: FieldService(),
        builder: (context, _) {
          final fields = FieldService().fields;
          if (fields.isEmpty) {
            return const _InfoCard(
              title: 'No fields yet',
              subtitle: 'Add a friend on the Home page to start showing graph data.',
              icon: Icons.show_chart_outlined,
              fullWidth: true,
            );
          }

          _selectedFieldId ??= fields.first.id;
          final selectedField = fields.firstWhere((field) => field.id == _selectedFieldId, orElse: () => fields.first);
          final metric = _metricData[_selectedMetric] ?? _metricData['Moisture']!;
          final chartTitle = '${metric.label} — ${metric.subtitle}';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2F6B3D), Color(0xFF1D4D2B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [BoxShadow(color: Color(0x28000000), blurRadius: 18, offset: Offset(0, 8))],
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
                              const Text('Graph', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                              const SizedBox(height: 2),
                              Text(
                                selectedField.name,
                                style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.86), fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_month_outlined, size: 16, color: Colors.white),
                              const SizedBox(width: 6),
                              Text('7-day trends', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.92), fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedFieldId,
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.92),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            ),
                            items: fields.map((field) => DropdownMenuItem(value: field.id, child: Text(field.name))).toList(),
                            onChanged: (value) => setState(() => _selectedFieldId = value),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.16)),
                          ),
                          child: const Icon(Icons.show_chart_rounded, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _MetricChip(
                    label: 'Moisture',
                    selected: _selectedMetric == 'Moisture',
                    color: const Color(0xFF2F6B3D),
                    onTap: () => setState(() => _selectedMetric = 'Moisture'),
                  ),
                  const SizedBox(width: 8),
                  _MetricChip(
                    label: 'Temp',
                    selected: _selectedMetric == 'Temp',
                    color: const Color(0xFFE46E45),
                    onTap: () => setState(() => _selectedMetric = 'Temp'),
                  ),
                  const SizedBox(width: 8),
                  _MetricChip(
                    label: 'pH',
                    selected: _selectedMetric == 'pH',
                    color: const Color(0xFF8A63F7),
                    onTap: () => setState(() => _selectedMetric = 'pH'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _WeeklyChartCard(
                title: chartTitle,
                metric: metric,
              ),
              const SizedBox(height: 12),
              const Text('Summary stats', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF203326))),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _GraphSummaryCard(
                      label: metric.summaryOne,
                      value: metric.average,
                      note: metric.trend,
                      color: metric.color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _GraphSummaryCard(
                      label: 'Selected field',
                      value: selectedField.name,
                      note: 'Live dashboard data',
                      color: const Color(0xFF2F6B3D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _GraphSummaryCard(
                      label: 'Avg temp',
                      value: '28.2°C',
                      note: 'Stable range',
                      color: const Color(0xFFE46E45),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _GraphSummaryCard(
                      label: 'Avg pH',
                      value: '6.5',
                      note: 'Slightly acidic',
                      color: const Color(0xFF8A63F7),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GraphMetricData {
  final String label;
  final String subtitle;
  final Color color;
  final Color accent;
  final List<double> values;
  final List<String> days;
  final String average;
  final String trend;
  final Color trendColor;
  final String summaryOne;
  final String summaryTwo;

  const _GraphMetricData({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.accent,
    required this.values,
    required this.days,
    required this.average,
    required this.trend,
    required this.trendColor,
    required this.summaryOne,
    required this.summaryTwo,
  });
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
            border: Border.all(color: selected ? color : const Color(0xFFD7DED4)),
            boxShadow: selected ? [BoxShadow(color: color.withOpacity(0.18), blurRadius: 12, offset: const Offset(0, 4))] : const [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF6F7B6F),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _WeeklyChartCard extends StatelessWidget {
  final String title;
  final _GraphMetricData metric;

  const _WeeklyChartCard({required this.title, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE1E7DD)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: metric.color)),
          const SizedBox(height: 12),
          SizedBox(
            height: 128,
            child: CustomPaint(
              painter: _WeeklyBarPainter(
                values: metric.values,
                color: metric.color,
                labels: metric.days,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyBarPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final List<String> labels;

  _WeeklyBarPainter({required this.values, required this.color, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    const topPadding = 10.0;
    const bottomPadding = 22.0;
    const sidePadding = 6.0;
    final plotHeight = size.height - topPadding - bottomPadding;
    final barAreaWidth = size.width - (sidePadding * 2);
    final gap = 6.0;
    final barWidth = (barAreaWidth - gap * (values.length - 1)) / values.length;
    final maxValue = values.reduce((a, b) => a > b ? a : b);

    final backgroundPaint = Paint()..color = const Color(0xFFF3F6F1);
    final barPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.42), color],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height - bottomPadding + 4), const Radius.circular(16)),
      backgroundPaint,
    );

    for (var i = 0; i < values.length; i++) {
      final barHeight = (values[i] / maxValue) * plotHeight;
      final left = sidePadding + i * (barWidth + gap);
      final top = topPadding + (plotHeight - barHeight);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        const Radius.circular(6),
      );

      canvas.drawRRect(rect, barPaint);

      final labelPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(fontSize: 10, color: Color(0xFF87938A), fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(canvas, Offset(left + (barWidth - labelPainter.width) / 2, size.height - 16));
    }
  }

  @override
  bool shouldRepaint(covariant _WeeklyBarPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color || oldDelegate.labels != labels;
  }
}

class _GraphSummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String note;
  final Color color;

  const _GraphSummaryCard({required this.label, required this.value, required this.note, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.16)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF66757C), fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color, height: 1)),
          const SizedBox(height: 4),
          Text(note, style: TextStyle(fontSize: 11.5, color: color.withOpacity(0.85), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _AlertItem {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final Color color;
  final IconData icon;

  const _AlertItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.color,
    required this.icon,
  });
}

class _FarmerAlertsTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerAlertsTab({required this.onLogout});

  @override
  State<_FarmerAlertsTab> createState() => _FarmerAlertsTabState();
}

class _FarmerAlertsTabState extends State<_FarmerAlertsTab> {
  final List<_AlertItem> _activeAlerts = [
    const _AlertItem(
      id: 'low-phosphorus',
      title: 'Low Phosphorus  — Field A',
      message: 'Level dropped to 28 ppm. Consider adding fertilizer.',
      timeLabel: 'Today 8:14 AM',
      color: Color(0xFFE45B5B),
      icon: Icons.water_drop_outlined,
    ),
    const _AlertItem(
      id: 'high-moisture',
      title: 'High Moisture  — Field B',
      message: 'Moisture at 89%. Risk of root rot if drainage poor.',
      timeLabel: 'Today 6:30 AM',
      color: Color(0xFFC97A1F),
      icon: Icons.water_outlined,
    ),
    const _AlertItem(
      id: 'rain-expected',
      title: 'Rain expected tomorrow',
      message: 'Forecast: 18mm rainfall. Adjust irrigation plan.',
      timeLabel: 'Yesterday 11:00 PM',
      color: Color(0xFF2C7BE5),
      icon: Icons.umbrella_outlined,
    ),
  ];

  final List<_AlertItem> _resolvedAlerts = [
    const _AlertItem(
      id: 'ph-normalized',
      title: 'pH level normalized  — Field C',
      message: 'System confirmed the soil pH is back in balance.',
      timeLabel: 'Jun 9 · 3:20 PM',
      color: Color(0xFFB6CC8A),
      icon: Icons.check_circle_outline,
    ),
    const _AlertItem(
      id: 'nitrogen-restored',
      title: 'Nitrogen restored  — Field A',
      message: 'Amendment cycle completed successfully.',
      timeLabel: 'Jun 8 · 10:05 AM',
      color: Color(0xFFB6CC8A),
      icon: Icons.check_circle_outline,
    ),
  ];

  void _markResolved(_AlertItem item) {
    setState(() {
      _activeAlerts.removeWhere((alert) => alert.id == item.id);
      _resolvedAlerts.insert(
        0,
        _AlertItem(
          id: item.id,
          title: item.title.replaceFirst('  —', ' —'),
          message: item.message,
          timeLabel: 'Just now',
          color: const Color(0xFFB6CC8A),
          icon: Icons.check_circle_outline,
        ),
      );
    });
  }

  void _dismissResolved(_AlertItem item) {
    setState(() {
      _resolvedAlerts.removeWhere((alert) => alert.id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: _DashboardTopBar(
                    title: 'Alerts',
                    subtitle: '${_activeAlerts.length} active warnings',
                    onLogout: widget.onLogout,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AlertSectionHeader(
                          title: 'Active',
                          count: _activeAlerts.length,
                          accentColor: const Color(0xFF2F6B3D),
                        ),
                        const SizedBox(height: 10),
                        if (_activeAlerts.isEmpty)
                          const _EmptyAlertState(text: 'No active warnings right now.')
                        else
                          ..._activeAlerts.map(
                            (alert) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _AlertCard(
                                item: alert,
                                onPrimaryAction: () => _markResolved(alert),
                                primaryActionLabel: 'Resolve',
                                onSecondaryAction: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${alert.title} opened')),
                                  );
                                },
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        _AlertSectionHeader(
                          title: 'Resolved',
                          count: _resolvedAlerts.length,
                          accentColor: const Color(0xFF7E9B60),
                        ),
                        const SizedBox(height: 10),
                        if (_resolvedAlerts.isEmpty)
                          const _EmptyAlertState(text: 'Resolved alerts will appear here.')
                        else
                          ..._resolvedAlerts.map(
                            (alert) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _AlertCard(
                                item: alert,
                                muted: true,
                                onPrimaryAction: () => _dismissResolved(alert),
                                primaryActionLabel: 'Dismiss',
                              ),
                            ),
                          ),
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

class _AlertSectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color accentColor;

  const _AlertSectionHeader({required this.title, required this.count, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF2D3740)),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$count',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: accentColor),
          ),
        ),
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  final _AlertItem item;
  final VoidCallback onPrimaryAction;
  final String primaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final bool muted;

  const _AlertCard({
    required this.item,
    required this.onPrimaryAction,
    required this.primaryActionLabel,
    this.onSecondaryAction,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = muted ? const Color(0xFFB6CC8A) : item.color;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(muted ? 0.8 : 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: muted ? const Color(0xFFE1E7D8) : baseColor.withOpacity(0.22)),
        boxShadow: const [BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onSecondaryAction,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: baseColor.withOpacity(muted ? 0.14 : 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, size: 18, color: baseColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: muted ? const Color(0xFF97A091) : const Color(0xFFB23A2E),
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.message,
                          style: TextStyle(
                            fontSize: 13,
                            color: muted ? const Color(0xFF9AA39A) : const Color(0xFF49545F),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.timeLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: muted ? const Color(0xFFB4BCB4) : const Color(0xFFA0A7AE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPrimaryAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: muted ? const Color(0xFFF1F4EC) : baseColor,
                        foregroundColor: muted ? const Color(0xFF54604E) : Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(primaryActionLabel, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                    ),
                  ),
                  if (onSecondaryAction != null) ...[
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: onSecondaryAction,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: baseColor.withOpacity(0.28)),
                        foregroundColor: baseColor,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Open', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyAlertState extends StatelessWidget {
  final String text;

  const _EmptyAlertState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _FarmerProfileTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _FarmerProfileTab({required this.onLogout});

  void _showShortcut(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title opened')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFFB8D1A8),
                        child: Text('রহ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('রহিম উদ্দিন', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFFEAF2E6), height: 1.1)),
                            const SizedBox(height: 2),
                            Text(
                              'Gazipur · 3 fields connected',
                              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.84), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: onLogout,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white.withOpacity(0.16)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.logout, size: 16, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: const [BoxShadow(color: Color(0x0B000000), blurRadius: 18, offset: Offset(0, 8))],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F5EC),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(Icons.person_outline, color: Color(0xFF3D6F43), size: 30),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Profile Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF22302A))),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Manage tools, logs, and weather from one place.',
                                    style: TextStyle(fontSize: 13, color: const Color(0xFF647070).withOpacity(0.95), height: 1.35),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: const [
                            Expanded(child: _ProfileStatPill(label: 'Field Map', value: '3 connected')),
                            SizedBox(width: 10),
                            Expanded(child: _ProfileStatPill(label: 'AI Advice', value: 'Enabled')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProfileShortcutCard(
                    icon: Icons.map_outlined,
                    iconColor: const Color(0xFF5B8E45),
                    backgroundColor: const Color(0xFFF1F7E8),
                    title: 'Field Map',
                    subtitle: 'Manage your farm zones',
                    onTap: () => _showShortcut(context, 'Field Map'),
                  ),
                  const SizedBox(height: 10),
                  _ProfileShortcutCard(
                    icon: Icons.eco_outlined,
                    iconColor: const Color(0xFFC67A1F),
                    backgroundColor: const Color(0xFFFDF3E6),
                    title: 'Crop Advice',
                    subtitle: 'AI suggestions based on soil',
                    onTap: () => _showShortcut(context, 'Crop Advice'),
                  ),
                  const SizedBox(height: 10),
                  _ProfileShortcutCard(
                    icon: Icons.cloud_outlined,
                    iconColor: const Color(0xFF3776C7),
                    backgroundColor: const Color(0xFFEAF2FF),
                    title: 'Weather',
                    subtitle: 'Forecast & rain alerts',
                    onTap: () => _showShortcut(context, 'Weather'),
                  ),
                  const SizedBox(height: 10),
                  _ProfileShortcutCard(
                    icon: Icons.calculate_outlined,
                    iconColor: const Color(0xFF6B63D9),
                    backgroundColor: const Color(0xFFF0EDFF),
                    title: 'Compost Calculator',
                    subtitle: 'Get compost amount by area',
                    onTap: () => _showShortcut(context, 'Compost Calculator'),
                  ),
                  const SizedBox(height: 10),
                  _ProfileShortcutCard(
                    icon: Icons.receipt_long_outlined,
                    iconColor: const Color(0xFF707070),
                    backgroundColor: const Color(0xFFF3F1EB),
                    title: 'Activity Log',
                    subtitle: 'Fertilizer & water diary',
                    onTap: () => _showShortcut(context, 'Activity Log'),
                  ),
                  const SizedBox(height: 10),
                  _ProfileShortcutCard(
                    icon: Icons.settings_outlined,
                    iconColor: const Color(0xFF5A5A5A),
                    backgroundColor: const Color(0xFFF1F1F1),
                    title: 'Settings',
                    subtitle: 'Sensor config, language',
                    onTap: () => _showShortcut(context, 'Settings'),
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

class _ProfileStatPill extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStatPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7A67), fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 13, color: Color(0xFF213028), fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _ProfileShortcutCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileShortcutCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE6E8E3)),
            boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF222B24))),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF78837A), height: 1.3)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Color(0xFFB9BFB7)),
            ],
          ),
        ),
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
