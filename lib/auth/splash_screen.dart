import 'package:flutter/material.dart';
import 'package:sharego/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use a modern outlined car icon as logo
            Icon(Icons.directions_car_filled, size: 90, color: Colors.green),
            const SizedBox(height: 30),
            const Text(
              'ShareGo',
              style: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            const Text(
              'Connecting Hostel Students Smartly',
              style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.green),
          ],
        ),
      ),
    );
  }
}