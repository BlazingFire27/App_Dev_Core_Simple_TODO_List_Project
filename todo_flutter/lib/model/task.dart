class Task{
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;

  Task({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt
  });

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['_id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String()
    };
  }
}