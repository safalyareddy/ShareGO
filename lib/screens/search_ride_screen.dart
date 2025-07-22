import 'package:flutter/material.dart';

class SearchRideScreen extends StatefulWidget {
  const SearchRideScreen({super.key});

  @override
  State<SearchRideScreen> createState() => _SearchRideScreenState();
}

class _SearchRideScreenState extends State<SearchRideScreen> {
  String _search = '';
  int _selectedTab = 0;
  final List<String> _tabs = ['Available', 'My Rides', 'History'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Find Rides', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Create Ride'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.green),
                    label: const Text('Find Rides', style: TextStyle(color: Colors.green)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _tabButton('Available', 0),
                _tabButton('My Rides', 1),
                _tabButton('History', 2),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by destination...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _search = val),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _rideCard(
                  from: 'College Gate',
                  to: 'Railway Station',
                  seats: 2,
                  time: 'Fri, Jul 19 at 2:30 PM',
                  name: 'Arjun Singh',
                  price: 45,
                  occupied: 2,
                  total: 4,
                  vehicle: Icons.electric_rickshaw,
                ),
                _rideCard(
                  from: 'Hostel Block A',
                  to: 'City Mall',
                  seats: 1,
                  time: 'Fri, Jul 19 at 6:00 PM',
                  name: 'Priya Sharma',
                  price: 60,
                  occupied: 3,
                  total: 4,
                  vehicle: Icons.directions_car,
                ),
                _rideCard(
                  from: 'Main Gate',
                  to: 'Airport',
                  seats: 3,
                  time: 'Fri, Jul 19 at 8:00 PM',
                  name: 'Rahul Verma',
                  price: 120,
                  occupied: 1,
                  total: 4,
                  vehicle: Icons.directions_car,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _selectedTab == index ? Colors.green : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _selectedTab == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rideCard({
    required String from,
    required String to,
    required int seats,
    required String time,
    required String name,
    required int price,
    required int occupied,
    required int total,
    required IconData vehicle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(vehicle, color: Colors.green, size: 28),
              const SizedBox(width: 8),
              Text(from, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
              Text(to, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$seats seats left', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(name.split(' ').map((e) => e[0]).take(2).join(), style: const TextStyle(color: Colors.white)),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
              const Text(' per seat', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ...List.generate(occupied, (i) => const Icon(Icons.person, color: Colors.green, size: 20)),
              ...List.generate(total - occupied, (i) => const Icon(Icons.person_outline, color: Colors.grey, size: 20)),
              const SizedBox(width: 8),
              Text('$occupied/$total occupied', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
