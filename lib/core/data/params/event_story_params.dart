import 'dart:convert';

class EventStoryParams {
  final int? id;
  final int eventID;
  final String title;
  final String encodedText;
  final DateTime createAt;
  EventStoryParams({
    this.id,
    required this.eventID,
    required this.title,
    required this.encodedText,
    required this.createAt,
  });

  EventStoryParams copyWith({
    int? id,
    int? eventID,
    String? title,
    String? encodedText,
    DateTime? createAt,
  }) {
    return EventStoryParams(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      title: title ?? this.title,
      encodedText: encodedText ?? this.encodedText,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'eventID': eventID,
      'title': title,
      'encodedText': encodedText,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory EventStoryParams.fromMap(Map<String, dynamic> map) {
    return EventStoryParams(
      id: map['id'] != null ? map['id'] as int : null,
      eventID: map['eventID'] as int,
      title: map['title'] as String,
      encodedText: map['encodedText'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventStoryParams.fromJson(String source) =>
      EventStoryParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
