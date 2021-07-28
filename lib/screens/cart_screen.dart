import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/screens/checkout_screen.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _n = 0;
  List<String> cartIds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
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
                  "Cart",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF819272),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cart.items.length > 1
                          ? "${cart.items.length} items selected"
                          : "${cart.items.length} item selected",
                      style: TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 20,
                              color: Color(0xFF999999),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Select All",
                              style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 18,
                              color: Color(0xFF999999),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Delete Selected",
                              style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, index) {
                // setState(() {
                //   cartIds.add(cart.items.values.toList()[index].cartItemId);
                // });

                double itemTotal = cart.items.values.toList()[index].unitPrice *
                    cart.items.values.toList()[index].quantity;
                return cart.items.values.toList()[index].quantity == 0
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // ListTile(
                                //   leading:
                                Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  activeColor: Color(0xFFE75A21),
                                  checkColor: Color(0xFFFFFFFF),
                                  // value: _item.isSelected ? true : false,
                                  value: true,
                                  tristate: false,
                                  onChanged: (value) {},
                                ),
                                // title:
                                Container(
                                  margin: EdgeInsets.only(bottom: 16, top: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 140,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 250,
                                              child: Text(
                                                cart.items.values
                                                    .toList()[index]
                                                    .name,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              cart.items.values
                                                      .toList()[index]
                                                      .vendorName ??
                                                  "Aduaba Fresh",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Color(0xFFBBBBBB),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  itemTotal.toString(),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1.2,
                                                    color: Color(0xFFF39E28),
                                                  ),
                                                ),
                                                Text(
                                                  "・",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFFF3A953C),
                                                  ),
                                                ),
                                                Text(
                                                  "In stock",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFFF3A953C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _n--;
                                                    });
                                                    cart.removeSingleItem(
                                                      productId: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .id,
                                                      quantity: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .quantity,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    color: Color(0xFFF3F3F3),

                                                    // padding: EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                      color: Color(0xFF979797),
                                                    )),
                                                  ),
                                                ),
                                                Container(
                                                  height: 32,
                                                  width: 32,
                                                  color: Color(0xFFF3F3F3),
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                        cart.items.values
                                                            .toList()[index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14.0)),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _n++;
                                                    });
                                                    cart.addItem(
                                                      productId: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .id,
                                                      price: cart.items.values
                                                          .toList()[index]
                                                          .unitPrice,
                                                      title: cart.items.values
                                                          .toList()[index]
                                                          .name,
                                                      imageUrl: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .imageUrl,
                                                      description: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .description,
                                                      isAvailable: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .isAvailable,
                                                      quantity: cart
                                                          .items.values
                                                          .toList()[index]
                                                          .quantity,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    color: Color(0xFFF3F3F3),
                                                    // padding: EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      size: 16,
                                                      color: Color(0xFF979797),
                                                    )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cart.removeItem(cart
                                                        .items.values
                                                        .toList()[index]
                                                        .id);
                                                    cart.removeFromDb(cart
                                                        .items.values
                                                        .toList()[index]
                                                        .id);
                                                  },
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    color: Color(0xFFF3F3F3),
                                                    // padding: EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: Color(0xFF979797),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        cart.items.values
                                            .toList()[index]
                                            .imageUrl,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
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
                          ],
                        ),
                      );
              },
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 33, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cart.items.length > 1
                            ? "Total ${cart.items.length} Items"
                            : "Total ${cart.items.length} Item",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "N${cart.totalAmount}",
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16),
                  child: buttonWidget(
                      buttonText: "Proceed to Checkout",
                      buttonColor: Color(0xFF3A953C),
                      buttonAction: () {
                        // Provider.of<Cart>(context, listen: false)
                        //     .checkout(cartIds);

                        print(cartIds);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CheckoutScreen()),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 45),
                  child: outlineButtonWidget(
                      buttonText: "Continue Shopping",
                      // buttonColor: Color(0xFF3A953C),
                      buttonAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage()),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
