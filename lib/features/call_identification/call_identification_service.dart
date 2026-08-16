import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';
import 'call_event.dart';
import 'call_event_repository.dart';
import 'patient_phone_matcher.dart';

/// Main Service coordinating Patient Call Identification & Missed Call Processing
class CallIdentificationService {
  static const String _prefEnabled = 'sharaby_call_identification_enabled';
  static const MethodChannel _platform = MethodChannel('com.sharaby.clinic/call_log');

  final CallEventRepository _eventRepository = CallEventRepository();

  /// Check if Patient Call Identification setting is enabled (defaults to true)
  Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefEnabled) ?? true;
  }

  /// Toggle Patient Call Identification setting
  Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefEnabled, enabled);
  }

  /// Check if phone/call_log permission is granted
  Future<bool> hasPermission() async {
    final status = await Permission.phone.status;
    return status.isGranted;
  }

  /// Request phone permission
  Future<bool> requestPermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  /// Query native Android CallLog for recent missed calls and match against patient records
  Future<List<CallEvent>> syncMissedCalls(PatientRepository patientRepository) async {
    if (!await isEnabled()) return [];
    if (!await hasPermission()) return [];

    try {
      final List<dynamic>? nativeCalls =
          await _platform.invokeMethod('getRecentMissedCalls');

      if (nativeCalls == null || nativeCalls.isEmpty) return [];

      final List<CallEvent> newProcessedEvents = [];

      for (final item in nativeCalls) {
        if (item is Map) {
          final rawPhone = item['phoneNumber']?.toString() ?? '';
          final timestampMs = item['timestamp'] as int? ?? 0;
          final timestamp = DateTime.fromMillisecondsSinceEpoch(timestampMs);

          if (rawPhone.isEmpty) continue;

          final normalized = PatientPhoneMatcher.normalize(rawPhone);
          final eventId = 'call_${normalized}_$timestampMs';

          // Search patient repository for matching registered phone number
          final PatientModel? matchedPatient =
              await PatientPhoneMatcher.findMatchingPatient(rawPhone, patientRepository);

          final callEvent = CallEvent(
            id: eventId,
            phoneNumber: rawPhone,
            normalizedPhoneNumber: normalized,
            callType: CallType.missed,
            timestamp: timestamp,
            patientId: matchedPatient?.id,
            patientName: matchedPatient?.fullName,
            processed: true,
            notificationCreated: true,
          );

          final isNew = await _eventRepository.saveCallEvent(callEvent);
          if (isNew) {
            newProcessedEvents.add(callEvent);
          }
        }
      }

      return newProcessedEvents;
    } catch (e) {
      return [];
    }
  }

  /// Get stored call events
  Future<List<CallEvent>> getHistory() async {
    return _eventRepository.getCallEvents();
  }
}
