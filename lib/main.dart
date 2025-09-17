import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/sign_in_screen.dart';
import 'package:my_app/screens/sign_up_screen.dart';
import 'package:my_app/screens/welcome_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B6BD8)),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/signin': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(),
      },
    );
  }
}