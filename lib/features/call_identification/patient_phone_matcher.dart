import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';

/// Utility to normalize phone numbers and match callers with patient records
class PatientPhoneMatcher {
  /// Normalizes a phone number to a clean digit string (e.g. 201012345678)
  static String normalize(String rawPhone) {
    if (rawPhone.isEmpty) return '';

    // Strip all non-digit characters
    String digits = rawPhone.replaceAll(RegExp(r'\D'), '');

    // Handle Egyptian phone number variations:
    // If starts with 0020... -> remove leading 00 -> 20...
    if (digits.startsWith('0020')) {
      digits = digits.substring(2);
    }
    // If starts with 020... -> remove leading 0 -> 20...
    else if (digits.startsWith('020')) {
      digits = digits.substring(1);
    }
    // If local Egyptian format starting with 01... (11 digits e.g. 01012345678) -> add 20 prefix
    else if (digits.startsWith('01') && digits.length == 11) {
      digits = '20${digits.substring(1)}';
    }

    return digits;
  }

  /// Searches PatientRepository to find a patient matching the given phone number
  static Future<PatientModel?> findMatchingPatient(
    String rawPhoneNumber,
    PatientRepository repository,
  ) async {
    final targetNormalized = normalize(rawPhoneNumber);
    if (targetNormalized.isEmpty) return null;

    final patients = await repository.getPatients();

    for (final patient in patients) {
      final pPhoneNorm = normalize(patient.phone);
      final gPhoneNorm = normalize(patient.guardianPhone);
      final eContactNorm = normalize(patient.emergencyContact);

      if ((pPhoneNorm.isNotEmpty && pPhoneNorm == targetNormalized) ||
          (gPhoneNorm.isNotEmpty && gPhoneNorm == targetNormalized) ||
          (eContactNorm.isNotEmpty && eContactNorm == targetNormalized)) {
        return patient;
      }
    }

    return null;
  }
}
