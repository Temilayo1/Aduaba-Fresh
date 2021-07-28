import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/screens/home_tab.dart';
import 'package:aduaba_app/screens/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import 'checkout_screen.dart';
import 'home_screen.dart';

class ConfirmationTab extends StatefulWidget {
  @override
  _ConfirmationTabState createState() => _ConfirmationTabState();
}

class _ConfirmationTabState extends State<ConfirmationTab> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Cart>(context).clearCart();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF424347),
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Checkout",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF819272),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset('assets/filled.png')),
                      Positioned(
                        top: 9,
                        left: 15,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5 - 38,
                          child: Divider(
                            color: Color(0xFF3A953C),
                            thickness: 4,
                            height: 0,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset('assets/filled.png')),
                      Positioned(
                        top: 9,
                        right: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5 - 40,
                          child: Divider(
                            color: Color(0xFF3A953C),
                            thickness: 4,
                            height: 0,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('assets/filled.png')),
                    ],
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Billing",
                          style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Payment",
                          style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Confirmation",
                          style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 94,
                    width: 105,
                    margin: EdgeInsets.only(bottom: 39.5),
                    child: Image.asset(
                      "assets/confirmedcart.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "Order Confirmed",
                    style: TextStyle(
                        color: Color(0xFF424347),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 20),
                    width: 273,
                    child: Text(
                      "Thank you for choosing Aduaba Fresh. Your order #2345 has been confirmed ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF10151A),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buttonWidget(
                      buttonText: "Track Order",
                      buttonColor: Color(0xFF3A953C),
                      buttonAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => OrderSummary(),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  outlineButtonWidget(
                      buttonText: "Continue Shopping",
                      // buttonColor: Color(0xFF3A953C),
                      buttonAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage(),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
