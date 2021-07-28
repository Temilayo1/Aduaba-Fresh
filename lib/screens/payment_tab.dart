import 'package:aduaba_app/providers/address_notifier.dart';
import 'package:aduaba_app/model/address_model.dart';
import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/widgets/address_radio_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aduaba_app/providers/order_provider.dart';
import '../utilities/constants.dart';
import 'card_selection_screen.dart';
import 'confirmation_screen.dart';

class PaymentTab extends StatefulWidget {
  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final address = Provider.of<AddressNotifier>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            // color: Colors.grey,
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
                            // color: Colors.grey,
                            thickness: 4,
                            height: 0,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('assets/outlined.png')),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                "Payment",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFF10151A)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16, top: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cash on Delivery ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF10151A),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 310,
                                      child: Text(
                                        "For Contactless Delivery we recommend go cashless and stay with Aduabe Fresh Pay",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.2,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Container(
                                    // width: 145,
                                    height: 35,
                                    child:
                                        // TextButton.icon(
                                        //   label:
                                        //   icon: Icon(Icons.add),
                                        // ),
                                        TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(50, 30),
                                          alignment: Alignment.centerLeft),
                                      child: Text(
                                        "MORE DETAILS",
                                        style: TextStyle(
                                          fontSize: 13,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xFF10151A),
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF10151A),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Color(0xFF3E3E3E),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Radio(
                          value: 0,
                          groupValue: _index,
                          activeColor: Color(0xFFE75A21),
                          onChanged: (value) {
                            setState(() {
                              _index = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFFF5F5F5),
                      // color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Card Payment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF10151A),
                          ),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _index,
                          activeColor: Color(0xFFE75A21),
                          onChanged: (value) {
                            setState(
                              () {
                                _index = value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 77,
                    ),
                    Divider(
                      color: Color(0xFFF5F5F5),
                      // color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 33),
        child: buttonWidget(
          buttonText: "Pay Now",
          buttonColor: Color(0xFF3A953C),
          buttonAction: () {
            if (_index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CardSelection()),
              );
            } else {
              OrderProvider().addOrder(
                  itemTotal: cart.itemCount,
                  totalAmount: cart.summaryAmount,
                  address: address.add,
                  status: "paymentondelivery");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ConfirmationTab()),
              );
            }
          },
        ),
      ),
    );
  }
}
