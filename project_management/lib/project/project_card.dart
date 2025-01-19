import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management/project/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onViewDetails;

  const ProjectCard({
    Key? key,
    required this.project,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Choose the color for the CircleAvatar based on project status
    Color avatarColor;
    if (project.status == 'Ongoing') {
      avatarColor = Colors.blue;
    } else if (project.status == 'Completed') {
      avatarColor = Colors.green;
    } else {
      avatarColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          child: Text(
            "P0${project.id}", // Extracting project id from "P001" -> "001"
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          project.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${project.status}'),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              // value: project.progress / 100,
              value: 70,
              backgroundColor: Colors.grey[300],
              color: avatarColor,
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: onViewDetails,
          child: const Text('View Details'),
        ),
      ),
    );
  }
}
