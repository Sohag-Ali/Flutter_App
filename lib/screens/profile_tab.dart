import 'package:flutter/material.dart';
import 'field_map_page.dart';

class ProfileTab extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileTab({super.key, required this.onLogout});

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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FieldMapPage()));
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
