import 'package:flutter/material.dart';
import 'package:project_management/layout/layout.dart'; // Import the home page

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Static credentials for testing
  final String _validEmail = 'test@email.com';
  final String _validPassword = 'password123';

  // Function to move focus to the next field
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _login() {
    // Check if the email and password match the static credentials
    if (_emailController.text == _validEmail &&
        _passwordController.text == _validPassword) {
      // If the credentials are correct, navigate to the home layout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Layout()),
      );
    } else {
      // Show an error message if the credentials are incorrect
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Credentials'),
            content: const Text(
                'Please check your email and password and try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title:
        const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Email Field with rounded borders and green accent
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode, // Focus Node for email field
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "email@email.com",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.email, color: Colors.greenAccent),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: [],
                textInputAction: TextInputAction.next,
                // Move to the next field
                onFieldSubmitted: (_) {
                  // Automatically move focus to the next field when "Next" is pressed on the keyboard
                  _fieldFocusChange(
                      context, _emailFocusNode, _passwordFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password Field with rounded borders and green accent
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode, // Focus Node for password field
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "Enter password",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.lock, color: Colors.greenAccent),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
                obscureText: true,
                autofillHints: [],
                textInputAction: TextInputAction.done,
                // "Done" button on keyboard
                onFieldSubmitted: (_) {
                  // Trigger login when user presses "Done"
                  _login();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Login Button with green accent color
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onPressed: _login,
                child: const Text('Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              const SizedBox(height: 20),

              // Register or forgot password link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to a registration screen or another page
                      // Navigator.push(...);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                        Colors.greenAccent // Green accent for the text
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
