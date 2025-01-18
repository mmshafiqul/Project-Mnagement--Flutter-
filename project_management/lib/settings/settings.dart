import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'English';
  bool isDarkMode = false;

  // Sample user profile data
  String username = 'John Doe';
  String email = 'john.doe@example.com';
  String phone = '+1234567890';

  // Method to toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  // Method to change language
  void _changeLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  // Method to toggle notifications
  void _toggleNotifications(bool value) {
    setState(() {
      isNotificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Settings Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              // Profile Section
              const Text(
                'Profile Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Username'),
                subtitle: Text(username),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Open profile edit screen (not implemented here)
                  },
                ),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(email),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Open email edit screen (not implemented here)
                  },
                ),
              ),
              ListTile(
                title: const Text('Phone Number'),
                subtitle: Text(phone),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Open phone edit screen (not implemented here)
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Notification Settings Section
              const Text(
                'Notification Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: isNotificationsEnabled,
                onChanged: _toggleNotifications,
              ),
              const SizedBox(height: 20),

              // Language Settings Section
              const Text(
                'Language Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Select Language'),
                subtitle: Text(selectedLanguage),
                onTap: () {
                  // Open language selection dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Select Language'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: ['English', 'Spanish', 'French', 'German']
                              .map((lang) => ListTile(
                                    title: Text(lang),
                                    onTap: () {
                                      _changeLanguage(lang);
                                      Navigator.pop(context);
                                    },
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              // Dark Mode Section
              const Text(
                'Theme Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Enable Dark Mode'),
                value: isDarkMode,
                onChanged: _toggleDarkMode,
              ),
              const SizedBox(height: 20),

              // Logout Button

            ],
          ),
        ),
      ),
    );
  }
}
