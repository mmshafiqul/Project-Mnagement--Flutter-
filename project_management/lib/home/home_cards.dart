import 'package:flutter/material.dart';
import 'package:project_management/project/project_list_screen.dart';
import 'package:project_management/project/projects.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Summary Cards
          GridView.count(
            shrinkWrap: true,
            // Shrinks the GridView to take only as much space as needed
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: NeverScrollableScrollPhysics(),
            // Prevent scrolling in the grid
            children: const [
              // Total Projects Card
              SummaryCard(
                title: 'Total Projects',
                value: '20',
                icon: Icons.work_outline,
                color: Colors.purple,
              ),
              // Completed Projects Card
              SummaryCard(
                title: 'Completed Projects',
                value: '12',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
              // Active Projects Card
              SummaryCard(
                title: 'Active Projects',
                value: '5',
                icon: Icons.work,
                color: Colors.blue,
              ),
              // Pending Projects Card
              SummaryCard(
                title: 'Pending Projects',
                value: '3',
                icon: Icons.pending,
                color: Colors.orange,
              ),
              // Pending Payments Card
              SummaryCard(
                title: 'Pending Payments',
                value: '3',
                icon: Icons.payment,
                color: Colors.orange,
              ),
              // Total Payments Card
              SummaryCard(
                title: 'Total Payments',
                value: '50000',
                icon: Icons.payment_outlined,
                color: Colors.red,
              ),
            ],
          ),

          // Action Buttons
          SizedBox(height: 10), // Reduced space between grid and action buttons
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
              // Wrap title with Center widget to center align it
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
