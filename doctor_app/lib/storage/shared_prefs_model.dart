import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsModel extends ChangeNotifier {
  final SharedPreferences prefs;
  SharedPrefsModel(this.prefs);

  static const String SUBSCRIBED_USERS_IDENTIFIER_KEY = "_subscribed_users";
  Future<bool> addUser(String user) async {
    List<String> users = prefs.getStringList(SUBSCRIBED_USERS_IDENTIFIER_KEY);
    users.add(user);

    bool stored =
        await prefs.setStringList(SUBSCRIBED_USERS_IDENTIFIER_KEY, users);
    notifyListeners();
    return stored;
  }

  Future<bool> removeUser(String user) async {
    List<String> users = prefs.getStringList(SUBSCRIBED_USERS_IDENTIFIER_KEY);
    users.remove(user);

    bool stored =
        await prefs.setStringList(SUBSCRIBED_USERS_IDENTIFIER_KEY, users);
    notifyListeners();
    return stored;
  }

  List<String> get users =>
      prefs.getStringList(SUBSCRIBED_USERS_IDENTIFIER_KEY);
}
