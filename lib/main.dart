import 'package:flutter/material.dart';
import 'package:sharego/auth/splash_screen.dart';
import 'package:sharego/auth/signup_screen.dart';
import 'package:sharego/auth/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideShare Buddy',
      theme: ThemeData.dark(), // Optional: consistent dark theme
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
