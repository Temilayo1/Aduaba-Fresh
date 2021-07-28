import 'dart:convert';

import 'package:aduaba_app/model/add_new_card_moderl.dart';
import 'package:aduaba_app/model/address_model.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';

import 'package:http/http.dart' as http;

class AddressApi {
  static AddressApi _instance;
  UserPreferences user = UserPreferences();

  AddressApi._();

  static AddressApi get instance {
    if (_instance == null) {
      _instance = AddressApi._();
    }
    return _instance;
  }

  Future<List<AddressModel>> getAllAddress() async {
    final getAddress = await http.get(AppUrl.addShippingAddress, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    final List responseBody = jsonDecode(getAddress.body);
    return responseBody.map((e) => AddressModel.fromJson(e)).toList();
  }

  Future<AddressModel> getAllAddressFromModel(String name) async {
    String token = await user.getToken();
    print("token: $token");
    // String search = name.replaceAll(" ", "%20");
    var result;
    final getAddress = await http.get(
      // can't find the url
      AppUrl.baseUrl + '/find-categoryby-name?name',
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // print(getCategory.statusCode);
    final Map<String, dynamic> responseBody = jsonDecode(getAddress.body);
    print(responseBody);
    // AddressModel addressModel = AddressModel.fromJson(responseBody);
    //return addressModel;
  }
}
