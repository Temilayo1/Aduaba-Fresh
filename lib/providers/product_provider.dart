import 'dart:convert';

import 'package:aduaba_app/screens/details_screen.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/widgets.dart';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/services/product_api.dart';
import 'package:http/http.dart' as http;

import 'package:aduaba_app/model/wishlist_item.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

List<Product> genProducts = [];

class ProductModel extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<Product> products = [];
  List<WishListItem> wishList = [];
  String message = '';

  ProductModel() {
    _fetchProducts();
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchProducts() async {
    _homeState = HomeState.Loading;
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiProducts = await ProductApi.instance.getAllProducts();
      products = apiProducts;

      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final apiProducts = await ProductApi.instance.getAllProducts();
      products = apiProducts;
      genProducts = apiProducts;
    } catch (e) {
      message = '$e';
    }
    notifyListeners();
    return products;
  }

  Future<List<WishListItem>> fetchWishListProducts() async {
    try {
      await fetchProducts();
      final apiProducts = await ProductApi.instance.getAllWishListProducts();
      wishList = apiProducts;
    } catch (e) {
      message = '$e';
    }
    notifyListeners();
    return wishList;
  }

  List<Product> get localProductList {
    return products;
  }

  List<Product> searchProductByName(enteredKeyword) {
    List<Product> results = [];
    results = genProducts
        .where((element) => element.name
            .toLowerCase()
            .replaceAll(" ", "")
            .contains(enteredKeyword.toLowerCase().replaceAll(" ", "")))
        .toList();
    // notifyListeners();
    return results;
  }

  Future<List<Product>> searchProducts(name) async {
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiProducts = await ProductApi.instance.getProductByName(name);
      products = apiProducts;
    } catch (e) {
      message = '$e';
    }
    return products;
  }

  searchProductByPrice(enteredKeyword) {
    List<Product> results = [];
    results = products
        .where(
            (element) => element.unitPrice.toString().contains(enteredKeyword))
        .toList();
  }

  sortByPriceASC(enteredKeyword) {
    List<Product> results = products;
    results.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
  }

  sortByPriceDESC(enteredKeyword) {
    List<Product> results = products;
    results.sort((a, b) => b.unitPrice.compareTo(a.unitPrice));
  }

  sortByNameASC(enteredKeyword) {
    List<Product> results = products;
    results.sort((a, b) => a.name.compareTo(b.name));
  }

  sortByNameDESC(enteredKeyword) {
    List<Product> results = products;
    results.sort((a, b) => b.name.compareTo(a.name));
  }

  void notify() {
    notifyListeners();
  }

  Future<void> addFavorite(String productId) async {
    // isLiked = true;
    String token = await UserPreferences().getToken();

    // final url = 'https://flutter-shop-app-b3619.firebaseio.com/userFavorite/$userId/$id.json?auth=$token';
    final Map<String, dynamic> apiBodyData = {"productId": productId};

    try {
      final response = await http
          .post(AppUrl.addWishList, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("wishlist add done");
        // return true;
      } else {
        print("wishlist add fail");
        print(response.body);
      }
      // return false;
    } catch (error) {
      print("wishlist add error");
      // return false;
    }
    notifyListeners();
  }

  Future<void> removeFavorite({String productId, product}) async {
    // if (genProducts.isNotEmpty) {
    //   genProducts.remove(product);
    // }
    // isLiked = false;
    String token = await UserPreferences().getToken();
    final client = http.Client();
    final url = Uri.parse(AppUrl.removeWishList);
    final request = http.Request("DELETE", url);
    try {
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      request.body = jsonEncode(productId);
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

  // Future<List<Product>> searchProducts(name) async {
  //   _homeState = HomeState.Loading;
  //   try {
  //     await Future.delayed(Duration(seconds: 5));
  //     final apiProducts = await ProductApi.instance.getProductByName(name);
  //     products = apiProducts;
  //     _homeState = HomeState.Loaded;
  //   } catch (e) {
  //     message = '$e';
  //     _homeState = HomeState.Error;
  //   }
  //   notifyListeners();
  //   return products;
  // }
}
