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
}
