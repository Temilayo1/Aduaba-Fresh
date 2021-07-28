import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/screens/cart_screen.dart';
import 'package:aduaba_app/screens/categories_list_screen.dart';
import 'package:aduaba_app/screens/empty_cart_screen.dart';
import 'package:aduaba_app/screens/empty_wishlist.dart';
import 'package:aduaba_app/screens/my_order.dart';
import 'package:aduaba_app/screens/user_account.dart';
import 'package:aduaba_app/screens/wishlist.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'custom_page_route.dart';

class DrawerWidget extends StatelessWidget {
  final VoidCallback openDraw;

  const DrawerWidget({
    Key key,
    this.openDraw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    bool _cartEmpty = false;
    return ListView(
      children: [
        DrawerHeader(
          // child: Row(
          //   children: [
          // SizedBox(
          //   width: 20,
          // ),
          // CircleAvatar(
          //   radius: 20,
          //   backgroundImage: AssetImage("assets/Profile.png"),
          // ),
          // SizedBox(
          //   width: 16,
          // ),
          // Text(
          //   "Andrea Charles",
          //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          // ),
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                return Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/Profile.png"),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    // Text(
                    //   "Andrea Charles",
                    //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    // ),
                    FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? "${snapshot.data.firstName} ${snapshot.data.lastName}"
                              : "Hi there!",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff3A683B),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
          //   ],
          // ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              SizedBox(
                height: 28,
              ),
              buildMenuItem(
                  onClicked: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        direction: AxisDirection.left,
                        child: _cartEmpty ? EmptyCartScreen() : CartScreen(),
                      ),
                    );
                  },
                  image: Image.asset("assets/cart.png"),
                  text: "Cart"),
              buildMenuItem(
                  image: Image.asset("assets/category.png"),
                  text: "Categories",
                  onClicked: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) =>
                    //       CategoriesListingScreen(openDrawer: openDraw),
                    // );
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        child: CategoriesListingScreen(openDrawer: openDraw),
                        direction: AxisDirection.left,
                      ),
                    );
                  }),
              buildMenuItem(
                  onClicked: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        child: MyWishList(),
                        direction: AxisDirection.left,
                      ),
                    );
                  },
                  image: Image.asset("assets/wishlist.png"),
                  text: "My Wishlist"),
              buildMenuItem(
                  onClicked: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        child: MyOrdersScreen(),
                        direction: AxisDirection.left,
                      ),
                    );
                  },
                  image: Image.asset("assets/cart.png"),
                  text: "Orders"),
              buildMenuItem(
                image: Image.asset("assets/person.png"),
                text: "Account Details",
                onClicked: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: UserAccount(),
                      direction: AxisDirection.left,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          color: Color(0xFFF9F9F9),
          // height: 48,
          margin: EdgeInsets.only(left: 35, top: 20),
          padding: EdgeInsets.only(bottom: 16, top: 14),
          alignment: Alignment.centerLeft,
          child: Text(
            "Support",
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFF979797),
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              buildMenuItem(text: "Contact Us"),
              buildMenuItem(text: "Help & FAQs"),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Image.asset("assets/drawerlogo.png"),
              SizedBox(
                height: 36,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "・",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Terms of Use",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
