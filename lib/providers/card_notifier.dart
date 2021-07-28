import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:aduaba_app/model/add_new_card_moderl.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CardNotifier extends ChangeNotifier {
  List<AddNewCard> _cardList = [];

  UserPreferences user = UserPreferences();

  UnmodifiableListView<AddNewCard> get cardList =>
      UnmodifiableListView(_cardList);

  addCard(AddNewCard addNewCard) {
    _cardList.add(addNewCard);
    notifyListeners();
  }

  deleteCard(addNewCard) {
    // _cardList
    //     .removeWhere((addNewCard) => _cardList == cardList[index].cardNumber);

    _cardList.remove(addNewCard);
    notifyListeners();
  }
}
