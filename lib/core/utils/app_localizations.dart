import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'appName': 'Sharaby Center',
      'appSubtitle': 'Healthcare Management Solution',
      // Onboarding
      'onboarding1Title': 'Welcome to Sharaby Center',
      'onboarding1Desc':
          'Your trusted healthcare management solution for doctors, receptionists and clinic staff.',
      'onboarding2Title': 'Manage Patients Easily',
      'onboarding2Desc':
          'Manage appointments, prescriptions, patient history, billing and medical reports from one application.',
      'onboarding3Title': 'Stay Connected Anywhere',
      'onboarding3Desc':
          'Access clinic information securely anytime with real-time synchronization.',
      'btnNext': 'Next',
      'btnBack': 'Back',
      'btnGetStarted': 'Get Started',
      // Auth
      'loginTitle': 'Welcome Back',
      'loginSubtitle': 'Sign in to access Sharaby Center',
      'emailLabel': 'Email Address',
      'passwordLabel': 'Password',
      'forgotPassword': 'Forgot Password?',
      'signIn': 'Sign In',
      'signUp': 'Sign Up',
      'noAccount': "Don't have an account?",
      'haveAccount': 'Already have an account?',
      // Navigation
      'navDashboard': 'Dashboard',
      'navPatients': 'Patients',
      'navAppointments': 'Appointments',
      'navPrescriptions': 'Prescriptions',
      'navBilling': 'Billing',
      'navReports': 'Reports',
      'navDocuments': 'Documents',
      'navNotifications': 'Notifications',
      'navProfile': 'Profile',
      'navSettings': 'Settings',
      'navAbout': 'About',
      'navLogout': 'Logout',
      // Dashboard
      'greetingDay': 'Good Day,',
      'doctorRole': 'Clinic Director / Doctor',
      'searchPlaceholder': 'Search patients, prescriptions, records...',
      'medicalBannerTitle': 'Sharaby Medical Excellence',
      'medicalBannerSubtitle':
          'Providing top quality healthcare and patient management services.',
      'statTotalPatients': 'Total Patients',
      'statAppointments': "Today's Visits",
      'statPrescriptions': 'Prescriptions',
      'statBilling': 'Total Revenue',
      'quickActions': 'Quick Actions',
      'actionAddPatient': 'Add Patient',
      'actionNewPrescription': 'New Rx',
      'actionCreateInvoice': 'New Invoice',
      'actionViewReports': 'Reports',
      'todaysActivity': "Today's Activity",
      'recentPatients': 'Recent Patients',
      'recentPrescriptions': 'Recent Prescriptions',
      'recentBilling': 'Recent Invoices',
      'viewAll': 'View All',
      // Profile
      'editProfile': 'Edit Profile',
      'fullName': 'Full Name',
      'phone': 'Phone Number',
      'email': 'Email Address',
      'address': 'Clinic Address',
      'saveChanges': 'Save Changes',
      'cancel': 'Cancel',
      'profileUpdated': 'Profile updated successfully!',
      // Settings
      'settingsTitle': 'Settings',
      'appearance': 'Appearance & Theme',
      'language': 'Language / اللغة',
      'notifications': 'Push Notifications',
      'about': 'About Sharaby Center',
      'privacy': 'Privacy Policy',
      'version': 'App Version 1.0.0',
      'english': 'English',
      'arabic': 'العربية (Arabic)',
      // Notifications
      'notificationsTitle': 'Notifications',
      'all': 'All',
      'unread': 'Unread',
      'markAllRead': 'Mark all read',
      // Documents
      'documentsTitle': 'Clinic Documents',
      'exportSubtitle': 'Export clinic patient database into CSV format.',
      'downloadCsv': 'Download CSV',
      'csvSuccess': 'CSV generated and saved successfully!',
      'shareFile': 'Share File',
    },
    'ar': {
      'appName': 'مركز شرابي الطبى',
      'appSubtitle': 'حل إدارة الرعاية الصحية المتكامل',
      // Onboarding
      'onboarding1Title': 'مرحباً بك في مركز شرابي',
      'onboarding1Desc':
          'حل إدارة الرعاية الصحية الموثوق للأطباء وموظفي الاستقبال وطاقم العيادة.',
      'onboarding2Title': 'إدارة المرضى بسهولة',
      'onboarding2Desc':
          'إدارة المواعيد والروشتات والسجل الطبي والفواتير والتقارير الطبية من تطبيق واحد.',
      'onboarding3Title': 'تواصل من أي مكان',
      'onboarding3Desc':
          'الوصول إلى معلومات العيادة بأمان في أي وقت مع المزامنة الفورية.',
      'btnNext': 'التالي',
      'btnBack': 'السابق',
      'btnGetStarted': 'ابدأ الآن',
      // Auth
      'loginTitle': 'مرحباً بعودتك',
      'loginSubtitle': 'تسجيل الدخول للوصول إلى مركز شرابي',
      'emailLabel': 'البريد الإلكتروني',
      'passwordLabel': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'signIn': 'تسجيل الدخول',
      'signUp': 'إنشاء حساب',
      'noAccount': 'ليس لديك حساب؟',
      'haveAccount': 'لديك حساب بالفعل؟',
      // Navigation
      'navDashboard': 'لوحة التحكم',
      'navPatients': 'المرضى',
      'navAppointments': 'المواعيد',
      'navPrescriptions': 'الروشتات',
      'navBilling': 'الفواتير',
      'navReports': 'التقارير',
      'navDocuments': 'المستندات',
      'navNotifications': 'الإشعارات',
      'navProfile': 'الملف الشخصي',
      'navSettings': 'الإعدادات',
      'navAbout': 'عن التطبيق',
      'navLogout': 'تسجيل الخروج',
      // Dashboard
      'greetingDay': 'يوم سعيد،',
      'doctorRole': 'مدير العيادة / طبيب',
      'searchPlaceholder': 'البحث عن مرضى، روشتات، سجلات...',
      'medicalBannerTitle': 'تميز مركز شرابي الطبي',
      'medicalBannerSubtitle':
          'تقديم أفضل خدمات الرعاية الصحية وإدارة المرضى بأعلى جودة.',
      'statTotalPatients': 'إجمالي المرضى',
      'statAppointments': 'زيارات اليوم',
      'statPrescriptions': 'الروشتات النشطة',
      'statBilling': 'إجمالي الإيرادات',
      'quickActions': 'إجراءات سريعة',
      'actionAddPatient': 'إضافة مريض',
      'actionNewPrescription': 'روشتة جديدة',
      'actionCreateInvoice': 'فاتورة جديدة',
      'actionViewReports': 'التقارير',
      'todaysActivity': 'نشاط اليوم',
      'recentPatients': 'أحدث المرضى',
      'recentPrescriptions': 'أحدث الروشتات',
      'recentBilling': 'أحدث الفواتير',
      'viewAll': 'عرض الكل',
      // Profile
      'editProfile': 'تعديل الملف الشخصي',
      'fullName': 'الاسم بالكامل',
      'phone': 'رقم الهاتف',
      'email': 'البريد الإلكتروني',
      'address': 'عنوان العيادة',
      'saveChanges': 'حفظ التغييرات',
      'cancel': 'إلغاء',
      'profileUpdated': 'تم تحديث الملف الشخصي بنجاح!',
      // Settings
      'settingsTitle': 'الإعدادات',
      'appearance': 'المظهر والمظهر الداكن',
      'language': 'اللغة / Language',
      'notifications': 'التنبيهات والإشعارات',
      'about': 'عن مركز شرابي',
      'privacy': 'سياسة الخصوصية',
      'version': 'إصدار التطبيق 1.0.0',
      'english': 'English',
      'arabic': 'العربية (Arabic)',
      // Notifications
      'notificationsTitle': 'الإشعارات',
      'all': 'الكل',
      'unread': 'غير مقروء',
      'markAllRead': 'تحديد الكل كمقروء',
      // Documents
      'documentsTitle': 'مستندات العيادة',
      'exportSubtitle': 'تصدير قاعدة بيانات المرضى بصيغة CSV.',
      'downloadCsv': 'تحميل ملف CSV',
      'csvSuccess': 'تم إنشاء وحفظ ملف CSV بنجاح!',
      'shareFile': 'مشاركة الملف',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
