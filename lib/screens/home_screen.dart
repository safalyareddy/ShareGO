import 'package:flutter/material.dart';
import 'package:sharego/screens/create_ride_screen.dart';
import 'package:sharego/screens/find_ride_screen.dart';
import 'package:sharego/auth/login_screen.dart'; // For logout functionality

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.directions_car, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'ShareGo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                tabs: const [
                  Tab(text: 'Available'),
                  Tab(text: 'My Rides'),
                  Tab(text: 'History'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAvailableRidesTab(),
                _buildMyRidesTab(),
                _buildHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRidesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildRideCard(
            origin: 'College Gate',
            destination: 'Railway Station',
            date: 'Fri, Jul 19 at 2:30 PM',
            seatsLeft: 2,
            driverName: 'Arjun Singh',
            driverRating: 4.5,
            price: 45,
            occupiedSeats: 2,
            totalSeats: 4,
          ),
          const SizedBox(height: 16),
          _buildRideCard(
            origin: 'Hostel Block A',
            destination: 'City Mall',
            date: 'Fri, Jul 19 at 6:00 PM',
            seatsLeft: 1,
            driverName: 'Priya Sharma',
            driverRating: 4.5,
            price: 60,
            occupiedSeats: 3,
            totalSeats: 4,
          ),
          const SizedBox(height: 16),
          _buildRideCard(
            origin: 'Main Gate',
            destination: 'Airport',
            date: 'Sat, Jul 20 at 9:00 AM',
            seatsLeft: 3,
            driverName: 'Rahul Kumar',
            driverRating: 4.8,
            price: 120,
            occupiedSeats: 1,
            totalSeats: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard({
    required String origin,
    required String destination,
    required String date,
    required int seatsLeft,
    required String driverName,
    required double driverRating,
    required int price,
    required int occupiedSeats,
    required int totalSeats,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$origin → $destination', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$seatsLeft seats left',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Divider(height: 20, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.black),
                    const SizedBox(width: 4),
                    Text(driverName, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    Icon(Icons.star, size: 16, color: Colors.orange),
                    Text(driverRating.toString(), style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRidesTab() {
    return Center(
      child: Text('My Rides - Under Development'),
    );
  }

  Widget _buildHistoryTab() {
    return Center(
      child: Text('History - Under Development'),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('User Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Joined: Jan 2024', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('Rating: 4.7', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text('12 rides', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
