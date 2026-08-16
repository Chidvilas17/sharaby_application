import 'package:flutter/material.dart';
import 'doctor_help_item.dart';

/// Predefined repository of pediatric clinical Q&A items
class DoctorHelpData {
  static const List<DoctorHelpItem> items = [
    // --- 1. Fever & Vitals ---
    DoctorHelpItem(
      id: 'fever_001',
      categoryKey: 'fever',
      categoryEnglish: 'Fever',
      categoryArabic: 'الحمى والحرارة',
      icon: Icons.thermostat_rounded,
      questionEnglish: 'What should I check when a child presents with fever?',
      questionArabic: 'ما الذي يجب فحصه عند إصابة الطفل بالحمى؟',
      answerEnglish:
          'Review temperature trend, general appearance, alertness, hydration status, capillary refill time, work of breathing, and presence of skin rashes. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'فحص منحنى الحرارة، المظهر العام، درجة الوعي، الترطيب، زمن إعادة امتلاء الشعيرات، مجهود التنفس، ووجود طفح جلدي. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'fever_002',
      categoryKey: 'fever',
      categoryEnglish: 'Fever',
      categoryArabic: 'الحمى والحرارة',
      icon: Icons.shield_moon_rounded,
      questionEnglish: 'When does pediatric fever require immediate emergency referral?',
      questionArabic: 'متى تتطلب حرارة الأطفال الإحالة الفورية للطوارئ؟',
      answerEnglish:
          'Infants under 3 months with temperature ≥38.0°C, extreme lethargy, neck stiffness, non-blanching petechial rash, or grunting respiration. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الرضع أقل من 3 أشهر بدرجة حرارة ≥38.0°م، الخمول الشديد، تيبس الرقبة، الطفح الجلدي النزفي غير المبيض، أو الخرير التنفسي. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'fever_003',
      categoryKey: 'fever',
      categoryEnglish: 'Fever',
      categoryArabic: 'الحمى والحرارة',
      icon: Icons.medication_liquid_rounded,
      questionEnglish: 'How should antipyretic dosing be calculated for pediatric fever?',
      questionArabic: 'كيف يتم حساب جرعة خافض الحرارة للأطفال؟',
      answerEnglish:
          'Dose strictly by exact child weight in kg: Paracetamol 10-15 mg/kg every 4-6 hours (max 60 mg/kg/day); Ibuprofen 5-10 mg/kg every 6-8 hours (only if >6 months). Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'حساب الجرعة بدقة حسب وزن الطفل بالجم/كجم: الباراسيتامول 10-15 ملجم/كجم كل 4-6 ساعات؛ الإيبوبروفين 5-10 ملجم/كجم كل 6-8 ساعات (فقط للأطفال فوق 6 أشهر). استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 2. Cough & Respiratory ---
    DoctorHelpItem(
      id: 'cough_001',
      categoryKey: 'cough',
      categoryEnglish: 'Cough & Cold',
      categoryArabic: 'السعال والجهاز التنفسي',
      icon: Icons.air_rounded,
      questionEnglish: 'What parameters should be documented for pediatric respiratory distress?',
      questionArabic: 'ما الإشارات التي يجب توثيقها عند وجود صعوبة تنفس للطفل؟',
      answerEnglish:
          'Document respiratory rate, oxygen saturation (SpO2), subcostal/intercostal retractions, nasal flaring, stridor or wheeze on auscultation, and child’s ability to feed. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'توثيق معدل التنفس، نسبة أكسجين الدم (SpO2)، انكماش الأضلاع، اتساع فتحتي الأنف، وجود صرير أو أزيز أثناء الفحص، وقدرة الطفل على الرضاعة/الرضاعة. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'cough_002',
      categoryKey: 'cough',
      categoryEnglish: 'Cough & Cold',
      categoryArabic: 'السعال والجهاز التنفسي',
      icon: Icons.medical_services_rounded,
      questionEnglish: 'How to differentiate between Croup and Acute Bronchiolitis?',
      questionArabic: 'كيف تفرق بين الكروب (الخنّاق) والالتهاب الشعيبي الحاد؟',
      answerEnglish:
          'Croup features barking cough and inspiratory stridor (upper airway). Bronchiolitis features wheezing, tachypnea, and retractions in infants <2 yrs (lower airway). Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الكروب يتميز بسعال نباحي وصوت صرير عند الشهيق. بينما الالتهاب الشعيبي يتميز بأزيز ومعدل تنفس سريع لدى الرضع أقل من سنتين. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 3. Nutrition & Infant Feeding ---
    DoctorHelpItem(
      id: 'nutrition_001',
      categoryKey: 'nutrition',
      categoryEnglish: 'Nutrition',
      categoryArabic: 'التغذية والرضاعة',
      icon: Icons.rice_bowl_rounded,
      questionEnglish: 'What are the core recommendations for infant feeding and weaning?',
      questionArabic: 'ما هي التوصيات الأساسية لرضاعة الأطفال وبداية الفطام؟',
      answerEnglish:
          'Exclusive breastfeeding for the first 6 months. Introduce single-ingredient iron-rich solid foods at 6 months while continuing breastfeeding up to 2 years or beyond. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الرضاعة الطبيعية المطلقة خلال أول 6 أشهر. إدخال الأغذية الصلبة الغنية بالحديد عند إتمام 6 أشهر مع الاستمرار بالرضاعة حتى سنتين. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'nutrition_002',
      categoryKey: 'nutrition',
      categoryEnglish: 'Nutrition',
      categoryArabic: 'التغذية والرضاعة',
      icon: Icons.water_drop_rounded,
      questionEnglish: 'What are the clinical signs of mild to moderate pediatric dehydration?',
      questionArabic: 'ما هي العلامات السريرية للجفاف الخفيف والمتوسط لدى الأطفال؟',
      answerEnglish:
          'Dry mucous membranes, decreased urine output (<3 wet diapers/day), sunken anterior fontanelle, slightly reduced skin turgor, and absent tears during crying. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'جفاف الأغشية المخاطية، قلة التبول (<3 حفاضات مبللة/يوم)، انخفاض اليافوخ الأمامي، انخفاض مرونة الجلد، وغياب الدموع عند البكاء. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 4. Vaccination & Immunizations ---
    DoctorHelpItem(
      id: 'vaccine_001',
      categoryKey: 'vaccination',
      categoryEnglish: 'Vaccination',
      categoryArabic: 'التطعيمات واللقاحات',
      icon: Icons.vaccines_rounded,
      questionEnglish: 'What vaccination status check should occur at every pediatric visit?',
      questionArabic: 'ما الفحص الخاص بالتطعيمات الذي يجب إجراؤه في كل زيارة؟',
      answerEnglish:
          'Cross-reference child’s age against national immunization schedule (BCG, Polio, Pentavalent, MMR, Rotavirus, Pneumococcal), log missed doses, and verify booster timeline. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'مقارنة عمر الطفل مع جدول التطعيمات الوطني (الدرن، شلل الأطفال، الخماسي، الحصبة، الروتا، المكورات الرئوية)، وتوثيق الجرعات المؤجلة وتأكيد المنشطات. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'vaccine_002',
      categoryKey: 'vaccination',
      categoryEnglish: 'Vaccination',
      categoryArabic: 'التطعيمات واللقاحات',
      icon: Icons.info_outline_rounded,
      questionEnglish: 'How to manage low-grade fever after MMR or Pentavalent vaccination?',
      questionArabic: 'كيف تتعامل مع السخونية الخفيفة بعد تطعيم الخماسي أو الثلاثي الفيروسي؟',
      answerEnglish:
          'Reassure parents that post-vaccination fever is a normal immune response. Recommend weight-appropriate Paracetamol, cool compresses, and adequate hydration. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'طمأنة الوالدين بأن حرارة ما بعد التطعيم استجابة مناعية طبيعية. إعطاء باراسيتامول حسب الوزن وكمادات دافئة وسوائل كافية. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 5. Growth & Development ---
    DoctorHelpItem(
      id: 'growth_001',
      categoryKey: 'growth',
      categoryEnglish: 'Growth & Development',
      categoryArabic: 'النمو والتطور',
      icon: Icons.straighten_rounded,
      questionEnglish: 'Which key growth parameters must be recorded for infant monitoring?',
      questionArabic: 'ما القياسات الأساسية للنمو التي يجب تسجيلها في كل زيارة؟',
      answerEnglish:
          'Weight (kg), Length/Height (cm), and Head Circumference (cm up to 2 yrs). Plot values on WHO growth charts to monitor percentile velocity over time. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الوزن (كجم)، الطول/القامة (سم)، ومحيط الرأس (سم حتى سنتين). توثيق النقاط على منحنيات منظمة الصحة العالمية لمتابعة المعدل. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'growth_002',
      categoryKey: 'growth',
      categoryEnglish: 'Growth & Development',
      categoryArabic: 'النمو والتطور',
      icon: Icons.child_care_rounded,
      questionEnglish: 'What are major developmental red flags in a 12-month-old infant?',
      questionArabic: 'ما هي مؤشرات الخطر لتأخر النمو لدى طفل عمره 12 شهراً؟',
      answerEnglish:
          'Inability to sit independently, lack of pincer grasp, no babbling, absence of response to name, or loss of previously acquired motor/language skills. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'عدم القدرة على الجلوس بمفرده، غياب الالتماك بالأصابع، عدم المناغاة، عدم الاستجابة عند مناداته باسمه، أو فقدان مهارات مكتسبة سابقاً. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 6. Common Pediatric Symptoms ---
    DoctorHelpItem(
      id: 'symptom_001',
      categoryKey: 'symptoms',
      categoryEnglish: 'Common Symptoms',
      categoryArabic: 'الأعراض الشائعة',
      icon: Icons.healing_rounded,
      questionEnglish: 'What should be assessed when evaluating acute otitis media in toddlers?',
      questionArabic: 'ما الذي يجب تقييمه عند فحص التهاب الأذن الوسطى الحاد لدى الأطفال؟',
      answerEnglish:
          'Otoscopic examination of tympanic membrane for bulging, erythema, cloudiness, or otorrhea. Check for fever, ear tugging, irritability, and recent upper respiratory infection. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'فحص غشاء الطبلة بالمكشاف للانتفاخ والتحسس والإفرازات. تقييم الحرارة، فرك الأذن، البكاء المستمر، ونزلات البرد الحديثة. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'symptom_002',
      categoryKey: 'symptoms',
      categoryEnglish: 'Common Symptoms',
      categoryArabic: 'الأعراض الشائعة',
      icon: Icons.bug_report_rounded,
      questionEnglish: 'How should pediatric acute gastroenteritis be managed in clinic?',
      questionArabic: 'كيف يتم التعامل مع النزلة المعوية الحادة في العيادة؟',
      answerEnglish:
          'Assess hydration status. Initiate Oral Rehydration Therapy (ORT) with low-osmolarity ORS, continue feeding/breastfeeding, and prescribe oral Zinc supplementation for 10-14 days. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'تقييم نسبة الجفاف. البدء بمحلول معالجة الجفاف بالفم (ORS)، استمرار التغذية والرضاعة، وإعطاء عنصر الزنك لمدة 10-14 يوماً. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 7. Medication & Dosing ---
    DoctorHelpItem(
      id: 'med_001',
      categoryKey: 'medication',
      categoryEnglish: 'Medication',
      categoryArabic: 'الأدوية والجرعات',
      icon: Icons.medication_rounded,
      questionEnglish: 'What critical checks are needed before issuing a pediatric prescription?',
      questionArabic: 'ما الفحوصات الحاسمة قبل كتابة روشتة علاجية للطفل؟',
      answerEnglish:
          'Verify patient weight (kg), verify exact age, confirm drug allergies, check maximum daily dose, specify clear oral syringe instructions, and confirm concentration (mg/mL). Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'التأكد من وزن الطفل بالجم/كجم، العمر الدقيق، الحساسية، الحد الأقصى للجرعة اليومية، وتركيز الدواء (ملجم/مل) وتوضيح طريقة الإعطاء بالسرنجة. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
    DoctorHelpItem(
      id: 'med_002',
      categoryKey: 'medication',
      categoryEnglish: 'Medication',
      categoryArabic: 'الأدوية والجرعات',
      icon: Icons.vaccines_outlined,
      questionEnglish: 'How to prescribe inhaled salbutamol for acute bronchospasm?',
      questionArabic: 'كيف يتم وصف البخاخ (السالبيوتامول) في حالات الأزمة التنفسية؟',
      answerEnglish:
          'Prescribe via Metered Dose Inhaler (MDI) with dedicated pediatric spacer mask. 2-4 puffs every 20 mins for 1st hour if acute, then 2-4 puffs every 4-6 hours as needed. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الوصف عبر البخاخ ذو الجرعة المقاسة مع ماسك القمع المخصص للأطفال. 2-4 بخات كل 20 دقيقة خلال أول ساعة حادة، ثم كل 4-6 ساعات حسب الحاجة. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 8. Emergency Red Flags ---
    DoctorHelpItem(
      id: 'emergency_001',
      categoryKey: 'emergency',
      categoryEnglish: 'Emergency Signs',
      categoryArabic: 'علامات الطوارئ',
      icon: Icons.warning_amber_rounded,
      questionEnglish: 'What are key clinical red flags for pediatric sepsis or meningitis?',
      questionArabic: 'ما هي علامات الخطر الحرجة للتسمم الدموي أو الالتهاب السحائي؟',
      answerEnglish:
          'Non-blanching purpuric rash, severe lethargy/unresponsiveness, bulging fontanelle, persistent vomiting, cold mottled extremities, and hypothermia or high fever. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'طفح نزفي لا يختفي بالضغط، خمول شديد وعدم استجابة، يافوخ منتفخ، قيء مستمر، أطراف باردة مبقعة، وانخفاض حرارة أو حمى عالية. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 9. Patient Records ---
    DoctorHelpItem(
      id: 'records_001',
      categoryKey: 'records',
      categoryEnglish: 'Patient Records',
      categoryArabic: 'سجلات المرضى',
      icon: Icons.folder_shared_rounded,
      questionEnglish: 'What details should be recorded in a child’s profile in Sharaby Center?',
      questionArabic: 'ما البيانات الواجب توثيقها في ملف الطفل بمركز شرابي؟',
      answerEnglish:
          'Full legal name, birth date, age in months, gender, father & mother names, primary guardian phone, known drug allergies, blood group, and chronic conditions. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'الاسم الثلاثي، تاريخ الميلاد، العمر بالشهور، النوع، اسم الأب والأم، هاتف ولي الأمر، الحساسية الدوائية، فصيلة الدم، والأمراض المزمنة. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),

    // --- 10. Clinic Workflow ---
    DoctorHelpItem(
      id: 'workflow_001',
      categoryKey: 'workflow',
      categoryEnglish: 'Clinic Workflow',
      categoryArabic: 'سير العمل بالعيادة',
      icon: Icons.assignment_turned_in_rounded,
      questionEnglish: 'How should follow-up appointments be scheduled after acute pediatric illness?',
      questionArabic: 'كيف يتم جدولة المتابعة بعد النزلات والتوعكات الحادة؟',
      answerEnglish:
          'Schedule acute fever/respiratory follow-up within 24-48 hours. Schedule gastroenteritis/dehydration follow-up within 24 hours. Routine growth checks every 1-2 months in first year. Use clinical judgment and follow approved pediatric protocols.',
      answerArabic:
          'جدولة متابعة الحرارة والتنفس خلال 24-48 ساعة. النزلة المعوية خلال 24 ساعة. متابعة النمو الدورية كل 1-2 شهر في السنة الأولى. استخدم التقدير الطبي واتبع بروتوكولات العيادة المعتمدة.',
    ),
  ];
}
