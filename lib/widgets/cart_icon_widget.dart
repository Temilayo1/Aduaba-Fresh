import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/screens/cart_screen.dart';
import 'package:aduaba_app/screens/empty_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'badge.dart';
import 'custom_page_route.dart';

class BuildCartIcon extends StatelessWidget {
  const BuildCartIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (_, cartObject, child) {
      return Badge(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(
                direction: AxisDirection.left,
                child: cartObject.itemCount <= 0
                    ? EmptyCartScreen()
                    : CartScreen(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Color(0xFF3A953C),
            child: Image.asset("assets/homecart.png"),
          ),
        ),
        value: cartObject.itemCount.toString(),
      );
    });
  }
}
