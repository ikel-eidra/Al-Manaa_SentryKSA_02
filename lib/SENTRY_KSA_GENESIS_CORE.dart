// SENTRY_KSA_GENESIS_CORE.dart
// Foundation for production-grade Strategic Risk & Recovery App

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// 1. STRATEGIC INVENTORY MODEL
class StrategicAsset {
  final String id, name, sector;
  final LatLng location;
  final int riskLevel; // 1: Low, 2: Med, 3: High
  final double outputValue; // Barrels per day or m3 water
  final int repairTier; // 1: 14d, 2: 180d, 3: 540d

  StrategicAsset({
    required this.id,
    required this.name,
    required this.sector,
    required this.location,
    required this.riskLevel,
    required this.outputValue,
    required this.repairTier
  });
}

// 2. ECONOMIC & RECOVERY ENGINE
class SentryIntelligenceEngine {
  final double brentBase = 85.0;
  final double globalDemand = 100000000.0;

  Map<String, dynamic> calculateImpact(StrategicAsset asset) {
    double supplyShock = (asset.outputValue / globalDemand) * 100;
    double priceSurge = supplyShock * 5.2; // War Volatility Multiplier
    double dailyRevenueLoss = asset.outputValue * brentBase;

    // Day Zero Recovery Logic
    String erd = asset.repairTier == 3 ? "540 Days" : (asset.repairTier == 2 ? "180 Days" : "14 Days");

    return {
      "gdp_loss": "\$${dailyRevenueLoss.toStringAsFixed(0)} / Day",
      "market_shock": "+${priceSurge.toStringAsFixed(2)}% Brent",
      "recovery_window": erd,
      "advice": "Pivot to mobile aquifer units and relocate EW assets."
    };
  }
}

// 3. MAIN APP INTERFACE (WAR ROOM)
class SentryKSADashboard extends StatefulWidget {
  @override
  _SentryKSADashboardState createState() => _SentryKSADashboardState();
}

class _SentryKSADashboardState extends State<SentryKSADashboard> {
  final List<StrategicAsset> vault = [
    StrategicAsset(id: "ABQ-01", name: "Abqaiq Plant", sector: "Energy", location: LatLng(25.9371, 49.6631), riskLevel: 3, outputValue: 7000000, repairTier: 3),
    StrategicAsset(id: "JUB-03", name: "Jubail Desal", sector: "Water", location: LatLng(26.9320, 49.6580), riskLevel: 3, outputValue: 1400000, repairTier: 3),
    StrategicAsset(id: "RUH-MOD", name: "Riyadh MOD", sector: "Govt", location: LatLng(24.6644, 46.6890), riskLevel: 2, outputValue: 0, repairTier: 2),
  ];

  String tMinus = "02:44:12"; // Calculated from Scraper

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // GIS HEATMAP
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(24.7, 46.6), zoom: 5.5),
            mapType: MapType.hybrid,
            circles: vault.map((asset) => Circle(
              circleId: CircleId(asset.id),
              center: asset.location,
              radius: asset.riskLevel * 8000.0,
              fillColor: asset.riskLevel == 3 ? Colors.red.withOpacity(0.4) : Colors.orange.withOpacity(0.4),
              strokeWidth: 1,
              strokeColor: Colors.white24,
            )).toSet(),
          ),

          // EMERGENCY COUNTDOWN OVERLAY
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: _buildWarningPanel(),
          ),

          // ANALYTICS & INFOGRAPHICS (Bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildAnalyticsPanel(),
          )
        ],
      ),
    );
  }

  Widget _buildWarningPanel() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text("IMMINENT THREAT: BALLISTIC (IRGC)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(tMinus, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'monospace')),
          Text("Target Corridor: Eastern Province / Oil Loop", style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsPanel() {
    return Container(
      height: 180,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem("Strikes (Feb 28)", "42"),
              _statItem("Intercept Rate", "92%"),
              _statItem("Brent Impact", "+\$14.20"),
            ],
          ),
          Divider(color: Colors.white10, height: 30),
          Text("ADVICE: Hardened storage online. Move workers to Safe Zone 4.", style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _statItem(String label, String val) {
    return Column(children: [
      Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
    ]);
  }
}
