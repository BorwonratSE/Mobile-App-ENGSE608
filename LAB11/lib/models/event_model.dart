class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final int categoryId;
  final DateTime updatedAt;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.categoryId,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "status": status,
      "categoryId": categoryId,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      startTime: DateTime.parse(map["startTime"]),
      endTime: DateTime.parse(map["endTime"]),
      status: map["status"],
      categoryId: map["categoryId"],
      updatedAt: DateTime.parse(map["updatedAt"]),
    );
  }

  Event copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
    int? categoryId,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
