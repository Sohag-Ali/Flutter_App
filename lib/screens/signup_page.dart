import 'package:flutter/material.dart';
import 'login_page.dart';

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
                  Text('আমাদের সাথে যুক্ত হন', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text('মাটির স্বাস্থ্য পর্যবেক্ষণ শুরু করতে নতুন অ্যাকাউন্ট খুলুন', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472))),
                  const SizedBox(height: 24),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined)),
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
                  TextField(controller: _confirmPasswordController, obscureText: _obscurePassword, decoration: inputDecoration('পাসওয়ার্ড নিশ্চিত করুন', Icons.lock_outlined)),
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
