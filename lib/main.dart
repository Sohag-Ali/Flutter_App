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
  final String location;
  final String area;
  final String soilType;
  final String description;

  const FieldItem({
    required this.id,
    required this.name,
    this.location = 'অজানা স্থান',
    this.area = '--',
    this.soilType = 'সাধারণ',
    this.description = '',
  });
}

class FieldService extends ChangeNotifier {
  FieldService._();

  static final FieldService _instance = FieldService._();

  factory FieldService() => _instance;

  final List<FieldItem> _fields = <FieldItem>[
    const FieldItem(
      id: 'field-1',
      name: 'উত্তর মাঠ',
      location: 'গাজীপুর',
      area: '২.৫ বিঘা',
      soilType: 'দোআঁশ',
      description: 'উত্তর পার্শ্বের ডেমো প্লট',
    ),
    const FieldItem(
      id: 'field-2',
      name: 'দক্ষিণ মাঠ',
      location: 'সাভার',
      area: '১.৮ বিঘা',
      soilType: 'এটেল দোআঁশ',
      description: 'দক্ষিণ পার্শ্বের ডেমো প্লট',
    ),
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

InputDecoration _inputDecoration(String hint, IconData icon, {Widget? suffix}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
    suffixIcon: suffix,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFD5E4CC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.8),
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
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('লগইন ব্যর্থ হয়েছে। তথ্য যাচাই করুন।')),
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
                  const SizedBox(height: 40),
                  Text(
                    'স্বাগতম',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E3A27),
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'আপনার মাটির স্বাস্থ্য পর্যবেক্ষণ করতে সাইন ইন করুন',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF5B6472)),
                  ),
                  const SizedBox(height: 36),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration(
                      'পাসওয়ার্ড',
                      Icons.lock_outlined,
                      suffix: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                        child: const Text('পাসওয়ার্ড ভুলে গেছেন?', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : const Text('সাইন ইন করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Container(height: 1, color: const Color(0xFFD5E4CC))),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('অথবা', style: TextStyle(color: Color(0xFF7D9277)))),
                      Expanded(child: Container(height: 1, color: const Color(0xFFD5E4CC))),
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
                        side: const BorderSide(color: Color(0xFF2E7D32)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: const Text('নতুন অ্যাকাউন্ট তৈরি করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('পাসওয়ার্ড মিলছে না')));
      return;
    }

    setState(() => _isLoading = true);
    final success = await widget.authService.signup(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success) {
      widget.onSignupSuccess();
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('অ্যাকাউন্ট তৈরি ব্যর্থ হয়েছে')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('নতুন অ্যাকাউন্ট'),
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
                  Text('আমাদের সাথে যুক্ত হন', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text('মাটির স্বাস্থ্য পর্যবেক্ষণ শুরু করতে নতুন অ্যাকাউন্ট খুলুন', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472))),
                  const SizedBox(height: 24),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: _inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration(
                      'পাসওয়ার্ড',
                      Icons.lock_outlined,
                      suffix: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: _confirmPasswordController, obscureText: _obscurePassword, decoration: _inputDecoration('পাসওয়ার্ড নিশ্চিত করুন', Icons.lock_outlined)),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : const Text('অ্যাকাউন্ট তৈরি করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
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

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('পাসওয়ার্ড রিসেট লিঙ্ক ইমেইলে পাঠানো হয়েছে')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('পাসওয়ার্ড রিসেট'),
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
                  Text('পাসওয়ার্ড ভুলে গেছেন?', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Text(
                    'আপনার ইমেইল ঠিকানা দিন, আমরা পাসওয়ার্ড রিসেট করার লিঙ্ক পাঠাবো।',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472), height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, enabled: !_resetSent, decoration: _inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _resetSent || _isLoading ? null : _handleReset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Text(_resetSent ? 'লিঙ্ক পাঠানো হয়েছে' : 'রিসেট লিঙ্ক পাঠান', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
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

class _RoleDashboardScaffold extends StatelessWidget {
  final Widget child;
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _RoleDashboardScaffold({
    required this.child,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(child: child),
        ],
      ),
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
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2E7D32),
          unselectedItemColor: const Color(0xFF7B8794),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          items: items,
        ),
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
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'হোম'),
        BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined), activeIcon: Icon(Icons.monitor_heart_rounded), label: 'পর্যবেক্ষণ'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart_outlined), activeIcon: Icon(Icons.show_chart_rounded), label: 'গ্রাফ'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), activeIcon: Icon(Icons.notifications_rounded), label: 'সতর্কতা'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'প্রোফাইল'),
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
  // Exact 8 sensor data items with colors matching prompt specifications
  final List<_FriendData> _friends = const [
    _FriendData(
      id: 'rahim',
      name: 'রহিম',
      location: 'গাজীপুর',
      weather: '☀️ রৌদ্রোজ্জ্বল',
      temperature: 31.5,
      humidity: 64,
      compostTotalKg: 1175,
      compostPerSqMeter: 2.35,
      soilHealthScore: 89,
      metrics: [
        _FriendMetric('আর্দ্রতা', '64', '%', Icons.water_drop_rounded, Color(0xFF2196F3)),
        _FriendMetric('তাপমাত্রা', '31.5', '°C', Icons.thermostat_rounded, Color(0xFFFF6D00)),
        _FriendMetric('pH লেভেল', '6.7', '', Icons.science_rounded, Color(0xFF9C27B0)),
        _FriendMetric('নাইট্রোজেন', '82', 'ppm', Icons.eco_rounded, Color(0xFF4CAF50)),
        _FriendMetric('ফসফরাস', '41', 'ppm', Icons.grass_rounded, Color(0xFFFFC107)),
        _FriendMetric('পটাশিয়াম', '57', 'ppm', Icons.agriculture_rounded, Color(0xFF009688)),
        _FriendMetric('বাতাসের গতি', '12', 'km/h', Icons.air_rounded, Color(0xFF1976D2)),
        _FriendMetric('মাটির স্বাস্থ্য স্কোর', '89', '%', Icons.yard_rounded, Color(0xFF795548)),
      ],
    ),
    _FriendData(
      id: 'nila',
      name: 'নীলা',
      location: 'সাভার',
      weather: '☁️ মেঘলা',
      temperature: 29.0,
      humidity: 72,
      compostTotalKg: 1050,
      compostPerSqMeter: 2.10,
      soilHealthScore: 82,
      metrics: [
        _FriendMetric('আর্দ্রতা', '72', '%', Icons.water_drop_rounded, Color(0xFF2196F3)),
        _FriendMetric('তাপমাত্রা', '28.9', '°C', Icons.thermostat_rounded, Color(0xFFFF6D00)),
        _FriendMetric('pH লেভেল', '6.4', '', Icons.science_rounded, Color(0xFF9C27B0)),
        _FriendMetric('নাইট্রোজেন', '76', 'ppm', Icons.eco_rounded, Color(0xFF4CAF50)),
        _FriendMetric('ফসফরাস', '39', 'ppm', Icons.grass_rounded, Color(0xFFFFC107)),
        _FriendMetric('পটাশিয়াম', '52', 'ppm', Icons.agriculture_rounded, Color(0xFF009688)),
        _FriendMetric('বাতাসের গতি', '10', 'km/h', Icons.air_rounded, Color(0xFF1976D2)),
        _FriendMetric('মাটির স্বাস্থ্য স্কোর', '82', '%', Icons.yard_rounded, Color(0xFF795548)),
      ],
    ),
    _FriendData(
      id: 'sabbir',
      name: 'সাব্বির',
      location: 'ময়মনসিংহ',
      weather: '🌧️ হালকা বৃষ্টি',
      temperature: 27.0,
      humidity: 59,
      compostTotalKg: 1250,
      compostPerSqMeter: 2.50,
      soilHealthScore: 75,
      metrics: [
        _FriendMetric('আর্দ্রতা', '59', '%', Icons.water_drop_rounded, Color(0xFF2196F3)),
        _FriendMetric('তাপমাত্রা', '27.3', '°C', Icons.thermostat_rounded, Color(0xFFFF6D00)),
        _FriendMetric('pH লেভেল', '6.2', '', Icons.science_rounded, Color(0xFF9C27B0)),
        _FriendMetric('নাইট্রোজেন', '68', 'ppm', Icons.eco_rounded, Color(0xFF4CAF50)),
        _FriendMetric('ফসফরাস', '37', 'ppm', Icons.grass_rounded, Color(0xFFFFC107)),
        _FriendMetric('পটাশিয়াম', '46', 'ppm', Icons.agriculture_rounded, Color(0xFF009688)),
        _FriendMetric('বাতাসের গতি', '15', 'km/h', Icons.air_rounded, Color(0xFF1976D2)),
        _FriendMetric('মাটির স্বাস্থ্য স্কোর', '75', '%', Icons.yard_rounded, Color(0xFF795548)),
      ],
    ),
  ];

  String _selectedFriendId = 'rahim';

  _FriendData get _selectedFriend =>
      _friends.firstWhere((friend) => friend.id == _selectedFriendId, orElse: () => _friends.first);

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
                  // TOP SECTION: Menu Icon, District Name, Current Weather, Farm Dropdown
                  Container(
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
                                        friend.location,
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
                                    '${friend.name}-এর স্মার্ট খামার',
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
                                '${friend.weather} ${friend.temperature.toStringAsFixed(1)}°C',
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
                              value: _selectedFriendId,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF2E7D32)),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E3A27)),
                              items: _friends
                                  .map(
                                    (f) => DropdownMenuItem<String>(
                                      value: f.id,
                                      child: Text('জমি নির্বাচন: ${f.name}-এর খামার (${f.location})'),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  _selectedFriendId = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SENSOR SECTION HEADER
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 10),
                    child: Text(
                      'সেন্সর প্যারামিটার (৮টি)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E3A27)),
                    ),
                  ),

                  // REUSABLE COMPACT 2-COLUMN GRIDVIEW FOR 8 SENSOR CARDS
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: friend.metrics.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final metric = friend.metrics[index];
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
                  ),
                  const SizedBox(height: 20),

                  // COMPOST & SOIL HEALTH SECTION: 2-LINE SUMMARY CARD WITHOUT INPUT FIELD
                  _PremiumCompostCard(
                    totalCompostKg: friend.compostTotalKg,
                    perSqMeterRate: friend.compostPerSqMeter,
                    soilHealthScore: friend.soilHealthScore,
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
  final int compostTotalKg;
  final double compostPerSqMeter;
  final int soilHealthScore;
  final List<_FriendMetric> metrics;

  const _FriendData({
    required this.id,
    required this.name,
    required this.location,
    required this.weather,
    required this.temperature,
    required this.humidity,
    required this.compostTotalKg,
    required this.compostPerSqMeter,
    required this.soilHealthScore,
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

// REUSABLE COMPACT ANIMATED SENSOR CARD WIDGET WITH SLEEK CIRCULAR BORDER RING
class SensorCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const SensorCard({
    super.key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.color.withValues(alpha: 0.16),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: _isHovered ? 0.12 : 0.04),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Compact thin circular border ring
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.04),
                        border: Border.all(
                          color: widget.color,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: widget.color, size: 20),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                widget.value,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E3A27),
                                  height: 1.0,
                                ),
                              ),
                              if (widget.unit.isNotEmpty) ...[
                                const SizedBox(width: 2),
                                Text(
                                  widget.unit,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: widget.color.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Bengali Parameter Title below circle
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF203326),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CLEAN 2-LINE SOIL HEALTH & COMPOST RECOMMENDATION CARD (NO INPUT FIELD)
class _PremiumCompostCard extends StatelessWidget {
  final int totalCompostKg;
  final double perSqMeterRate;
  final int soilHealthScore;

  const _PremiumCompostCard({
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
      title: 'আর্দ্রতা',
      value: '72',
      unit: '%',
      note: 'উপযুক্ত অবস্থা',
      icon: Icons.water_drop_rounded,
      color: Color(0xFF2196F3),
    ),
    _MonitorSensor(
      title: 'তাপমাত্রা',
      value: '28.9',
      unit: '°C',
      note: 'স্বাভাবিক',
      icon: Icons.thermostat_rounded,
      color: Color(0xFFFF6D00),
    ),
    _MonitorSensor(
      title: 'pH মাত্রা',
      value: '6.4',
      unit: '',
      note: 'হালকা অম্লীয়',
      icon: Icons.science_rounded,
      color: Color(0xFF9C27B0),
    ),
    _MonitorSensor(
      title: 'নাইট্রোজেন',
      value: '76',
      unit: 'ppm',
      note: 'পর্যাপ্ত',
      icon: Icons.eco_rounded,
      color: Color(0xFF4CAF50),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: AnimatedBuilder(
              animation: FieldService(),
              builder: (context, _) {
                final fields = FieldService().fields;
                if (fields.isEmpty) {
                  return const _InfoCard(
                    title: 'কোনো জমি পাওয়া যায়নি',
                    subtitle: 'পর্যবেক্ষণ ডেটা দেখতে হোমে জমি যোগ করুন।',
                    icon: Icons.sensors_rounded,
                    fullWidth: true,
                  );
                }

                _selectedFieldId ??= fields.first.id;
                final selectedField = fields.firstWhere((field) => field.id == _selectedFieldId, orElse: () => fields.first);

                return Column(
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
                          _DashboardTopBar(title: 'পর্যবেক্ষণ', subtitle: '${selectedField.name} · ৩টি জমি যুক্ত', onLogout: widget.onLogout),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                _MonitorTabButton(
                                  label: 'লাইভ',
                                  selected: _tabIndex == 0,
                                  onTap: () => setState(() => _tabIndex = 0),
                                ),
                                _MonitorTabButton(
                                  label: 'তুলনা',
                                  selected: _tabIndex == 1,
                                  onTap: () => setState(() => _tabIndex = 1),
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
                );
              },
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
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? const Color(0xFF2E7D32) : Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w800,
              fontSize: 13,
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

  const _MonitorSensor({
    required this.title,
    required this.value,
    required this.unit,
    required this.note,
    required this.icon,
    required this.color,
  });
}

class _FarmerGraphTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerGraphTab({required this.onLogout});

  @override
  State<_FarmerGraphTab> createState() => _FarmerGraphTabState();
}

class _FarmerGraphTabState extends State<_FarmerGraphTab> {
  String _selectedMetric = 'আর্দ্রতা';

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'গ্রাফ বিশ্লেষণ',
      subtitle: '৭ দিনের পরিবর্তনের গ্রাফ',
      onLogout: widget.onLogout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

class _FarmerAlertsTab extends StatefulWidget {
  final VoidCallback onLogout;

  const _FarmerAlertsTab({required this.onLogout});

  @override
  State<_FarmerAlertsTab> createState() => _FarmerAlertsTabState();
}

class _FarmerAlertsTabState extends State<_FarmerAlertsTab> {
  final List<_AlertItem> _alerts = [
    const _AlertItem(
      id: 'low-phosphorus',
      title: 'ফসফরাস কম — উত্তর মাঠ',
      message: 'মাত্রা ২৮ ppm-এ নেমেছে। সার প্রয়োগ বিবেচনা করুন।',
      color: Color(0xFFE45B5B),
      icon: Icons.water_drop_rounded,
    ),
    const _AlertItem(
      id: 'high-moisture',
      title: 'উচ্চ আর্দ্রতা — দক্ষিণ মাঠ',
      message: 'আর্দ্রতা ৮৯%। নিষ্কাশন ব্যবস্থা না থাকলে মূল পচনের ঝুঁকি।',
      color: Color(0xFFC97A1F),
      icon: Icons.water_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SingleTabScaffold(
      title: 'সতর্কতা',
      subtitle: '${_alerts.length}টি সক্রিয় সতর্কতা',
      onLogout: widget.onLogout,
      child: Column(
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
    );
  }
}

class _FarmerProfileTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _FarmerProfileTab({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DashboardBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0xFF2E7D32),
                        child: Text('রহ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('রহিম উদ্দিন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E3A27))),
                            Text('গাজীপুর · ৩টি জমি যুক্ত', style: TextStyle(fontSize: 12, color: Color(0xFF5B6472))),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: onLogout,
                        icon: const Icon(Icons.logout, size: 16),
                        label: const Text('লগআউট'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFE24A4A),
                          side: const BorderSide(color: Color(0xFFE24A4A)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _ProfileShortcutTile(
                    icon: Icons.map_rounded,
                    title: 'জমির ম্যাপ',
                    subtitle: 'খামার জোন পরিচালনা করুন',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const _FieldMapPage()));
                    },
                  ),
                  _ProfileShortcutTile(
                    icon: Icons.eco_rounded,
                    title: 'ফসল পরামর্শ',
                    subtitle: 'মাটির তথ্যের ভিত্তিতে AI পরামর্শ',
                    onTap: () {},
                  ),
                  _ProfileShortcutTile(
                    icon: Icons.cloud_rounded,
                    title: 'আবহাওয়া',
                    subtitle: 'পূর্বাভাস ও বৃষ্টিপাতের সতর্কতা',
                    onTap: () {},
                  ),
                  _ProfileShortcutTile(
                    icon: Icons.settings_rounded,
                    title: 'সেটিংস',
                    subtitle: 'সেন্সর কনফিগারেশন ও ভাষা',
                    onTap: () {},
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

class _ProfileShortcutTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileShortcutTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF2E7D32)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
        trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF99A3A4)),
      ),
    );
  }
}

class _FieldMapPage extends StatelessWidget {
  const _FieldMapPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('জমির ম্যাপ'),
      ),
      body: AnimatedBuilder(
        animation: FieldService(),
        builder: (context, _) {
          final fields = FieldService().fields;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: fields.length,
            itemBuilder: (context, index) {
              final field = fields[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                child: Row(
                  children: [
                    const Icon(Icons.place_rounded, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(field.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text('${field.location} · ${field.area}', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const _AddFieldPage()));
        },
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _AddFieldPage extends StatefulWidget {
  const _AddFieldPage();

  @override
  State<_AddFieldPage> createState() => _AddFieldPageState();
}

class _AddFieldPageState extends State<_AddFieldPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final nextNumber = FieldService().fields.length + 1;
    FieldService().addField(
      FieldItem(
        id: 'field-$nextNumber-${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        area: _areaController.text.trim(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('নতুন জমি যুক্ত করা হয়েছে')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নতুন জমি যোগ করুন')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('জমি/মাঠের নাম', Icons.landscape_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'নাম আবশ্যক' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _locationController,
                decoration: _inputDecoration('অবস্থান/জেলা', Icons.location_on_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'অবস্থান আবশ্যক' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _areaController,
                decoration: _inputDecoration('আয়তন (যেমন: ২.৫ বিঘা)', Icons.square_foot_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'আয়তন আবশ্যক' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text('সংরক্ষণ করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
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

  const _SingleTabScaffold({
    required this.title,
    required this.subtitle,
    required this.onLogout,
    required this.child,
  });

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
                  _DashboardTopBar(title: title, subtitle: subtitle, onLogout: onLogout),
                  const SizedBox(height: 16),
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

class _DashboardTopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLogout;

  const _DashboardTopBar({
    required this.title,
    required this.subtitle,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1E3A27),
                      letterSpacing: -0.4,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onLogout,
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
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool fullWidth;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF2E7D32), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF1E3A27),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.3,
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
