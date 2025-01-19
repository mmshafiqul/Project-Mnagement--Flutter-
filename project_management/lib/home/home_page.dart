import 'package:flutter/material.dart';
import 'package:project_management/home/home_cards.dart';
import 'package:project_management/home/home_carousel.dart';
import 'package:project_management/project/projects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variable to store the client name
  String? clientName;

  // Method to retrieve client name from SharedPreferences
  Future<void> _getClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      clientName = prefs.getString('clientName');
    });
  }

  @override
  void initState() {
    super.initState();
    _getClientName(); // Retrieve the client name on init
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap in a SingleChildScrollView for scrollable content
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        // Adjusted padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Reduced gap between text widgets
            // Display client's name below "Welcome Back!"
            Text(
              clientName != null ? 'Hello, $clientName!' : 'Hello, User!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Spacing between the name and the next section
            const Text(
              'Here’s an overview of your projects...',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Keeps space between the text and carousel
            const HomeCarousel(),
            // Carousel widget for project overview
            const SizedBox(height: 20),
            // Adjusted space before HomeCards widget
            const HomeCards(),
            // Action Buttons
            SizedBox(height: 10),
            // Reduced space between grid and action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Directly push the Projects screen without using routes
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Projects(), // Directly navigate to Projects page
                      ),
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('View Projects'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  icon: const Icon(Icons.attach_money),
                  label: const Text('Payments'),
                ),
              ],
            ),
            // Directly use HomeCards without unnecessary sized boxes
          ],
        ),
      ),
    );
  }
}
