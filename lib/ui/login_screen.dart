import 'package:flutter/material.dart';
import '../SENTRY_KSA_GENESIS_CORE.dart';

class OperatorLoginScreen extends StatefulWidget {
  const OperatorLoginScreen({super.key});

  @override
  _OperatorLoginScreenState createState() => _OperatorLoginScreenState();
}

class _OperatorLoginScreenState extends State<OperatorLoginScreen> {
  final TextEditingController _clearanceController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  void _authenticate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    // Simulate network authentication delay for "Eyes Only" access
    await Future.delayed(const Duration(seconds: 2));

    if (_clearanceController.text.trim() == "0000") {
      // Success - Navigate to War Room
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SentryKSADashboard()),
      );
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = "CLEARANCE DENIED. UNAUTHORIZED PERSONNEL.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or High-Tech Icon
              const Icon(
                Icons.security_rounded,
                size: 100,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "AL-MAN'AA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "SENTRY KSA: EYES ONLY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 4,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 60),

              // Simulated Biometric / Passcode Field
              TextField(
                controller: _clearanceController,
                style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', letterSpacing: 10),
                textAlign: TextAlign.center,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "ENTER CLEARANCE CODE",
                  hintStyle: TextStyle(color: Colors.white24, letterSpacing: 2, fontFamily: 'sans-serif'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  filled: true,
                  fillColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),

              // Login Button
              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.greenAccent))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.withOpacity(0.2),
                        side: const BorderSide(color: Colors.greenAccent),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      onPressed: _authenticate,
                      child: const Text(
                        "VERIFY IDENTITY",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

              const SizedBox(height: 40),
              const Text(
                "WARNING: RESTRICTED GOVERNMENT NETWORK.\nUNAUTHORIZED ACCESS IS PROHIBITED.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white30, fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
