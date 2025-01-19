class ProjectSummary {
  final int id;
  final String title;
  final String description;
  final String status; // Status: Pending, Ongoing, Completed
  final double price;

  ProjectSummary({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.price,
  });

  factory ProjectSummary.fromJson(Map<String, dynamic> json) {
    return ProjectSummary(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      price: json['price'],
    );
  }
}
