import 'package:flutter/material.dart';

class AddressModel {
  bool isSelected;
  String address;
  String name;
  String number;

  AddressModel({this.isSelected, this.address, this.name, this.number});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    number = json['phoneNumber'];
    name = json['contactPersonsName'];
  }
}
