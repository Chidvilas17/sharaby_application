import 'doctor_help_data.dart';
import 'doctor_help_item.dart';

/// Abstract Service Contract for Doctor AI Help
abstract class DoctorHelpService {
  Future<List<DoctorHelpItem>> getHelpItems({
    String? categoryKey,
    String? searchQuery,
    required String languageCode,
  });

  List<Map<String, String>> getCategories();
}

/// Local Offline Implementation of DoctorHelpService
class LocalDoctorHelpService implements DoctorHelpService {
  @override
  Future<List<DoctorHelpItem>> getHelpItems({
    String? categoryKey,
    String? searchQuery,
    required String languageCode,
  }) async {
    // Simulate instantaneous local data retrieval
    List<DoctorHelpItem> results = List.from(DoctorHelpData.items);

    // Filter by Category if specified and not 'all'
    if (categoryKey != null &&
        categoryKey.isNotEmpty &&
        categoryKey.toLowerCase() != 'all') {
      results = results
          .where((item) =>
              item.categoryKey.toLowerCase() == categoryKey.toLowerCase())
          .toList();
    }

    // Filter by Search Query (searches in English, Arabic, and category names)
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      results = results.where((item) {
        final qEng = item.questionEnglish.toLowerCase();
        final qAr = item.questionArabic.toLowerCase();
        final aEng = item.answerEnglish.toLowerCase();
        final aAr = item.answerArabic.toLowerCase();
        final cEng = item.categoryEnglish.toLowerCase();
        final cAr = item.categoryArabic.toLowerCase();

        return qEng.contains(query) ||
            qAr.contains(query) ||
            aEng.contains(query) ||
            aAr.contains(query) ||
            cEng.contains(query) ||
            cAr.contains(query);
      }).toList();
    }

    return results;
  }

  @override
  List<Map<String, String>> getCategories() {
    return const [
      {'key': 'all', 'en': 'All Topics', 'ar': 'جميع المواضيع'},
      {'key': 'fever', 'en': 'Fever', 'ar': 'الحمى والحرارة'},
      {'key': 'cough', 'en': 'Cough & Cold', 'ar': 'السعال والجهاز التنفسي'},
      {'key': 'nutrition', 'en': 'Nutrition', 'ar': 'التغذية والرضاعة'},
      {'key': 'vaccination', 'en': 'Vaccination', 'ar': 'التطعيمات واللقاحات'},
      {'key': 'growth', 'en': 'Growth & Dev', 'ar': 'النمو والتطور'},
      {'key': 'symptoms', 'en': 'Symptoms', 'ar': 'الأعراض الشائعة'},
      {'key': 'medication', 'en': 'Medication', 'ar': 'الأدوية والجرعات'},
      {'key': 'emergency', 'en': 'Emergency', 'ar': 'علامات الطوارئ'},
      {'key': 'records', 'en': 'Records', 'ar': 'سجلات المرضى'},
      {'key': 'workflow', 'en': 'Workflow', 'ar': 'سير العمل بالعيادة'},
    ];
  }
}
