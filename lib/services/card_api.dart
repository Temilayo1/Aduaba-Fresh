import 'dart:async';
import 'dart:convert';

import 'package:aduaba_app/model/add_new_card_moderl.dart';
import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CardApi with ChangeNotifier {
  static CardApi _instance;
  UserPreferences user = UserPreferences();

  // CardApi._();

  // static CardApi get instance {
  //   if (_instance == null) {
  //     _instance = CardApi._();
  //   }
  //   return _instance;
  // }

  Future<void> removeFromDb(productId) async {
    String token = await UserPreferences().getToken();
    // final Map<String, dynamic> apiBodyData = {"productId": productId};

    final client = http.Client();
    final url = Uri.parse(AppUrl.deleteCard);

    try {
      final request = http.Request("DELETE", url);
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      request.body = jsonEncode([productId]);
      final response = await request.send();
      if (response.statusCode == 200) {
        print("remove successful");
      } else {
        print("remove failed");
        print(response.stream.bytesToString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
    notifyListeners();
  }

  Future<List<AddNewCard>> getAllCards() async {
    String token = await user.getToken();
    final getCard = await http.get(AppUrl.viewCards, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final List responseBody = jsonDecode(getCard.body);
    notifyListeners();
    return responseBody.map((e) => AddNewCard.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> registerCard(
      {String cardNo, String cardName, String exp, String cvv}) async {
    String token = await user.getToken();
    print("add card na");
    final Map<String, dynamic> apiBodyData = {
      "cardHolderName": cardName,
      "cardNumber": cardNo,
      "expiryDate": exp,
      "ccv": cvv
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
    var result;

    final response =
        await post(AppUrl.addCard, body: json.encode(apiBodyData), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("card added");
      result = {'status': true, 'message': 'Successfully'};
    } else {
      result = {
        'status': false,
        'message': 'failed',
      };
      print("card not added");
    }
    notifyListeners();
    return result;
  }

  notify() {
    notifyListeners();
  }

  // static Future<FutureOr> onValue(Response response) async {
  //   var result;
  //
  //   final Map<String, dynamic> responseData = json.decode(response.body);
  //
  //   print(responseData);
  //
  //   if (response.statusCode == 200) {
  //     print("card added");
  //     result = {'status': true, 'message': 'Successfully'};
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': 'failed',
  //     };
  //     print("card not added");
  //   }
  //
  //   return result;
  // }
  //
  // static onError(error) {
  //   print('the error is $error');
  //   return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  // }
}
