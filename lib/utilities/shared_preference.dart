import 'package:aduaba_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userID', user.userID);
    prefs.setString('firstName', user.firstName);
    prefs.setString('lastName', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('avatarUrl', user.avatarUrl);
    prefs.setString('token', user.token);

    // ignore: deprecated_member_use
    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userID = prefs.getString("userID");
    String firstName = prefs.getString("firstName");
    String lastName = prefs.getString("lastName");
    String email = prefs.getString("email");
    String phoneNumber = prefs.getString("phoneNumber");
    String img = prefs.getString('avatarUrl');
    String token = prefs.getString("token");
    // String renewalToken = prefs.getString("renewalToken");

    return User(
        userID: userID,
        firstName: firstName,
        lastName: lastName,
        email: email,
        avatarUrl: img,
        phoneNumber: phoneNumber,
        token: token);
    // refreshTokenExpiration: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('avataUrl');
    prefs.remove('phoneNumber');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }

  Future<String> getUserFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("firstName");
    return user;
  }
}
