import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("ShareGO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        automaticallyImplyLeading: false, // No back button
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: selectedTab,
          builder: (context, tab, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: tab == 0
                            ? ElevatedButton.icon(
                                onPressed: () => selectedTab.value = 0,
                                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                label: const Text('Create Ride', style: TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              )
                            : OutlinedButton.icon(
                                onPressed: () => selectedTab.value = 0,
                                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                label: const Text('Create Ride', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(color: Colors.green, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: tab == 1
                            ? ElevatedButton.icon(
                                onPressed: () => selectedTab.value = 1,
                                icon: const Icon(Icons.search, color: Colors.white),
                                label: const Text('Find Rides', style: TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              )
                            : OutlinedButton.icon(
                                onPressed: () => selectedTab.value = 1,
                                icon: const Icon(Icons.search, color: Colors.green),
                                label: const Text('Find Rides', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(color: Colors.green, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: tab == 0
                        ? _CreateRideForm()
                        : _FindRidesView(onCreateRide: () => selectedTab.value = 0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Helper widgets for the two tabs
class _CreateRideForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You can move your existing create ride form here
    return Center(child: Text('Create Ride Form Goes Here'));
  }
}

class _FindRidesView extends StatelessWidget {
  final VoidCallback? onCreateRide;
  const _FindRidesView({this.onCreateRide});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ...existing code for Find Rides list...
        const SizedBox(height: 24),
        // No back button, just the Find Rides content
        const Center(child: Text('Find Rides List Goes Here')),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: onCreateRide,
          icon: const Icon(Icons.add_circle_outline, color: Colors.green),
          label: const Text('Create Ride', style: TextStyle(fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            side: const BorderSide(color: Colors.green, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}