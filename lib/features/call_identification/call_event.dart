enum CallType {
  missed,
  incoming,
  outgoing,
}

/// Data model representing a call event (incoming / missed call)
class CallEvent {
  final String id;
  final String phoneNumber;
  final String normalizedPhoneNumber;
  final CallType callType;
  final DateTime timestamp;
  final String? patientId;
  final String? patientName;
  final bool processed;
  final bool notificationCreated;

  const CallEvent({
    required this.id,
    required this.phoneNumber,
    required this.normalizedPhoneNumber,
    required this.callType,
    required this.timestamp,
    this.patientId,
    this.patientName,
    this.processed = false,
    this.notificationCreated = false,
  });

  CallEvent copyWith({
    String? id,
    String? phoneNumber,
    String? normalizedPhoneNumber,
    CallType? callType,
    DateTime? timestamp,
    String? patientId,
    String? patientName,
    bool? processed,
    bool? notificationCreated,
  }) {
    return CallEvent(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      normalizedPhoneNumber:
          normalizedPhoneNumber ?? this.normalizedPhoneNumber,
      callType: callType ?? this.callType,
      timestamp: timestamp ?? this.timestamp,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      processed: processed ?? this.processed,
      notificationCreated: notificationCreated ?? this.notificationCreated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'normalizedPhoneNumber': normalizedPhoneNumber,
      'callType': callType.name,
      'timestamp': timestamp.toIso8601String(),
      'patientId': patientId,
      'patientName': patientName,
      'processed': processed,
      'notificationCreated': notificationCreated,
    };
  }

  factory CallEvent.fromJson(Map<String, dynamic> json) {
    return CallEvent(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      normalizedPhoneNumber: json['normalizedPhoneNumber'] as String,
      callType: CallType.values.firstWhere(
        (e) => e.name == json['callType'],
        orElse: () => CallType.missed,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      patientId: json['patientId'] as String?,
      patientName: json['patientName'] as String?,
      processed: json['processed'] as bool? ?? false,
      notificationCreated: json['notificationCreated'] as bool? ?? false,
    );
  }
}
