import 'package:aduaba_app/model/address_model.dart';
import 'package:aduaba_app/services/address_api.dart';
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  AddressModel addressList;

  String message = '';
  Future<AddressModel> _fetchAddress(String name) async {
    print(name);
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiAddress = await AddressApi.instance.getAllAddressFromModel(name);
      addressList = apiAddress;
      print(addressList);
    } catch (e) {
      message = '$e';
    }
    return addressList;
  }
}
