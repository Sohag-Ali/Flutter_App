import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'signup_page.dart';

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

InputDecoration inputDecoration(String hint, IconData icon, {Widget? suffix}) {
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
                    decoration: inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: inputDecoration(
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
