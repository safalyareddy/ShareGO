import 'package:flutter/material.dart';
import 'package:sharego/auth/splash_screen.dart';
import 'package:sharego/auth/signup_screen.dart';
import 'package:sharego/auth/login_screen.dart';
import 'package:sharego/screens/home_screen.dart';
import 'package:sharego/screens/create_ride_screen.dart';
import 'package:sharego/screens/search_ride_screen.dart';
import 'package:sharego/screens/profile_screen.dart';
import 'package:sharego/screens/ride_history_screen.dart';

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
        '/home': (context) => const HomeScreen(),
        '/createRide': (context) => const CreateRideScreen(),
        '/searchRide': (context) => const SearchRideScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/rideHistory': (context) => const RideHistoryScreen(),
      },
    );
  }
}
