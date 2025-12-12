// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'سنبول';

  @override
  String get welcomeMessage => 'سنبول میں خوش آمدید';

  @override
  String get continueReading => 'پڑھنا جاری رکھیں';

  @override
  String get chapters => 'ابواب';

  @override
  String get lessons => 'اسباق';

  @override
  String get quiz => 'کوئز';

  @override
  String get profile => 'پروفائل';

  @override
  String get settings => 'ترتیبات';

  @override
  String get home => 'ہوم';

  @override
  String get search => 'تلاش';

  @override
  String get bookmarks => 'بک مارکس';

  @override
  String get achievements => 'کامیابیاں';

  @override
  String get progress => 'پیش رفت';

  @override
  String get loading => 'لوڈ ہو رہا ہے...';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get error => 'کچھ غلط ہو گیا';

  @override
  String get noInternet => 'انٹرنیٹ کنکشن نہیں ہے';

  @override
  String get login => 'لاگ ان';

  @override
  String get register => 'رجسٹر کریں';

  @override
  String get email => 'ای میل';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get logout => 'لاگ آؤٹ';

  @override
  String get cancel => 'منسوخ';

  @override
  String get confirm => 'تصدیق';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'اگلا';

  @override
  String get back => 'واپس';

  @override
  String get done => 'ہو گیا';

  @override
  String get skip => 'چھوڑیں';

  @override
  String get start => 'شروع کریں';

  @override
  String get finish => 'Finish';

  @override
  String get lessonComplete => 'Lesson Complete!';

  @override
  String quizScore(int score) {
    return 'Your Score: $score%';
  }

  @override
  String minutesRead(int count) {
    return '$count min read';
  }

  @override
  String lessonsCompleted(int count) {
    return '$count lessons completed';
  }
}
