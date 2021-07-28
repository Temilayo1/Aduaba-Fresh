import 'dart:async';

import 'package:aduaba_app/screens/empty_wishlist.dart';
import 'package:aduaba_app/providers/order_provider.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/screens/my_order.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CancelOrderDialogBox extends StatefulWidget {
  final String id;
  const CancelOrderDialogBox({this.id});

  @override
  _CancelOrderDialogBoxState createState() => _CancelOrderDialogBoxState();
}

class _CancelOrderDialogBoxState extends State<CancelOrderDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
          margin: EdgeInsets.only(top: 150),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            // ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Cancel Order ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cancelling this order Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean hendrerit vel neque eget ultrices. ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                    buttonText: "Yes. Cancel Order",
                    buttonColor: Color(0xFFBB2F48),
                    buttonAction: () {
                      OrderProvider().removeOrder(orderId: widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrdersScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                    buttonText: "No, Don’t Cancel Order",
                    buttonColor: Colors.grey,
                    buttonAction: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
