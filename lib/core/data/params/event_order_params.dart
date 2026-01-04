import 'dart:convert';

class EventOrderParams {
  final int? id;
  final int eventID;
  final int? memberID;
  final int? guestID;
  final List<int> menuItemIDs;

  EventOrderParams({
    required this.id,
    required this.eventID,
    required this.memberID,
    required this.guestID,
    required this.menuItemIDs,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventID,
      'member_id': memberID,
      'guest_id': guestID,
      'menuItems': jsonEncode(menuItemIDs),
    };
  }
}
