import 'package:flutter/material.dart';

class DrawerData {
  String title;
  Icon icon;
  Image image;

  DrawerData({
    this.title,
    this.icon,
    this.image,
  });
}

List<DrawerData> drawerData = [
  DrawerData(
    title: "Cart",
    image: Image.asset("assets/cart.png"),
    // icon: Icon(Icons.shopping_cart),
  ),
  DrawerData(
    title: "Categories",
    image: Image.asset("assets/category.png"),
  ),
  DrawerData(
    title: "My Wishlist",
    image: Image.asset("assets/cart.png"),
  ),
  DrawerData(
    title: "My Wishlist",
    image: Image.asset("assets/cart.png"),
  ),
];
