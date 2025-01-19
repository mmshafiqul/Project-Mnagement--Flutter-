import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_management/project/projects.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ProjectRequest extends StatefulWidget {
  const ProjectRequest({super.key});

  @override
  State<ProjectRequest> createState() => _ProjectRequestState();
}

class _ProjectRequestState extends State<ProjectRequest> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String? _selectedPriority;
  String? _selectedDepartment;

  String? clientName;
  String? clientEmail;

  // Priority options
  final List<String> priorityOptions = ['High', 'Medium', 'Low'];

  // Department options
  final List<String> departmentOptions = ['Design', 'Development', 'Marketing', 'Testing'];

  // To retrieve client name and email from shared preferences (logged-in user)
  Future<void> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName = prefs.getString('clientName');
    clientEmail = prefs.getString('clientEmail');
    setState(() {}); // Refresh the UI
  }

  // Submit form to API
  Future<void> _submitForm() async {
    setState(() {
      _getUserInfo();
    });
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final priority = _selectedPriority ?? '';
      final department = _selectedDepartment ?? '';
      final price = double.tryParse(_priceController.text) ?? 0.0;

      // Prepare the data for the API call
      final projectData = {
        'title': title,
        'description': description,
        'department': department,
        'priority': priority,
        'price': price,
        'startDate': _startDate?.toIso8601String(),
        'endDate': _endDate?.toIso8601String(),
        'status': 'Pending',
        'clientName': clientName ?? '',
        'clientEmail': clientEmail ?? '',
        'employeeName': "suzon",
        'employeeEmail': "suzon@email.com",
      };

      // POST request to save the project
      final response = await http.post(
        Uri.parse('http://localhost:8080/project/save'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(projectData),
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Project request submitted successfully!')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Projects(),
            )); // Navigate back after submission
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to submit project. Error: ${response.statusCode}')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo(); // Get the logged-in user's info
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Project Request'),
        backgroundColor: Colors.greenAccent, // Green color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: _buildInputDecoration('Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: _buildInputDecoration('Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // Department Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDepartment,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDepartment = newValue;
                  });
                },
                items: departmentOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: _buildInputDecoration('Department'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                onChanged: (newValue) {
                  setState(() {
                    _selectedPriority = newValue;
                  });
                },
                items: priorityOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: _buildInputDecoration('Priority'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a priority';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: _buildInputDecoration('Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // Start Date Field
              TextFormField(
                controller: _startDateController,
                decoration: _buildInputDecoration('Start Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                      _startDateController.text =
                          DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12), // Space between fields

              // End Date Field
              TextFormField(
                controller: _endDateController,
                decoration: _buildInputDecoration('End Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _endDate = picked;
                      _endDateController.text =
                          DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Space before the button

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Request'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Green color for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom method to build input decoration with rounded borders and green accent
  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.greenAccent),
    );
  }
}
