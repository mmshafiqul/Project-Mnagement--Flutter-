import 'package:flutter/material.dart';
import 'package:project_management/home/home_page.dart';
import 'package:project_management/layout/layout.dart';
import 'package:project_management/project/project_list_screen.dart';
import 'package:project_management/project/project_request.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  // Filtered value (default is 'All')
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home), // Home icon
          onPressed: () {
            // Navigate to the home page when the home icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Layout()), // Adjust to your actual HomePage class
            );
          },
        ),
        title: const Text("Projects are filtered by"),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _selectedFilter = value; // Update the selected filter value
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Ongoing', child: Text('Ongoing')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddProjectScreen when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProjectRequest()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent, // Customize color
      ),
      body:
          ProjectListScreen(filter: _selectedFilter), // Pass filter to the list
    );
  }
}
