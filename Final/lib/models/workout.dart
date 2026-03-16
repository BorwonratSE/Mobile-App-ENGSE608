class Workout {
  final int? id;
  final String activity;
  final String type;
  final int duration;
  final int calories;
  final String date;
  final String note;

  Workout({
    this.id,
    required this.activity,
    required this.type,
    required this.duration,
    required this.calories,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity': activity,
      'type': type,
      'duration': duration,
      'calories': calories,
      'date': date,
      'note': note,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      activity: map['activity'],
      type: map['type'],
      duration: map['duration'],
      calories: map['calories'],
      date: map['date'],
      note: map['note'],
    );
  }
}