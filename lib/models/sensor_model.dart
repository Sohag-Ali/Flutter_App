import 'package:flutter/material.dart';

class WaziupSensorValue {
  final DateTime? dateReceived;
  final num value;

  const WaziupSensorValue({
    this.dateReceived,
    required this.value,
  });

  factory WaziupSensorValue.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['date_received'] != null) {
      parsedDate = DateTime.tryParse(json['date_received'].toString());
    }
    num val = 0;
    if (json['value'] != null) {
      val = num.tryParse(json['value'].toString()) ?? 0;
    }
    return WaziupSensorValue(
      dateReceived: parsedDate,
      value: val,
    );
  }
}

class WaziupSensor {
  final String id;
  final String name;
  final String unit;
  final WaziupSensorValue? value;

  const WaziupSensor({
    required this.id,
    required this.name,
    required this.unit,
    this.value,
  });

  factory WaziupSensor.fromJson(Map<String, dynamic> json) {
    WaziupSensorValue? sensorVal;
    if (json['value'] is Map<String, dynamic>) {
      sensorVal = WaziupSensorValue.fromJson(json['value'] as Map<String, dynamic>);
    }
    return WaziupSensor(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      unit: json['unit']?.toString() ?? '',
      value: sensorVal,
    );
  }
}

class WaziupDevice {
  final String id;
  final String name;
  final String owner;
  final List<WaziupSensor> sensors;

  const WaziupDevice({
    required this.id,
    required this.name,
    required this.owner,
    required this.sensors,
  });

  factory WaziupDevice.fromJson(Map<String, dynamic> json) {
    final sensorList = <WaziupSensor>[];
    if (json['sensors'] is List) {
      for (final item in json['sensors'] as List) {
        if (item is Map<String, dynamic>) {
          sensorList.add(WaziupSensor.fromJson(item));
        }
      }
    }
    return WaziupDevice(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      owner: json['owner']?.toString() ?? '',
      sensors: sensorList,
    );
  }
}

class SensorMetric {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final String apiId;
  final DateTime? lastUpdated;

  const SensorMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.apiId,
    this.lastUpdated,
  });

  SensorMetric copyWith({
    String? title,
    String? value,
    String? unit,
    IconData? icon,
    Color? color,
    String? apiId,
    DateTime? lastUpdated,
  }) {
    return SensorMetric(
      title: title ?? this.title,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      apiId: apiId ?? this.apiId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
