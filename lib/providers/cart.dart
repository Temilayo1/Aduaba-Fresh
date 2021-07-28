import 'dart:convert';

import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Item {
  String id;
  String cartItemId;
  String name;
  String description;
  double unitPrice;
  String imageUrl;
  String categoryName;
  String vendorName;
  bool isAvailable;
  int quantity;

  Item({
    this.id,
    this.name,
    this.description,
    this.unitPrice,
    this.imageUrl,
    this.categoryName,
    this.vendorName,
    this.isAvailable,
    this.quantity,
    this.cartItemId,
  });

  Item.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cartItemId'];
    id = json['productId'];
    name = json['productName'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    imageUrl = json['productImage'];
    isAvailable = json['isAvailable'];
    vendorName = json['vendorName'];
  }
}

class Cart with ChangeNotifier {
  Map<String, Item> _items = {};

  Map<String, Item> get items {
    return {..._items};
  }

  void itemsFromDb(listItem) {
    // List<Item> listItem = await getAllCartItems();
    listItem.forEach((element) {
      addItemDb(
          productId: element.id,
          price: element.unitPrice,
          title: element.name,
          description: element.description,
          imageUrl: element.imageUrl,
          isAvailable: element.isAvailable,
          quantity: element.quantity);
    });

    print("item count $itemCount");
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
        (key, cartItem) => total += cartItem.unitPrice * cartItem.quantity);
    return total;
  }

  double get summaryAmount {
    var total = totalAmount;

    return total + 350;
  }

  Future<void> addCartToDB(productId, quantity) async {
    await Future.delayed(Duration(seconds: 5));
    final Map<String, dynamic> apiBodyData = {
      "productId": productId,
      "quantity": quantity
    };
    print("added to cart 2");
    String token = await UserPreferences().getToken();
    try {
      final response = await http
          .post(AppUrl.addCart, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("add to cart done");
      } else {
        print("add to cart fail");
        print(response.body);
      }
    } catch (error) {
      print("add to cart error");
      print(error.toString());
    }
    notifyListeners();
  }

  Future<void> updatedbCart(cartItemId, quantity) async {
    final Map<String, dynamic> apiBodyData = {
      "productId": cartItemId,
      "quantity": quantity
    };
    String token = await UserPreferences().getToken();
    try {
      final response = await http
          .post(AppUrl.addCart, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("done");
      } else {
        print(response.body);
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future<int> getAllCartItems() async {
    await Future.delayed(Duration(seconds: 5));

    String token = await UserPreferences().getToken();

    final getCartItems = await http.get(AppUrl.cart, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(getCartItems.statusCode);
    final List responseBody = jsonDecode(getCartItems.body);
    // print(responseBody);

    var result = responseBody.map((e) => Item.fromJson(e)).toList();
    // print("Cart result: ${result[1].name}");
    itemsFromDb(result);
    notifyListeners();
    return itemCount;
  }

  void addItem(
      {String productId,
      double price,
      String title,
      String imageUrl,
      String description,
      bool isAvailable,
      int quantity,
      cartItemId}) async {
    int q = 0;
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) {
        q = existingCartItem.quantity + 1;
        return Item(
          id: existingCartItem.id,
          description: existingCartItem.description,
          isAvailable: existingCartItem.isAvailable,
          imageUrl: existingCartItem.imageUrl,
          name: existingCartItem.name,
          unitPrice: existingCartItem.unitPrice,
          quantity: existingCartItem.quantity + 1,
        );
      });
      await updatedbCart(productId, q);
    } else {
      _items.putIfAbsent(
          productId,
          () => Item(
                // id: DateTime.now().toString(),
                id: productId,
                name: title,
                unitPrice: price,
                description: description,
                isAvailable: isAvailable,
                imageUrl: imageUrl,
                quantity: 1,
              ));
      print("additemDb $itemCount");
      await addCartToDB(productId, quantity);
    }
    notifyListeners();
  }

  void addItemDb(
      {String productId,
      double price,
      String title,
      String imageUrl,
      String description,
      bool isAvailable,
      int quantity,
      cartItemId}) async {
    _items.putIfAbsent(
        productId,
        () => Item(
              // id: DateTime.now().toString(),
              id: productId,
              name: title,
              unitPrice: price,
              description: description,
              isAvailable: isAvailable,
              imageUrl: imageUrl,
              quantity: quantity,
            ));
    print("additemDb $itemCount");
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem({String productId, int quantity}) async {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => Item(
                id: existingCartItem.id,
                name: existingCartItem.name,
                description: existingCartItem.description,
                isAvailable: existingCartItem.isAvailable,
                imageUrl: existingCartItem.imageUrl,
                unitPrice: existingCartItem.unitPrice,
                quantity: existingCartItem.quantity - 1,
              ));
      await updatedbCart(productId, quantity);
    } else {
      _items.remove(productId);
      await removeFromDb(productId);
    }
    notifyListeners();
  }

  Future<void> removeFromDb(productId) async {
    String token = await UserPreferences().getToken();
    // final Map<String, dynamic> apiBodyData = {"productId": productId};

    final client = http.Client();
    final url = Uri.parse(AppUrl.removeCart);

    try {
      final request = http.Request("DELETE", url);
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      request.body = jsonEncode({"productId": productId});
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

  Future<void> checkout(cartId) async {
    await Future.delayed(Duration(seconds: 5));
    // final Map<String, dynamic> apiBodyData = {
    //   "productId": productId,
    //   "quantity": quantity
    // };
    print("checkout");
    String token = await UserPreferences().getToken();
    try {
      final response =
          await http.post(AppUrl.checkout, body: json.encode(cartId), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("checkout done");
      } else {
        print("checkout fail");
        print(response.body);
      }
    } catch (error) {
      print("checkout error");
      print(error.toString());
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
  }
}
