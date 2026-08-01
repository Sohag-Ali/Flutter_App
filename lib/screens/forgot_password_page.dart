import 'package:flutter/material.dart';
import 'login_page.dart';

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
                  const SizedBox(height: 20),
                  Text('পাসওয়ার্ড ভুলে গেছেন?', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Text(
                    'আপনার ইমেইল ঠিকানা দিন, আমরা পাসওয়ার্ড রিসেট করার লিঙ্ক পাঠাবো।',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF5B6472), height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, enabled: !_resetSent, decoration: inputDecoration('ইমেইল ঠিকানা', Icons.email_outlined)),
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
