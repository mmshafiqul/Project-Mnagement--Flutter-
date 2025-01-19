import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_management/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project model
class Project {
  final int id;
  final String title;
  final String description;
  final String status; // Status: Pending, Ongoing, Completed
  final double price;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.price,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      price: json['price'],
    );
  }
}

class HomeCards extends StatefulWidget {
  const HomeCards({super.key});

  @override
  _HomeCardsState createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  int? userId; // Make userId nullable since it is fetched asynchronously
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    checkedLoginStatus(); // Check login status when widget initializes
  }

  // Check login status and get userId
  Future<void> checkedLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      userId = prefs.getInt('id');
      print("User ID: $userId"); // Ensure userId is correctly retrieved
      setState(() {
        // Trigger rebuild after setting userId
        _projectsFuture = _fetchProjects();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  // Fetch projects from the API
  Future<List<Project>> _fetchProjects() async {
    if (userId == null) {
      throw Exception('User ID is not set');
    }

    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/project/client/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load projects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show loading indicator while waiting for userId and projects to load
          userId == null
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Wait for userId to be fetched
              : FutureBuilder<List<Project>>(
                  future: _projectsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Project> projects = snapshot.data!;

                      // Calculate the counts based on project status
                      int totalProjects = projects.length;
                      int completedProjects =
                          projects.where((p) => p.status == 'Completed').length;
                      int activeProjects =
                          projects.where((p) => p.status == 'Ongoing').length;
                      int pendingProjects =
                          projects.where((p) => p.status == 'Pending').length;

                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Total Projects Card
                          SummaryCard(
                            title: 'Total Projects',
                            value: totalProjects.toString(),
                            icon: Icons.work_outline,
                            color: Colors.purple,
                          ),
                          // Completed Projects Card
                          SummaryCard(
                            title: 'Completed Projects',
                            value: completedProjects.toString(),
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                          // Active Projects Card
                          SummaryCard(
                            title: 'Active Projects',
                            value: activeProjects.toString(),
                            icon: Icons.work,
                            color: Colors.blue,
                          ),
                          // Pending Projects Card
                          SummaryCard(
                            title: 'Pending Projects',
                            value: pendingProjects.toString(),
                            icon: Icons.pending,
                            color: Colors.orange,
                          ),
                          // Pending Payments Card (Replace with actual logic)
                          const SummaryCard(
                            title: 'Pending Payments',
                            value: '3', // Replace with actual logic
                            icon: Icons.payment,
                            color: Colors.orange,
                          ),
                          // Total Payments Card (Replace with actual logic)
                          const SummaryCard(
                            title: 'Total Payments',
                            value: '50000',
                            // Replace with actual logic for total payments
                            icon: Icons.payment_outlined,
                            color: Colors.red,
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No Data Available'));
                    }
                  },
                ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
