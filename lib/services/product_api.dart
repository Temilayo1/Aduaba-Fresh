import 'dart:convert';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:aduaba_app/model/wishlist_item.dart';

class ProductApi {
  static ProductApi _instance;
  UserPreferences user = UserPreferences();
  ProductApi._();

  static ProductApi get instance {
    if (_instance == null) {
      _instance = ProductApi._();
    }
    return _instance;
  }

  Future<List<Product>> getAllProducts() async {
    String token = await user.getToken();
    final getProduct = await http.get(AppUrl.product, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getProduct.statusCode);
    final List responseBody = jsonDecode(getProduct.body);
    return responseBody.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<WishListItem>> getAllWishListProducts() async {
    String token = await user.getToken();
    final getProduct = await http.get(AppUrl.wishList, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getProduct.statusCode);
    final List responseBody = jsonDecode(getProduct.body);
    return responseBody.map((e) => WishListItem.fromJson(e)).toList();
  }

  Future<List<Product>> getProductByName(String name) async {
    var result;
    String token = await user.getToken();
    String search = name.replaceAll(" ", "%20");
    final getProduct = await http
        .get(AppUrl.baseUrl + '/search-products?name=$search', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getProduct.statusCode);
    print(getProduct.body);
    if (getProduct.statusCode == 200) {
      print("storing");
      final List responseBody = jsonDecode(getProduct.body);
      result = responseBody.map((e) => Product.fromJson(e)).toList();
      print(result);
    } else if (getProduct.statusCode == 404) {
      result = {
        'status': false,
        'message': json.decode(getProduct.body)['error']
      };
    }

    return result;
  }
}
