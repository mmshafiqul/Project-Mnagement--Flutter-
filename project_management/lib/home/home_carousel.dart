// home_carousel.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        _buildCarouselItem('Projects', 'Manage and track your projects', Icons.work),
        _buildCarouselItem('Payments', 'View and make payments', Icons.payment),
        _buildCarouselItem('Progress', 'Track the progress of your tasks', Icons.trending_up),
      ],
      options: CarouselOptions(
        height: 150, // Adjust the height of the carousel
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0, // Make the item fill the width of the screen
      ),
    );
  }

  Widget _buildCarouselItem(String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16), // Add some padding for the ListTile
          leading: Icon(
            icon,
            size: 40,
            color: Colors.blue,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
