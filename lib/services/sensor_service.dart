import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/sensor_model.dart';

class SensorService {
  static const String endpointUrl = 'https://api.waziup.io/api/v2/devices/soil-node-02';

  final http.Client _client;

  SensorService({http.Client? client}) : _client = client ?? http.Client();

  Future<WaziupDevice> fetchDeviceData() async {
    try {
      final response = await _client.get(
        Uri.parse(endpointUrl),
        headers: const {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
        return WaziupDevice.fromJson(body);
      } else {
        throw HttpException('সার্ভার সাড়া দেয়নি (কোড: ${response.statusCode})');
      }
    } on SocketException {
      throw const SocketException('ইন্টারনেট সংযোগ নেই। আপনার ওয়াইফাই বা মোবাইল ডাটা পরীক্ষা করুন।');
    } on HttpException catch (e) {
      throw HttpException(e.message);
    } on FormatException {
      throw const FormatException('সার্ভারের ডেটা ফরম্যাট ত্রুটিপূর্ণ।');
    } catch (e) {
      throw Exception('তথ্য লোড করতে ব্যর্থ হয়েছে: $e');
    }
  }
}
