
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/features/models/user.dart';

class UserCache {

  static Future<void> saveUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('user_data', user.toJson());
  }

  static Future<User?> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userJson = sp.getString('user_data');
    if (userJson == null) {
      return null;
    }
    return User.fromJson(userJson);
  }
}