import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text("ShareGO"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back, Ride Buddy 👋",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(height: 30),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              children: [
                _buildCard(
                  title: "Create Ride",
                  icon: Icons.add_circle_outline,
                  onTap: () {
                    Navigator.pushNamed(context, '/createRide');
                  },
                ),
                _buildCard(
                  title: "Search Rides",
                  icon: Icons.search,
                  onTap: () {
                    Navigator.pushNamed(context, '/searchRide');
                  },
                ),
                _buildCard(
                  title: "My Profile",
                  icon: Icons.person_outline,
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                _buildCard(
                  title: "Ride History",
                  icon: Icons.history,
                  onTap: () {
                    Navigator.pushNamed(context, '/rideHistory');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}