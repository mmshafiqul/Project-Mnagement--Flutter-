import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // Function to show the notifications dialog

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      scrollable: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Notifications',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications,
            color: Colors.greenAccent,
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            'You have 3 new notifications!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          // List of notifications (can be dynamic as well)
          ListTile(
            leading: Icon(Icons.mail, color: Colors.greenAccent),
            title: Text("New message from client"),
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.greenAccent),
            title: Text("Payment received"),
          ),
          ListTile(
            leading: Icon(Icons.work, color: Colors.greenAccent),
            title: Text("Project update available"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Material(
            color: Colors.greenAccent, // Background color
            borderRadius: BorderRadius.circular(25), // Round corners
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // Padding around text
              child: Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color (white for contrast)
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
