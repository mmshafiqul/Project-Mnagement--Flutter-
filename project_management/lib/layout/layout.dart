import 'package:flutter/material.dart';
import 'package:project_management/authentication/login.dart';
import 'package:project_management/home/home_page.dart';
import 'package:project_management/notifications/notifications.dart';
import 'package:project_management/payment/payment.dart';
import 'package:project_management/project/projects.dart';
import 'package:project_management/settings/settings.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // To store the selected index of the menu
  int _selectedIndex = 0;

  // Dynamically changing the app bar title based on selected index
  String get _selectedTitle => menuItems[_selectedIndex]['title'];

  // Pages list (we will only change the body and the app bar title)
  List<Widget> pages = [
    HomePage(),
    Projects(),
    Payment(),
    Settings(),
    Login(),
  ];

  // List of menu items in the drawer
  final List<Map<String, dynamic>> menuItems = [
    {"title": "Home", "icon": Icons.home, "action": null},
    {"title": "Projects", "icon": Icons.work, "action": null},
    {"title": "Payment", "icon": Icons.payment, "action": null},
    {"title": "Settings", "icon": Icons.settings, "action": null},
    {
      "title": "Logout",
      "icon": Icons.exit_to_app,
      "action": (BuildContext context) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    },
  ];

  // Map to track hover state for each tile
  final Map<int, bool> _isHovered = {};

  // Show notifications dialog
  void showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Notifications();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade200,
                ),
                curve: Curves.bounceOut,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "client@email.com",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Client",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            // List of dynamic menu items
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  var item = menuItems[index];

                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHovered[index] = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHovered[index] = false;
                      });
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = index;
                        });
                        // If an action is defined, call it (like logout)
                        if (item['action'] != null) {
                          item['action'](context);
                        }
                      },
                      child: ListTile(
                        tileColor: _selectedIndex == index
                            ? Colors.greenAccent
                            : (_isHovered[index] ?? false
                                ? Colors.greenAccent
                                : null),
                        leading: Icon(item["icon"]),
                        title: Text(
                          item["title"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showNotificationDialog(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Icon(
                color: Colors.orangeAccent,
                Icons.notifications,
                size: 28,
              ),
            ),
          ),
        ),
        title: Text(
          _selectedTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 45,
                  child: Icon(
                    color: Colors.blueGrey,
                    Icons.person,
                    size: 35,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(child: pages[_selectedIndex]),
    );
  }
}
