import 'dart:convert';

import 'package:pay_pilot/core/data/params/event_story_params.dart';

class ResponseEventStory {
  final int id;
  final String title;
  final String encodedText;
  final DateTime createAt;
  final DateTime updateAt;

  ResponseEventStory({
    required this.id,
    required this.title,
    required this.encodedText,
    required this.createAt,
    required this.updateAt,
  });

  ResponseEventStory copyWith({
    int? id,
    String? title,
    String? encodedText,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return ResponseEventStory(
      id: id ?? this.id,
      title: title ?? this.title,
      encodedText: encodedText ?? this.encodedText,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'encodedText': encodedText,
      'createAt': createAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
    };
  }

  factory ResponseEventStory.fromMap(Map<String, dynamic> map) {
    return ResponseEventStory(
      id: map['id'] as int,
      title: map['title'] as String,
      encodedText: map['encodedText'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int),
    );
  }

  factory ResponseEventStory.fromParams(EventStoryParams params) {
    return ResponseEventStory(
      id: params.id!,
      title: params.title,
      encodedText: params.encodedText,
      createAt: params.createAt,
      updateAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseEventStory.fromJson(String source) =>
      ResponseEventStory.fromMap(json.decode(source) as Map<String, dynamic>);
}
