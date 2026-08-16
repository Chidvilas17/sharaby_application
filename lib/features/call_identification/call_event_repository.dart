import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'call_event.dart';

/// Persistence repository for call events using SharedPreferences
class CallEventRepository {
  static const String _keyCallEvents = 'sharaby_call_events_v1';

  /// Load all stored call events
  Future<List<CallEvent>> getCallEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyCallEvents) ?? [];
    return jsonList
        .map((str) => CallEvent.fromJson(jsonDecode(str) as Map<String, dynamic>))
        .toList();
  }

  /// Save a call event (with deduplication by normalized number and timestamp window)
  Future<bool> saveCallEvent(CallEvent event) async {
    final prefs = await SharedPreferences.getInstance();
    final events = await getCallEvents();

    // Check for duplicate call event (same normalized number within 60 seconds)
    final isDuplicate = events.any((existing) =>
        existing.normalizedPhoneNumber == event.normalizedPhoneNumber &&
        existing.timestamp.difference(event.timestamp).inSeconds.abs() < 60);

    if (isDuplicate) return false;

    events.insert(0, event);

    // Keep max 50 recent call events
    if (events.length > 50) {
      events.removeRange(50, events.length);
    }

    final jsonList = events.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_keyCallEvents, jsonList);
    return true;
  }

  /// Mark call event as processed
  Future<void> markEventProcessed(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final events = await getCallEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      events[index] = events[index].copyWith(processed: true, notificationCreated: true);
      final jsonList = events.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(_keyCallEvents, jsonList);
    }
  }
}
