import '../../core/constants/app_enums.dart';

class MedicalDocumentModel {
  final String id;
  final String title;
  final String patientName;
  final String patientId;
  final DocumentCategory category;
  final String fileSize;
  final DateTime uploadDate;
  final String fileExtension;
  final String uploadedBy;

  const MedicalDocumentModel({
    required this.id,
    required this.title,
    required this.patientName,
    required this.patientId,
    required this.category,
    required this.fileSize,
    required this.uploadDate,
    required this.fileExtension,
    required this.uploadedBy,
  });
}
