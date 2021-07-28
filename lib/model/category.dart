import 'package:aduaba_app/model/product.dart';

class Category {
  String categoryId;
  String categoryName;
  List<Product> products;

  Category({this.categoryId, this.categoryName, this.products});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    products = json['products'].cast<Product>();
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
