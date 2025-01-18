import 'package:flutter/material.dart';

class ProjectDetail extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectDetail({super.key, required this.project});

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  // Sample payment history
  final List<Map<String, dynamic>> paymentHistory = [
    {'date': '2025-01-01', 'amount': '৳ 2000'},
    {'date': '2025-01-15', 'amount': '৳ 3000'},
  ];

  void _changeProjectStatus() {
    setState(() {
      widget.project['status'] = 'Completed'; // Update project status
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project Status Changed to Completed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Status and Progress
            Text(
              'Project Status: ${widget.project['status']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Progress: ${widget.project['progress']}%'),
            const SizedBox(height: 20),

            // Milestones List
            const Text(
              'Milestones:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.project['milestones'].length,
              itemBuilder: (context, index) {
                final milestone = widget.project['milestones'][index];
                return ListTile(
                  title: Text(milestone['name']),
                  subtitle: Text('Date: ${milestone['date']}'),
                  trailing: Icon(
                    milestone['completed']
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: milestone['completed'] ? Colors.green : Colors.grey,
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

            // Buttons with SingleChildScrollView to allow horizontal scrolling
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
      ),
    );
  }
}
