import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexoraAIHealthcareApp());
}

class NexoraAIHealthcareApp extends StatelessWidget {
  const NexoraAIHealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexora AI Healthcare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0FDFB),
        primaryColor: const Color(0xFF00BFA6),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF00BFA6),
          secondary: Color(0xFF00695C),
        ),
      ),
      // IDHE - MAIN FIX - BUILDER
      builder: (context, child) {
        return Container(
          color: const Color(0xFF0F172A), // Laptop Pakkana - Dark Colour
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
              maxHeight: 900,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: child!,
            ),
          ),
        );
      },
      home: const SplashScreen(),
    );
  }
}