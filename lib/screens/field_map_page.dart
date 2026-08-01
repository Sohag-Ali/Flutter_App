import 'package:flutter/material.dart';
import 'login_page.dart';

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

class FieldMapPage extends StatelessWidget {
  const FieldMapPage({super.key});

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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFieldPage()));
        },
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AddFieldPage extends StatefulWidget {
  const AddFieldPage({super.key});

  @override
  State<AddFieldPage> createState() => _AddFieldPageState();
}

class _AddFieldPageState extends State<AddFieldPage> {
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
                decoration: inputDecoration('জমি/মাঠের নাম', Icons.landscape_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'নাম আবশ্যক' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _locationController,
                decoration: inputDecoration('অবস্থান/জেলা', Icons.location_on_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'অবস্থান আবশ্যক' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _areaController,
                decoration: inputDecoration('আয়তন (যেমন: ২.৫ বিঘা)', Icons.square_foot_outlined),
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
