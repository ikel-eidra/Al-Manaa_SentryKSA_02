import '../SENTRY_KSA_GENESIS_CORE.dart';

class SentryIntelligenceEngineRefined extends SentryIntelligenceEngine {
  // SentryIntelligenceEngine properties from base:
  // final double brentBase = 85.0;
  // final double globalDemand = 100000000.0;

  final double petrochemGlobalShare = 0.15; // KSA share of global petrochem
  final double fertilizerGlobalShare = 0.20; // KSA share of global fertilizer

  @override
  Map<String, dynamic> calculateImpact(StrategicAsset asset) {
    // 1. Core Energy Shock (Brent)
    double supplyShock = (asset.outputValue / globalDemand) * 100;

    // War Volatility Multiplier - Increases non-linearly with risk level
    double volatilityMultiplier = 5.2 + (asset.riskLevel * 1.5);
    double priceSurge = supplyShock * volatilityMultiplier;

    // 2. Direct GDP Loss
    double dailyRevenueLoss = asset.outputValue * brentBase;

    // 3. Supply Chain Disruption Index (0-100)
    double supplyChainDisruption = 0;
    String supplyChainImpact = "Minimal";

    if (asset.sector == "Energy") {
      supplyChainDisruption = supplyShock * (petrochemGlobalShare * 100);
      supplyChainImpact = "Moderate Petrochemical Disruption";
      if (supplyChainDisruption > 5) supplyChainImpact = "Severe Petrochemical & Plastics Shortage";
    } else if (asset.sector == "Water" && asset.name.contains("Desal")) {
       supplyChainDisruption = (asset.outputValue / 5000000) * 100; // Relative to KSA daily desal capacity
       supplyChainImpact = "Local Agricultural / Industrial Water Scarcity";
    }

    // 4. Day Zero Recovery Logic
    String erd = asset.repairTier == 3 ? "540 Days" : (asset.repairTier == 2 ? "180 Days" : "14 Days");

    // 5. Prescriptive Advice
    String advice = _generatePrescriptiveAdvice(asset);

    return {
      "gdp_loss": "\$${dailyRevenueLoss.toStringAsFixed(0)} / Day",
      "market_shock": "+${priceSurge.toStringAsFixed(2)}% Brent",
      "supply_chain_impact": supplyChainImpact,
      "disruption_index": supplyChainDisruption.toStringAsFixed(1),
      "recovery_window": erd,
      "advice": advice
    };
  }

  String _generatePrescriptiveAdvice(StrategicAsset asset) {
    if (asset.sector == "Energy" && asset.riskLevel == 3) {
       return "Hardened storage online. Reroute pipeline flow to Yanbu terminal immediately.";
    } else if (asset.sector == "Water") {
       return "Pivot to mobile aquifer units and relocate EW assets. Implement municipal rationing.";
    } else if (asset.sector == "Govt") {
       return "Evacuate key personnel to Safe Zone 4. Activate secondary data centers.";
    }
    return "Maintain standard operational readiness. Monitor threat channels.";
  }
}
