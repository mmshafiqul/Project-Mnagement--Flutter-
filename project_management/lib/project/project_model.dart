class Project {
  final int id;
  final String title;
  final String description;
  final String department;
  final String priority;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String clientName;
  final String clientEmail;
  final String employeeName;
  final String employeeEmail;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.priority,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.clientName,
    required this.clientEmail,
    required this.employeeName,
    required this.employeeEmail,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      department: json['department'],
      priority: json['priority'],
      price: json['price'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      clientName: json['clientName'],
      clientEmail: json['clientEmail'],
      employeeName: json['employeeName'],
      employeeEmail: json['employeeEmail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'department': department,
      'priority': priority,
      'price': price,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'employeeName': employeeName,
      'employeeEmail': employeeEmail,
    };
  }
}
