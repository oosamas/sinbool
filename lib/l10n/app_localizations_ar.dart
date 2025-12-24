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

  @override
  String get unlockAllStories => 'Unlock All Islamic Stories';

  @override
  String get premiumDescription =>
      'Get full access to 50+ beautifully narrated stories about prophets, companions, and Islamic values for your children.';

  @override
  String get monthlySubscription => 'Monthly Subscription';

  @override
  String get perMonth => '/month';

  @override
  String get cancelAnytime =>
      'Cancel anytime. Subscription renews automatically.';

  @override
  String get subscribe => 'Subscribe Now';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get havePromoCode => 'Have a promo code?';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get subscriptionSuccess => 'Welcome to Sinbool Premium!';

  @override
  String get purchasesRestored => 'Your purchases have been restored';

  @override
  String get noPurchasesToRestore => 'No previous purchases found';

  @override
  String get benefitAllStories => '50+ Beautiful Stories';

  @override
  String get benefitAllStoriesDesc =>
      'Access the complete library of Islamic stories';

  @override
  String get benefitAudioNarration => 'Audio Narration';

  @override
  String get benefitAudioNarrationDesc =>
      'Professional narration for every story';

  @override
  String get benefitQuizzes => 'Interactive Quizzes';

  @override
  String get benefitQuizzesDesc => 'Test your knowledge after each story';

  @override
  String get benefitNewContent => 'New Content Monthly';

  @override
  String get benefitNewContentDesc => 'Fresh stories added every month';

  @override
  String get benefitOffline => 'Offline Access';

  @override
  String get benefitOfflineDesc => 'Download and read anywhere';

  @override
  String get premium => 'Premium';

  @override
  String get premiumContent => 'Premium Content';

  @override
  String get tapToUnlock => 'Tap to unlock with Sinbool Premium';

  @override
  String get firstLessonFree => 'First Lesson Free';

  @override
  String get promoCode => 'Promo Code';

  @override
  String get enterPromoCode => 'Enter Your Promo Code';

  @override
  String get promoCodeDescription =>
      'If you have a promo code, enter it below to unlock premium access.';

  @override
  String get promoCodeHint => 'e.g. SINBOOL2024';

  @override
  String get pleaseEnterPromoCode => 'Please enter a promo code';

  @override
  String get promoCodeTooShort => 'Promo code is too short';

  @override
  String get applyPromoCode => 'Apply Code';

  @override
  String get promoCodeInfo =>
      'Promo codes are case-insensitive and may be limited time offers. Contact support if you have any issues.';

  @override
  String get promoCodeSuccess =>
      'Promo code applied successfully! Welcome to Premium!';

  @override
  String get promoCodeInvalid => 'Invalid or expired promo code';

  @override
  String get subscription => 'Subscription';

  @override
  String get subscriptionStatus => 'Subscription Status';

  @override
  String get subscriptionActive => 'Premium Active';

  @override
  String subscriptionExpires(String date) {
    return 'Expires: $date';
  }

  @override
  String get manageSubscription => 'Manage Subscription';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get redeemPromoCode => 'Redeem Promo Code';

  @override
  String get freeUser => 'Free User';

  @override
  String get premiumFeatures => 'Premium Features';

  @override
  String get getStartedWithPremium => 'Get Started';

  @override
  String get premiumOnboardingTitle => 'Premium Experience';

  @override
  String get premiumOnboardingDesc =>
      'Unlock the full Sinbool experience with premium access to all stories, audio narration, and quizzes.';

  @override
  String get freeVsPremium => 'Free vs Premium';

  @override
  String get freeFeatures => 'Free: First lesson of each chapter';

  @override
  String get premiumFeaturesDesc =>
      'Premium: All stories, audio, quizzes & more';
}
