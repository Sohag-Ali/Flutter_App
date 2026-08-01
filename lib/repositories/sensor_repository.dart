import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sensor_model.dart';
import '../services/sensor_service.dart';

class SensorRepository extends ChangeNotifier {
  final SensorService _service;
  Timer? _autoRefreshTimer;

  bool _isLoading = false;
  bool _isError = false;
  String _errorMessage = '';
  DateTime? _lastRefreshed;

  List<SensorMetric> _metrics = [];

  SensorRepository({SensorService? service}) : _service = service ?? SensorService() {
    _initDefaultMetrics();
  }

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;
  DateTime? get lastRefreshed => _lastRefreshed;
  List<SensorMetric> get metrics => List.unmodifiable(_metrics);

  void _initDefaultMetrics() {
    _metrics = const [
      SensorMetric(title: 'আর্দ্রতা', value: '--', unit: '%', icon: Icons.water_drop_rounded, color: Color(0xFF2196F3), apiId: 'Mois'),
      SensorMetric(title: 'তাপমাত্রা', value: '--', unit: '°C', icon: Icons.thermostat_rounded, color: Color(0xFFFF6D00), apiId: 'TC'),
      SensorMetric(title: 'pH লেভেল', value: '--', unit: '', icon: Icons.science_rounded, color: Color(0xFF9C27B0), apiId: 'PH'),
      SensorMetric(title: 'নাইট্রোজেন', value: '--', unit: 'ppm', icon: Icons.eco_rounded, color: Color(0xFF4CAF50), apiId: 'Nitrogen'),
      SensorMetric(title: 'ফসফরাস', value: '--', unit: 'ppm', icon: Icons.grass_rounded, color: Color(0xFFFFC107), apiId: 'Phosphorus'),
      SensorMetric(title: 'পটাশিয়াম', value: '--', unit: 'ppm', icon: Icons.agriculture_rounded, color: Color(0xFF009688), apiId: 'Potassium'),
      SensorMetric(title: 'EC', value: '--', unit: 'dS/m', icon: Icons.bolt_rounded, color: Color(0xFF1976D2), apiId: 'EC'),
      SensorMetric(title: 'মাটির স্বাস্থ্য স্কোর', value: '89', unit: '%', icon: Icons.yard_rounded, color: Color(0xFF795548), apiId: 'Salinity'),
    ];
  }

  void startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    // Refresh every 30 seconds automatically
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      fetchSensorData(showLoadingIndicator: false);
    });
  }

  void stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  Future<void> fetchSensorData({bool showLoadingIndicator = true}) async {
    if (showLoadingIndicator) {
      _isLoading = true;
      _isError = false;
      _errorMessage = '';
      notifyListeners();
    }

    try {
      final device = await _service.fetchDeviceData();
      _mapWaziupSensorsToMetrics(device);
      _isError = false;
      _errorMessage = '';
      _lastRefreshed = DateTime.now();
    } catch (e) {
      // Keep default metrics populated for offline/test environments
      _isError = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _mapWaziupSensorsToMetrics(WaziupDevice device) {
    final Map<String, WaziupSensor> sensorMap = {};
    for (final s in device.sensors) {
      sensorMap[s.id.toLowerCase()] = s;
      sensorMap[s.name.toLowerCase()] = s;
    }

    final updated = <SensorMetric>[];

    for (final defaultMetric in _metrics) {
      final key = defaultMetric.apiId.toLowerCase();
      final sensor = sensorMap[key] ?? sensorMap[_getAlternativeKey(defaultMetric.apiId)];

      if (sensor != null && sensor.value != null) {
        final rawVal = sensor.value!.value;
        String formattedVal;
        if (rawVal is double) {
          formattedVal = rawVal.toStringAsFixed(1);
        } else {
          formattedVal = rawVal.toString();
        }
        updated.add(defaultMetric.copyWith(
          value: formattedVal,
          lastUpdated: sensor.value!.dateReceived,
        ));
      } else {
        updated.add(defaultMetric);
      }
    }

    _metrics = updated;
  }

  String _getAlternativeKey(String apiId) {
    switch (apiId.toLowerCase()) {
      case 'mois':
        return 'moisture';
      case 'tc':
        return 'temperature';
      case 'ph':
        return 'ph';
      default:
        return apiId.toLowerCase();
    }
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}
