import 'dart:convert';
import 'package:aduaba_app/model/category.dart';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static CategoryApi _instance;
  UserPreferences user = UserPreferences();

  CategoryApi._();

  static CategoryApi get instance {
    if (_instance == null) {
      _instance = CategoryApi._();
    }
    return _instance;
  }

  Future<List<Category>> getAllCategories() async {
    String token = await user.getToken();
    final getCategory = await http.get(AppUrl.category, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final List responseBody = jsonDecode(getCategory.body);
    return responseBody.map((e) => Category.fromJson(e)).toList();
  }

  Future<Category> getAllProductsFromCategory(String name) async {
    String token = await user.getToken();
    print("token: $token");
    String search = name.replaceAll(" ", "%20");
    var result;
    final getCategory = await http
        .get(AppUrl.baseUrl + '/find-categoryby-name?name=$search', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getCategory.statusCode);
    final Map<String, dynamic> responseBody = jsonDecode(getCategory.body);
    print(responseBody);
    Category category = Category.fromJson(responseBody);
    return category;
  }
}
