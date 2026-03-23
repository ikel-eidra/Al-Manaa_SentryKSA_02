import 'dart:async';

class ThreatIntelligenceSource {
  final String source; // 'US CENTCOM', 'Israel IDF', 'Iran IRNA'
  final String report;
  final DateTime timestamp;

  ThreatIntelligenceSource({
    required this.source,
    required this.report,
    required this.timestamp,
  });
}

class ApiService {
  // Simulates the intelligence "Brain" scraping OSINT data from reliable news outlets,
  // social media (X, Telegram, Instagram), and official government/military channels.
  Future<List<ThreatIntelligenceSource>> fetchThreatIntelligence() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    return [
      ThreatIntelligenceSource(
        source: 'X / @CENTCOM',
        report: 'Statement: Elevated ballistic missile activity detected in western Iran.',
        timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      ThreatIntelligenceSource(
        source: 'Telegram / IDF Official',
        report: 'Video Statement: Increased drone swarm preparations observed near border regions.',
        timestamp: DateTime.now().subtract(Duration(minutes: 45)),
      ),
      ThreatIntelligenceSource(
        source: 'Instagram / IRNA_News',
        report: 'Infographic: State media announces upcoming military exercises in the Persian Gulf.',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ];
  }

  // Simulates fetching active threats that trigger the countdown
  Future<Map<String, dynamic>> fetchActiveThreats() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Simulating a threat impacting in ~2 hours and 44 minutes
    return {
      "isActive": true,
      "threatType": "BALLISTIC (IRGC)",
      "targetCorridor": "Eastern Province / Oil Loop",
      "impactTime": DateTime.now().add(Duration(hours: 2, minutes: 44, seconds: 12)).toIso8601String()
    };
  }
}
