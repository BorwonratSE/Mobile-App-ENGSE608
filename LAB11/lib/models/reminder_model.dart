class Reminder {
  final int? id;
  final int eventId;
  final DateTime remindAt;
  final bool active;

  Reminder({
    this.id,
    required this.eventId,
    required this.remindAt,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "eventId": eventId,
      "remindAt": remindAt.toIso8601String(),
      "active": active ? 1 : 0,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map["id"],
      eventId: map["eventId"],
      remindAt: DateTime.parse(map["remindAt"]),
      active: map["active"] == 1,
    );
  }
}
