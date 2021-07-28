class WishListItem {
  String wishListItemId;
  String productName;
  String productId;

  WishListItem({this.wishListItemId, this.productName, this.productId});

  WishListItem.fromJson(Map<String, dynamic> json) {
    wishListItemId = json['wishListItemId'];
    productName = json['productName'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishListItemId'] = this.wishListItemId;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    return data;
  }
}
