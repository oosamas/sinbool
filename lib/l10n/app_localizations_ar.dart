// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سنبول';

  @override
  String get welcomeMessage => 'مرحباً بكم في سنبول';

  @override
  String get continueReading => 'متابعة القراءة';

  @override
  String get chapters => 'الفصول';

  @override
  String get lessons => 'الدروس';

  @override
  String get quiz => 'اختبار';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get bookmarks => 'المحفوظات';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get progress => 'التقدم';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get error => 'حدث خطأ ما';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get done => 'تم';

  @override
  String get skip => 'تخطي';

  @override
  String get start => 'ابدأ';

  @override
  String get finish => 'إنهاء';

  @override
  String get lessonComplete => 'تم إكمال الدرس!';

  @override
  String quizScore(int score) {
    return 'نتيجتك: $score٪';
  }

  @override
  String minutesRead(int count) {
    return '$count دقيقة للقراءة';
  }

  @override
  String lessonsCompleted(int count) {
    return '$count دروس مكتملة';
  }
}
