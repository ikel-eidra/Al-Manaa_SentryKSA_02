import 'dart:async';
import 'package:flutter/material.dart';

class Threat {
  final String threatType;
  final String targetCorridor;
  final DateTime impactTime;

  Threat({required this.threatType, required this.targetCorridor, required this.impactTime});
}

class ThreatProvider extends ChangeNotifier {
  Timer? _timer;
  String _tMinus = "00:00:00";
  Threat? _activeThreat;

  String get tMinus => _tMinus;
  Threat? get activeThreat => _activeThreat;
  bool get hasActiveThreat => _activeThreat != null;

  void startCountdown(Threat threat) {
    _activeThreat = threat;
    _updateTimer();

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimer();
    });
  }

  void stopCountdown() {
    _timer?.cancel();
    _activeThreat = null;
    _tMinus = "00:00:00";
    notifyListeners();
  }

  void _updateTimer() {
    if (_activeThreat == null) return;

    final now = DateTime.now();
    final difference = _activeThreat!.impactTime.difference(now);

    if (difference.isNegative) {
      stopCountdown();
      return;
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(difference.inHours);
    final minutes = twoDigits(difference.inMinutes.remainder(60));
    final seconds = twoDigits(difference.inSeconds.remainder(60));

    _tMinus = "$hours:$minutes:$seconds";
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
