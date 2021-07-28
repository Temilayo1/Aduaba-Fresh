import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/services/product_api.dart';

class Search {
  List<Product> allProducts;
  List<Product> productList = [];
  String message = "";

  Future<List<Product>> _fetchProducts() async {
    try {
      final apiProducts = await ProductApi.instance.getAllProducts();
      productList = apiProducts;
    } catch (e) {
      message = '$e';
    }
    return productList;
  }

  searchProductByName(enteredKeyword) async {
    productList = await _fetchProducts();
    List<Product> results = [];
    results = productList
        .where((element) =>
            element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
  }

  searchProductByPrice(enteredKeyword) async {
    productList = await _fetchProducts();
    List<Product> results = [];
    results = productList
        .where((element) => element.unitPrice
            .toString()
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();
  }
}
