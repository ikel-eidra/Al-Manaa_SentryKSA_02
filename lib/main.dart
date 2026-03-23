import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/threat_provider.dart';
import 'ui/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThreatProvider()),
      ],
      child: const SentryKSAApp(),
    ),
  );
}

class SentryKSAApp extends StatelessWidget {
  const SentryKSAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Man\'aa (SentryKSA)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.orange,
        ),
      ),
      home: const OperatorLoginScreen(),
    );
  }
}
