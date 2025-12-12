// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Sinbool';

  @override
  String get welcomeMessage => 'Selamat Datang di Sinbool';

  @override
  String get continueReading => 'Lanjutkan Membaca';

  @override
  String get chapters => 'Bab';

  @override
  String get lessons => 'Pelajaran';

  @override
  String get quiz => 'Kuis';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Pengaturan';

  @override
  String get home => 'Beranda';

  @override
  String get search => 'Cari';

  @override
  String get bookmarks => 'Penanda';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get progress => 'Kemajuan';

  @override
  String get loading => 'Memuat...';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get error => 'Terjadi kesalahan';

  @override
  String get noInternet => 'Tidak ada koneksi internet';

  @override
  String get login => 'Masuk';

  @override
  String get register => 'Daftar';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get logout => 'Keluar';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Berikutnya';

  @override
  String get back => 'Kembali';

  @override
  String get done => 'Selesai';

  @override
  String get skip => 'Lewati';

  @override
  String get start => 'Mulai';

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
