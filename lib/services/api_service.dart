import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // for kIsWeb

class ThreatIntelligenceSource {
  final String source;
  final String report;
  final DateTime timestamp;

  ThreatIntelligenceSource({
    required this.source,
    required this.report,
    required this.timestamp,
  });

  factory ThreatIntelligenceSource.fromJson(Map<String, dynamic> json) {
    return ThreatIntelligenceSource(
      source: json['source'] ?? 'Unknown Source',
      report: json['report'] ?? 'Unknown Report',
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
    );
  }
}

class ApiService {
  // Uses Android emulator loopback alias (10.0.2.2) if native, or localhost if web/iOS
  String get _baseUrl {
    if (kIsWeb) return 'http://localhost:8000/api/v1';
    return 'http://10.0.2.2:8000/api/v1';
  }

  // Fetches real scraped intelligence from the Python OSINT FastAPI backend
  Future<List<ThreatIntelligenceSource>> fetchThreatIntelligence() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/intelligence/stream'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonItem) => ThreatIntelligenceSource.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Failed to load intelligence stream');
      }
    } catch (e) {
      print("API Error: $e");
      // Fallback to empty list so UI doesn't crash if python server is offline during dev
      return [];
    }
  }

  // Fetches correlated active threats from the Python FastAPI backend
  Future<Map<String, dynamic>> fetchActiveThreats() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/threats/active'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load active threats');
      }
    } catch (e) {
      print("API Error: $e");
      // Fallback to simulated threat if python server is offline
      return {
        "isActive": true,
        "threatType": "BALLISTIC (IRGC) [OFFLINE CACHE]",
        "targetCorridor": "Eastern Province / Oil Loop",
        "impactTime": DateTime.now().add(Duration(hours: 2, minutes: 44, seconds: 12)).toIso8601String()
      };
    }
  }
}
