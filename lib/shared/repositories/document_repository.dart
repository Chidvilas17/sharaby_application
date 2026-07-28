import '../../core/constants/app_enums.dart';
import '../models/document_model.dart';

abstract class DocumentRepository {
  Future<List<MedicalDocumentModel>> getDocuments();
  Future<void> addDocument(MedicalDocumentModel document);
}

class MockDocumentRepository implements DocumentRepository {
  final List<MedicalDocumentModel> _documents = [
    MedicalDocumentModel(
      id: 'DOC-101',
      title: 'Complete Blood Count (CBC) Report',
      patientName: 'Mohamed Ali Hassan',
      patientId: 'P1001',
      category: DocumentCategory.labResult,
      fileSize: '2.4 MB',
      uploadDate: DateTime.now().subtract(const Duration(days: 3)),
      fileExtension: 'PDF',
      uploadedBy: 'Dr. Ahmed Sharaby',
    ),
    MedicalDocumentModel(
      id: 'DOC-102',
      title: 'Chest X-Ray Digital DICOM',
      patientName: 'Sarah Mahmoud',
      patientId: 'P1002',
      category: DocumentCategory.xRay,
      fileSize: '18.5 MB',
      uploadDate: DateTime.now().subtract(const Duration(days: 1)),
      fileExtension: 'DICOM',
      uploadedBy: 'Radiology Tech',
    ),
    MedicalDocumentModel(
      id: 'DOC-103',
      title: 'Discharge Summary & Medical Clearance',
      patientName: 'Youssef Ibrahim',
      patientId: 'P1003',
      category: DocumentCategory.medicalReport,
      fileSize: '1.1 MB',
      uploadDate: DateTime.now().subtract(const Duration(days: 7)),
      fileExtension: 'PDF',
      uploadedBy: 'Dr. Mona Zaki',
    ),
  ];

  @override
  Future<List<MedicalDocumentModel>> getDocuments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_documents);
  }

  @override
  Future<void> addDocument(MedicalDocumentModel document) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _documents.insert(0, document);
  }
}
