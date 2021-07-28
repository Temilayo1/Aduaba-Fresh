import 'dart:convert';

import 'package:aduaba_app/model/category.dart';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/services/category_api.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CategoryModel extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  Category categoryList;
  List<Product> productList = [];
  String message = '';

  // CategoryModel() {
  // fetchCategories();
  // }

  HomeState get homeState => _homeState;

  UserPreferences user = UserPreferences();

  Future<List<Category>> getAllCategories() async {
    await Future.delayed(Duration(seconds: 5));
    String token = await user.getToken();
    final getCategory = await http.get(AppUrl.category, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getCategory.statusCode);
    final List responseBody = jsonDecode(getCategory.body);
    var result = responseBody.map((e) => Category.fromJson(e)).toList();
    return result;
  }

  Future<Category> fetchProductsFromCategory(String name) async {
    print(name);
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiCategory =
          await CategoryApi.instance.getAllProductsFromCategory(name);
      categoryList = apiCategory;
      print(categoryList);
    } catch (e) {
      message = '$e';
    }
    return categoryList;
  }
}
