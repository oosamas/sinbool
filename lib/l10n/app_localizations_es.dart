// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Sinbool';

  @override
  String get welcomeMessage => 'Bienvenido a Sinbool';

  @override
  String get continueReading => 'Continuar Leyendo';

  @override
  String get chapters => 'Capítulos';

  @override
  String get lessons => 'Lecciones';

  @override
  String get quiz => 'Cuestionario';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get home => 'Inicio';

  @override
  String get search => 'Buscar';

  @override
  String get bookmarks => 'Marcadores';

  @override
  String get achievements => 'Logros';

  @override
  String get progress => 'Progreso';

  @override
  String get loading => 'Cargando...';

  @override
  String get retry => 'Reintentar';

  @override
  String get error => 'Algo salió mal';

  @override
  String get noInternet => 'Sin conexión a internet';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Siguiente';

  @override
  String get back => 'Atrás';

  @override
  String get done => 'Listo';

  @override
  String get skip => 'Omitir';

  @override
  String get start => 'Comenzar';

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
