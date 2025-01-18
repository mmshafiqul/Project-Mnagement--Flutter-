import 'package:flutter/material.dart';
import 'package:project_management/home/home_cards.dart';
import 'package:project_management/home/home_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap in a SingleChildScrollView for scrollable content
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0), // Adjusted padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Reduced gap between text widgets
            const Text(
              'Here’s an overview of your projects:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20), // Keeps space between the text and carousel
            const HomeCarousel(), // Carousel widget for project overview
            const SizedBox(height: 20), // Adjusted space before HomeCards widget
            const HomeCards(), // Directly use HomeCards without unnecessary sized boxes
          ],
        ),
      ),
    );
  }
}
