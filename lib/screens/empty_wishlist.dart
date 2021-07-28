import 'package:aduaba_app/utilities/constants.dart';
import 'package:aduaba_app/screens/discover_tab.dart';
import 'package:aduaba_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import 'home_tab.dart';

class EmptyWishlist extends StatefulWidget {
  const EmptyWishlist({Key key}) : super(key: key);

  @override
  _EmptyWishlistState createState() => _EmptyWishlistState();
}

class _EmptyWishlistState extends State<EmptyWishlist> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;
  Widget _widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerWidget(
          openDraw: () {},
        ),
      ),
      body: _widget ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      "My Orders",
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
                          "0 items selected",
                          style: TextStyle(
                              color: Color(0xFFBBBBBB),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
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
                  ],
                ),
              ),
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xFF3A953C),
        currentIndex: _currentTab,
        onTap: (int val) {
          setState(
            () {
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
            },
          );
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
