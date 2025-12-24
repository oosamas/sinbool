import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('ur'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sinbool'**
  String get appName;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sinbool'**
  String get welcomeMessage;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReading;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retry;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @lessonComplete.
  ///
  /// In en, this message translates to:
  /// **'Lesson Complete!'**
  String get lessonComplete;

  /// No description provided for @quizScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score: {score}%'**
  String quizScore(int score);

  /// No description provided for @minutesRead.
  ///
  /// In en, this message translates to:
  /// **'{count} min read'**
  String minutesRead(int count);

  /// No description provided for @lessonsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} lessons completed'**
  String lessonsCompleted(int count);

  /// No description provided for @unlockAllStories.
  ///
  /// In en, this message translates to:
  /// **'Unlock All Islamic Stories'**
  String get unlockAllStories;

  /// No description provided for @premiumDescription.
  ///
  /// In en, this message translates to:
  /// **'Get full access to 50+ beautifully narrated stories about prophets, companions, and Islamic values for your children.'**
  String get premiumDescription;

  /// No description provided for @monthlySubscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get monthlySubscription;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// No description provided for @cancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. Subscription renews automatically.'**
  String get cancelAnytime;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get subscribe;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @havePromoCode.
  ///
  /// In en, this message translates to:
  /// **'Have a promo code?'**
  String get havePromoCode;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @subscriptionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sinbool Premium!'**
  String get subscriptionSuccess;

  /// No description provided for @purchasesRestored.
  ///
  /// In en, this message translates to:
  /// **'Your purchases have been restored'**
  String get purchasesRestored;

  /// No description provided for @noPurchasesToRestore.
  ///
  /// In en, this message translates to:
  /// **'No previous purchases found'**
  String get noPurchasesToRestore;

  /// No description provided for @benefitAllStories.
  ///
  /// In en, this message translates to:
  /// **'50+ Beautiful Stories'**
  String get benefitAllStories;

  /// No description provided for @benefitAllStoriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Access the complete library of Islamic stories'**
  String get benefitAllStoriesDesc;

  /// No description provided for @benefitAudioNarration.
  ///
  /// In en, this message translates to:
  /// **'Audio Narration'**
  String get benefitAudioNarration;

  /// No description provided for @benefitAudioNarrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Professional narration for every story'**
  String get benefitAudioNarrationDesc;

  /// No description provided for @benefitQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Interactive Quizzes'**
  String get benefitQuizzes;

  /// No description provided for @benefitQuizzesDesc.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge after each story'**
  String get benefitQuizzesDesc;

  /// No description provided for @benefitNewContent.
  ///
  /// In en, this message translates to:
  /// **'New Content Monthly'**
  String get benefitNewContent;

  /// No description provided for @benefitNewContentDesc.
  ///
  /// In en, this message translates to:
  /// **'Fresh stories added every month'**
  String get benefitNewContentDesc;

  /// No description provided for @benefitOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline Access'**
  String get benefitOffline;

  /// No description provided for @benefitOfflineDesc.
  ///
  /// In en, this message translates to:
  /// **'Download and read anywhere'**
  String get benefitOfflineDesc;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumContent.
  ///
  /// In en, this message translates to:
  /// **'Premium Content'**
  String get premiumContent;

  /// No description provided for @tapToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Tap to unlock with Sinbool Premium'**
  String get tapToUnlock;

  /// No description provided for @firstLessonFree.
  ///
  /// In en, this message translates to:
  /// **'First Lesson Free'**
  String get firstLessonFree;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @enterPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Promo Code'**
  String get enterPromoCode;

  /// No description provided for @promoCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'If you have a promo code, enter it below to unlock premium access.'**
  String get promoCodeDescription;

  /// No description provided for @promoCodeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. SINBOOL2024'**
  String get promoCodeHint;

  /// No description provided for @pleaseEnterPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a promo code'**
  String get pleaseEnterPromoCode;

  /// No description provided for @promoCodeTooShort.
  ///
  /// In en, this message translates to:
  /// **'Promo code is too short'**
  String get promoCodeTooShort;

  /// No description provided for @applyPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Apply Code'**
  String get applyPromoCode;

  /// No description provided for @promoCodeInfo.
  ///
  /// In en, this message translates to:
  /// **'Promo codes are case-insensitive and may be limited time offers. Contact support if you have any issues.'**
  String get promoCodeInfo;

  /// No description provided for @promoCodeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Promo code applied successfully! Welcome to Premium!'**
  String get promoCodeSuccess;

  /// No description provided for @promoCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired promo code'**
  String get promoCodeInvalid;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @subscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Subscription Status'**
  String get subscriptionStatus;

  /// No description provided for @subscriptionActive.
  ///
  /// In en, this message translates to:
  /// **'Premium Active'**
  String get subscriptionActive;

  /// No description provided for @subscriptionExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires: {date}'**
  String subscriptionExpires(String date);

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get manageSubscription;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @redeemPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Redeem Promo Code'**
  String get redeemPromoCode;

  /// No description provided for @freeUser.
  ///
  /// In en, this message translates to:
  /// **'Free User'**
  String get freeUser;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @getStartedWithPremium.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedWithPremium;

  /// No description provided for @premiumOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Experience'**
  String get premiumOnboardingTitle;

  /// No description provided for @premiumOnboardingDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full Sinbool experience with premium access to all stories, audio narration, and quizzes.'**
  String get premiumOnboardingDesc;

  /// No description provided for @freeVsPremium.
  ///
  /// In en, this message translates to:
  /// **'Free vs Premium'**
  String get freeVsPremium;

  /// No description provided for @freeFeatures.
  ///
  /// In en, this message translates to:
  /// **'Free: First lesson of each chapter'**
  String get freeFeatures;

  /// No description provided for @premiumFeaturesDesc.
  ///
  /// In en, this message translates to:
  /// **'Premium: All stories, audio, quizzes & more'**
  String get premiumFeaturesDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'fr',
    'id',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
