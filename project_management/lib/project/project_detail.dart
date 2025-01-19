import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ProjectDetail extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectDetail({super.key, required this.project});

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  late Future<List<Map<String, dynamic>>> _tasksFuture;

  // Fetch tasks for the project from the API
  Future<List<Map<String, dynamic>>> _fetchTasks() async {
    final response = await http.get(Uri.parse('http://localhost:8080/task/project/${widget.project['id']}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((taskJson) => taskJson as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  void _changeProjectStatus() {
    setState(() {
      widget.project['status'] = 'Completed'; // Update project status
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project Status Changed to Completed')),
    );
  }

  @override
  void initState() {
    super.initState();
    _tasksFuture = _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    // Sample payment history
    final List<Map<String, dynamic>> paymentHistory = [
      {'date': '2025-01-01', 'amount': '৳ 2000'},
      {'date': '2025-01-15', 'amount': '৳ 3000'},
    ];

    // Default empty list for milestones if null
    // final milestones = widget.project['milestones'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project['title'] ?? 'Project Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No tasks available.'));
            } else {
              List<Map<String, dynamic>> tasks = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Status and Progress
                    Text(
                      'Project Status: ${widget.project['status'] ?? "Unknown"}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Progress: ${widget.project['progress'] ?? 0}%'),
                    const SizedBox(height: 20),

                    // // Milestones List
                    // const Text(
                    //   'Milestones:',
                    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(height: 10),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: milestones.length,
                    //   itemBuilder: (context, index) {
                    //     final milestone = milestones[index];
                    //     return ListTile(
                    //       title: Text(milestone['name'] ?? 'Unknown'),
                    //       subtitle: Text('Date: ${milestone['date'] ?? 'Unknown'}'),
                    //       trailing: Icon(
                    //         milestone['completed'] == true
                    //             ? Icons.check_circle
                    //             : Icons.circle_outlined,
                    //         color: milestone['completed'] == true ? Colors.green : Colors.grey,
                    //       ),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: 20),

                    // Tasks List
                    const Text(
                      'Tasks:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return ListTile(
                          title: Text(task['title'] ?? 'Unknown'),
                          subtitle: Text('Due Date: ${task['date'] ?? 'Unknown'} - ${task['priority'] ?? 'Unknown'}'),
                          trailing: Icon(
                            task['status'] == 'Completed'
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: task['status'] == 'Completed' ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Payment History
                    const Text(
                      'Payment History:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentHistory.length,
                      itemBuilder: (context, index) {
                        final payment = paymentHistory[index];
                        return ListTile(
                          title: Text(payment['date']),
                          subtitle: Text('Amount: ${payment['amount']}'),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: _changeProjectStatus,
                            child: const Text('Mark as Completed'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/payment',
                                arguments: widget.project,
                              );
                            },
                            child: const Text('Make Payment'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/review',
                                arguments: widget.project,
                              );
                            },
                            child: const Text('Leave a Review'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
