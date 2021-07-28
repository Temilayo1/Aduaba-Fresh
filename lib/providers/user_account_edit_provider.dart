import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  NotUpdated,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class ProfileProvider extends ChangeNotifier {
  // Status _loggedInStatus = Status.NotLoggedIn;
  // Status _registeredInStatus = Status.NotRegistered;
  Status _notUpdated = Status.NotUpdated;

  // Status get loggedInStatus => _loggedInStatus;

  // set loggedInStatus(Status value) {
  //   _loggedInStatus = value;
  // }

  // Status get registeredInStatus => _registeredInStatus;

  // set registeredInStatus(Status value) {
  //   _registeredInStatus = value;
  // }

  Status get updatedInStatus => updatedInStatus;

  set updatedInStatus(Status value) {
    updatedInStatus = value;
  }

  Future<Map<String, dynamic>> update(
    String firstName,
    String lastName,
    String phoneNumber,
    String avatarUrl,
  ) async {
    final Map<String, dynamic> apiBodyData = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "avatarUrl": avatarUrl,
    };
    // Register register = Register(
    //   email: "s1@gmail.com",
    //   phoneNumber: "08011111111",
    //   firstName: "st",
    //   lastName: "st",
    //   avataUrl: "assets/cart.png",
    //   password: "SimiPam123",
    //   confirmPassword: "SimiPam123",
    // );

    // Register({
    // this.userId,
    // this.firstName,
    // this.lastName,
    // this.email,
    // this.phoneNumber,
    // this.avataUrl,
    // this.password,
    // this.confirmPassword});

    // final Map<String, dynamic> apiBodyData = {
    //   "email": "s1@gmail.com",
    //   "password": "SimiPam123",
    //   "confirmPassword": "SimiPam123",
    //   "firstName": "st",
    //   "lastName": "pt",
    //   "phoneNumber": "08011111111",
    //   "username": "simi1",
    //   "avataUrl": "assets/cart.png"
    // };

    return await post(AppUrl.update, body: json.encode(apiBodyData),
            // body: register,
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onValue);
  }

  notify() {
    notifyListeners();
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      var userData = responseData['data'];

      // now we will create a user model
      User saveUser = User.fromJson(responseData);

      // now we will create shared preferences and save data
      UserPreferences().saveUser(saveUser);

      result = {
        'status': true,
        'message': 'Successfully saved',
        'data': saveUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Not successfully saved',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> updated(
    String firstName,
    String lastName,
    String phoneNumber,
    String avatarUrl,
  ) async {
    var result;
    final Map<String, dynamic> apiBodyData = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "avatarUrl": avatarUrl,
    };
    updatedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      AppUrl.update, body: json.encode(apiBodyData),
      // body: register,
      headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      // var userData = responseData['data'];
      // print(userData);

      User saveUser = User.fromJson(responseData);

      UserPreferences().saveUser(saveUser);

      // _loggedInStatus = Status.LoggedIn;
      // notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': saveUser};
      // result = {'status': true, 'message': 'Successful', 'user': response.body};
    } else {
      //   _loggedInStatus = Status.NotLoggedIn;
      //   notifyListeners();
      //   result = {
      //     'status': false,
      //     'message': json.decode(response.body)['error']
      //   };
      // }

      return result;
    }

    // Future<Map<String, dynamic>> login(String email, String password) async {
    //   var result;
    //
    //   // final Map<String, dynamic> loginData = {
    //   //   'email': email,
    //   //   'password': password
    //   // };
    //   final Map<String, dynamic> loginData = {
    //     "email": "s1@gmail.com",
    //     "password": "SimiPam123"
    //   };
    //
    //   _loggedInStatus = Status.Authenticating;
    //   notifyListeners();
    //
    //   Response response = await post(
    //     AppUrl.login,
    //     body: json.encode(loginData),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
    //       'X-ApiKey': 'ZGlzIzEyMw=='
    //     },
    //   );
    //
    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //
    //     print(responseData);
    //
    //     var userData = responseData['Content'];
    //
    //     User authUser = User.fromJson(userData);
    //
    //     UserPreferences().saveUser(authUser);
    //
    //     _loggedInStatus = Status.LoggedIn;
    //     notifyListeners();
    //
    //     result = {'status': true, 'message': 'Successful', 'user': authUser};
    //   } else {
    //     _loggedInStatus = Status.NotLoggedIn;
    //     notifyListeners();
    //     result = {
    //       'status': false,
    //       'message': json.decode(response.body)['error']
    //     };
    //   }
    //
    //   return result;
    // }

    onError(error) {
      print('the error is $error');
      return {
        'status': false,
        'message': 'Unsuccessful Request',
        'data': error
      };
    }
  }
}
