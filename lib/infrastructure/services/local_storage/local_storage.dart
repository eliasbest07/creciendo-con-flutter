import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences prefs;

  LocalStorage() {
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> isLoggedIn() async {
    await initializePrefs();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await initializePrefs();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<String> getEstatus() async {
    await initializePrefs();
    return prefs.getString('status') ?? 'vacio';
  }

  Future<void> setEstatus(String value) async {
    await initializePrefs();
    await prefs.setString('status', value);
  }

  Future<String> getNombre() async {
    await initializePrefs();
    return prefs.getString('nombre') ?? 'vacio';
  }

  Future<void> setNombre(String value) async {
    await initializePrefs();
    await prefs.setString('nombre', value);
  }
}
