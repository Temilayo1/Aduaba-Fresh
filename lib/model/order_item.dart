class OrderItem {
  String orderId;
  int totalNoOfCartItem;
  double totalAmount;
  String deliveryDate;
  String orderDate;
  String paystackRefNo;
  String address;
  String statusOfDelivery;
  Null applicationUser;
  String applicationUserId;

  OrderItem(
      {this.orderId,
      this.totalNoOfCartItem,
      this.totalAmount,
      this.deliveryDate,
      this.orderDate,
      this.paystackRefNo,
      this.address,
      this.statusOfDelivery,
      this.applicationUser,
      this.applicationUserId});

  OrderItem.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    totalNoOfCartItem = json['totalNoOfCartItem'];
    totalAmount = json['totalAmount'];
    deliveryDate = json['deliveryDate'];
    orderDate = json['orderDate'];
    paystackRefNo = json['paystackRefNo'];
    address = json['address'];
    statusOfDelivery = json['statusOfDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['totalNoOfCartItem'] = this.totalNoOfCartItem;
    data['totalAmount'] = this.totalAmount;
    data['deliveryDate'] = this.deliveryDate;
    data['orderDate'] = this.orderDate;
    data['paystackRefNo'] = this.paystackRefNo;
    data['address'] = this.address;
    data['statusOfDelivery'] = this.statusOfDelivery;
    data['applicationUser'] = this.applicationUser;
    data['applicationUserId'] = this.applicationUserId;
    return data;
  }
}
