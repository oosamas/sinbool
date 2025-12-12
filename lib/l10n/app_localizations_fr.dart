// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Sinbool';

  @override
  String get welcomeMessage => 'Bienvenue sur Sinbool';

  @override
  String get continueReading => 'Continuer la Lecture';

  @override
  String get chapters => 'Chapitres';

  @override
  String get lessons => 'Leçons';

  @override
  String get quiz => 'Quiz';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Rechercher';

  @override
  String get bookmarks => 'Favoris';

  @override
  String get achievements => 'Réalisations';

  @override
  String get progress => 'Progression';

  @override
  String get loading => 'Chargement...';

  @override
  String get retry => 'Réessayer';

  @override
  String get error => 'Une erreur est survenue';

  @override
  String get noInternet => 'Pas de connexion internet';

  @override
  String get login => 'Connexion';

  @override
  String get register => 'S\'inscrire';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get logout => 'Déconnexion';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Suivant';

  @override
  String get back => 'Retour';

  @override
  String get done => 'Terminé';

  @override
  String get skip => 'Passer';

  @override
  String get start => 'Commencer';

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
