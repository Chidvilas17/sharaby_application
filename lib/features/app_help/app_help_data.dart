import 'package:flutter/material.dart';
import 'app_help_item.dart';

/// Predefined local repository for application usage guidance (App Help)
class AppHelpData {
  static const List<AppHelpItem> items = [
    AppHelpItem(
      id: 'app_001',
      categoryKey: 'patients',
      categoryEnglish: 'Patients',
      categoryArabic: 'المرضى',
      icon: Icons.person_add_rounded,
      questionEnglish: 'How do I add a new patient?',
      questionArabic: 'كيف يمكنني إضافة مريض جديد؟',
      answerEnglish:
          'Open the Patients section from the Dashboard, tap Add Patient, enter the child\'s information (full name, gender, birth date, parents\' details, and blood group), and save the patient record.',
      answerArabic:
          'افتح قسم المرضى من الشاشة الرئيسية، واضغط على إضافة مريض، ثم أدخل بيانات الطفل (الاسم، النوع، تاريخ الميلاد، اسم الوالدين، وفصيلة الدم) واحفظ الملف.',
    ),
    AppHelpItem(
      id: 'app_002',
      categoryKey: 'patients',
      categoryEnglish: 'Patients',
      categoryArabic: 'المرضى',
      icon: Icons.edit_note_rounded,
      questionEnglish: 'How do I edit a patient?',
      questionArabic: 'كيف يمكنني تعديل بيانات مريض؟',
      answerEnglish:
          'Open Patients, select the child from the list, open the patient details screen, and tap the Edit button in the top bar to update information.',
      answerArabic:
          'افتح قسم المرضى، واختر الطفل المطلوب، افتح شاشة تفاصيل المريض واضغط على زر التعديل العلوي لتحديث البيانات.',
    ),
    AppHelpItem(
      id: 'app_003',
      categoryKey: 'patients',
      categoryEnglish: 'Patients',
      categoryArabic: 'المرضى',
      icon: Icons.assignment_ind_rounded,
      questionEnglish: 'How do I view patient details?',
      questionArabic: 'كيف يمكنني عرض تفاصيل مريض؟',
      answerEnglish:
          'Open Patients and tap on any child\'s card to view their complete pediatric profile including growth charts, vitals, medical history, vaccinations, and parents\' contact info.',
      answerArabic:
          'افتح قسم المرضى واضغط على كارت أي طفل لعرض ملفه الطبي الكامل متضمناً منحنيات النمو والقياسات والتاريخ المرضي والتطعيمات ورقم ولي الأمر.',
    ),
    AppHelpItem(
      id: 'app_004',
      categoryKey: 'prescriptions',
      categoryEnglish: 'Prescriptions',
      categoryArabic: 'الروشتات والأدوية',
      icon: Icons.receipt_long_rounded,
      questionEnglish: 'How do I create a prescription?',
      questionArabic: 'كيف يمكنني إنشاء روشتة جديدة؟',
      answerEnglish:
          'Open Prescriptions from the navigation menu and select New Prescription. Choose the child, enter diagnosis, add medicines with exact pediatric dosages, and tap Issue Prescription.',
      answerArabic:
          'افتح قسم الروشتات من القائمة واضغط على إنشاء روشتة جديدة. اختر الطفل، أدخل التشخيص، أضف الأدوية بجرعات الأطفال الدقيقة واضغط إصدار الروشتة.',
    ),
    AppHelpItem(
      id: 'app_005',
      categoryKey: 'documents',
      categoryEnglish: 'Documents',
      categoryArabic: 'المستندات والملفات',
      icon: Icons.file_download_rounded,
      questionEnglish: 'How do I download a document?',
      questionArabic: 'كيف يمكنني تنزيل مستند أو تقرير؟',
      answerEnglish:
          'Open Documents from the main navigation menu, browse the clinical documents list, and tap the Download action button next to the desired document.',
      answerArabic:
          'افتح قسم المستندات من القائمة الرئيسية، تصفح المستندات واضغط على زر التنزيل المكتبي بجانب الملف المطلوب.',
    ),
    AppHelpItem(
      id: 'app_006',
      categoryKey: 'settings',
      categoryEnglish: 'Settings',
      categoryArabic: 'الإعدادات',
      icon: Icons.translate_rounded,
      questionEnglish: 'How do I change the language?',
      questionArabic: 'كيف يمكنني تغيير لغة التطبيق؟',
      answerEnglish:
          'Open Settings from the navigation drawer, locate the Language section, and select English or Arabic to instantly update the entire app.',
      answerArabic:
          'افتح الإعدادات من القائمة الجانبية، اختر قسم اللغة، وحدد اللغة العربية أو الإنجليزية لتحديث التطبيق فوراً.',
    ),
    AppHelpItem(
      id: 'app_007',
      categoryKey: 'profile',
      categoryEnglish: 'Profile',
      categoryArabic: 'الملف الشخصي',
      icon: Icons.account_circle_rounded,
      questionEnglish: 'How do I edit my profile?',
      questionArabic: 'كيف يمكنني تعديل الملف الشخصي للطبيب؟',
      answerEnglish:
          'Open Profile from the navigation drawer, review your doctor information, and select Edit Profile to update contact details and clinic credentials.',
      answerArabic:
          'افتح الملف الشخصي من القائمة الجانبية واضغط على تعديل الملف الشخصي لتحديث بيانات التواصل وعنوان العيادة.',
    ),
    AppHelpItem(
      id: 'app_008',
      categoryKey: 'notifications',
      categoryEnglish: 'Notifications',
      categoryArabic: 'الإشعارات',
      icon: Icons.notifications_active_rounded,
      questionEnglish: 'How do I view notifications?',
      questionArabic: 'كيف يمكنني عرض الإشعارات والتنبيهات؟',
      answerEnglish:
          'Tap the Notification Bell icon at the top of the Dashboard or open Notifications from the main menu to view all clinical alerts and appointment updates.',
      answerArabic:
          'اضغط على أيقونة الجرس العلوية بالشاشة الرئيسية أو افتح قسم الإشعارات من القائمة لمتابعة جميع التنبيهات وتحديثات المواعيد.',
    ),
    AppHelpItem(
      id: 'app_009',
      categoryKey: 'billing',
      categoryEnglish: 'Billing',
      categoryArabic: 'الحسابات والفواتير',
      icon: Icons.account_balance_wallet_rounded,
      questionEnglish: 'How do I access billing?',
      questionArabic: 'كيف يمكنني الوصول إلى الحسابات والفواتير؟',
      answerEnglish:
          'Open the Billing/Financial section from the application navigation. Note that viewing protected revenue figures requires entering the clinic security PIN (default: 1234).',
      answerArabic:
          'افتح قسم الحسابات والفواتير من القائمة. يرجى العلم أن عرض المبالغ المحمية يتطلب إدخال رقم PIN الأمني الخاص بالعيادة (الافتراضي: 1234).',
    ),
    AppHelpItem(
      id: 'app_010',
      categoryKey: 'navigation',
      categoryEnglish: 'Navigation',
      categoryArabic: 'التنقل في التطبيق',
      icon: Icons.arrow_back_rounded,
      questionEnglish: 'How do I return to the previous screen?',
      questionArabic: 'كيف يمكنني العودة للشاشة السابقة؟',
      answerEnglish:
          'Use the glossy back arrow button at the top-left (or top-right in Arabic RTL) of any secondary screen to smoothly return to the previous view.',
      answerArabic:
          'استخدم زر السهم العلوي المستدير في أعلى الشاشة للعودة إلى الشاشة السابقة بسلاسة.',
    ),
    AppHelpItem(
      id: 'app_011',
      categoryKey: 'account',
      categoryEnglish: 'Account & Login',
      categoryArabic: 'الحساب والدخول',
      icon: Icons.lock_open_rounded,
      questionEnglish: 'How do I log in?',
      questionArabic: 'كيف يمكنني تسجيل الدخول؟',
      answerEnglish:
          'Open the application, enter your registered Firebase account credentials (email and password) on the Login screen, and tap Login.',
      answerArabic:
          'افتح التطبيق، أدخل بيانات حساب الطبيب المسجل (البريد الإلكتروني وكلمة المرور) في شاشة الدخول واضغط تسجيل الدخول.',
    ),
    AppHelpItem(
      id: 'app_012',
      categoryKey: 'account',
      categoryEnglish: 'Account & Login',
      categoryArabic: 'الحساب والدخول',
      icon: Icons.contact_support_rounded,
      questionEnglish: 'What should I do if I cannot log in?',
      questionArabic: 'ماذا أفعل إذا لم أتمكن من تسجيل الدخول؟',
      answerEnglish:
          'Verify your email address and password format. If you forgot your password, tap "Forgot Password?" to reset. If issues persist, contact clinic IT support.',
      answerArabic:
          'تحقق من كتابة البريد الإلكتروني وكلمة المرور بدقة. في حالة النسيان اضغط "نسيت كلمة المرور؟". وإذا استمرت المشكلة تواصل مع الدعم الفني.',
    ),
  ];
}
