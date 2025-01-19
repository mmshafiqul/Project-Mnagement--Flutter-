import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_management/authentication/login.dart';
import 'package:project_management/project/project_card.dart';
import 'package:project_management/project/project_detail.dart';
import 'package:project_management/project/project_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ProjectListScreen extends StatefulWidget {
  final String filter;

  const ProjectListScreen({super.key, required this.filter});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late int userId;

  Future<void> checkedLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      userId = prefs.getInt('id')!;
      print("User ID: $userId"); // Ensure userId is correctly retrieved
      setState(() {
        // Trigger rebuild to fetch the projects once the userId is set.
        _projectsFuture = _fetchProjects();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  late Future<List<Project>> _projectsFuture;

  Future<List<Project>> _fetchProjects() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/project/client/${userId}'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load projects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkedLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No projects available.'));
        } else {
          List<Project> projects = snapshot.data!;
          List<Project> filteredProjects = widget.filter == 'All'
              ? projects
              : projects.where((project) => project.status == widget.filter).toList();

          return ListView.builder(
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              return ProjectCard(
                project: project,
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetail(project: project.toMap()),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
