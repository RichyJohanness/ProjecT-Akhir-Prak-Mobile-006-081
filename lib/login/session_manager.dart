import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyUsername = 'username';
  static const String _keyLastVisitedPage = 'last_visited_page'; // Menambahkan kunci untuk menyimpan halaman terakhir yang dikunjungi pengguna

  static Future<void> initSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Tambahkan logika inisialisasi yang diperlukan di sini, jika ada
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) != null;
  }

  static Future<void> setLoggedIn(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUsername, username);
  }

  static Future<void> setLastVisitedPage(String pageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyLastVisitedPage, pageName);
  }

  static Future<String?> getLastVisitedPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastVisitedPage);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUsername);
  }
}
