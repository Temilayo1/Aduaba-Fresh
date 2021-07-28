import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/utilities/constants.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:aduaba_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aduaba_app/model/wishlist_item.dart';
import 'discover_tab.dart';
import 'empty_wishlist.dart';
import 'home_tab.dart';

class MyWishList extends StatefulWidget {
  const MyWishList({Key key}) : super(key: key);

  @override
  _MyWishListState createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;
  Widget _widget;
  int _n = 0;
  @override
  Widget build(BuildContext context) {
    final wishListProduct = Provider.of<ProductModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerWidget(
          openDraw: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      body: _widget ??
          Column(
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
                      "My Wishlist",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF819272),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$_n items selected",
                      style: TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: ProductModel().fetchWishListProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              _n = snapshot.data.length - 1;
                              WishListItem wishListItem = snapshot.data[index];
                              // wishListProduct.searchProducts(wishListItem.productName);
                              List<Product> products =
                                  wishListProduct.searchProductByName(
                                      wishListItem.productName);
                              Product product = products[0];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ListTile(
                                        //   leading:
                                        Container(
                                          width: 78,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                product.imageUrl,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 16, top: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 105,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                      width: 250,
                                                      child: Text(
                                                        product.name ??
                                                            "Herbsconnect Organic Acai Berry Powder Freeze Dried",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      product.vendorName ??
                                                          "Aduaba Fresh",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 1.2,
                                                        color:
                                                            Color(0xFFBBBBBB),
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
                                                          product.unitPrice
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            letterSpacing: 1.2,
                                                            color: Color(
                                                                0xFFF39E28),
                                                          ),
                                                        ),
                                                        Text(
                                                          "・",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xFFF3A953C),
                                                          ),
                                                        ),
                                                        Text(
                                                          product.isAvailable
                                                              ? "In stock"
                                                              : "Sold out",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xFFF3A953C),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {
                                            wishListProduct.removeFavorite(
                                                productId:
                                                    wishListItem.wishListItemId,
                                                product: product);
                                          },
                                          child: SizedBox(
                                            width: 20,
                                            height: 30,
                                            child:
                                                Image.asset('assets/trash.png'),
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
                          );
                        } else
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 94,
                                width: 105,
                                margin: EdgeInsets.only(bottom: 39.5),
                                child: Image.asset(
                                  "assets/cart.png",
                                  color: Color(0xFF819272).withOpacity(0.5),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Your wishlist is empty",
                                style: TextStyle(
                                    color: Color(0xFF10151A),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                width: 273,
                                child: Text(
                                  "Hit the green button down below to create an order",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF10151A),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 60,
                                    left: 24.0,
                                    right: 24.0,
                                    bottom: 16),
                                width: MediaQuery.of(context).size.width,
                                child: buttonWidget(
                                    buttonText: "Discover Products",
                                    buttonColor: Color(0xFF3A953C),
                                    buttonAction: () {
                                      Navigator.push(
                                        context,
                                        CustomPageRoute(
                                          direction: AxisDirection.up,
                                          child: MyHomePage(
                                            switchTab: 1,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    }),
              ),
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xFF3A953C),
        currentIndex: _currentTab,
        onTap: (int val) {
          setState(() {
            _currentTab = val;
            print(val);
            if (val == 2) {
              _scaffoldKey.currentState.openDrawer();
            } else if (val == 1) {
              _widget = DiscoverTab(openDraw: () {
                _scaffoldKey.currentState.openDrawer();
              });
            } else {
              _widget = HomeTab(openDraw: () {
                _scaffoldKey.currentState.openDrawer();
              });
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: "",
          ),
        ],
      ),
    );
  }
}
