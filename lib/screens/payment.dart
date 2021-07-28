import 'package:aduaba_app/providers/card_notifier.dart';
import 'package:aduaba_app/model/add_new_card_moderl.dart';
import 'package:aduaba_app/screens/new_card.dart';
import 'package:aduaba_app/services/card_api.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:aduaba_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aduaba_app/providers/card_notifier.dart';
import '../utilities/constants.dart';
import 'discover_tab.dart';
import 'home_tab.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen();
  // final List<AddNewCard> users;
  // final Function(AddNewCard) onDelete;
  // const PaymentScreen({Key key, this.users, this.onDelete}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String message = '';
  List<AddNewCard> cardList;
  Future<AddNewCard> cardAlbum;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;
  Widget _widget;

  @override
  Widget build(BuildContext context) {
    CardApi cardNotifier = Provider.of<CardApi>(context);
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
                      "Payment",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF819272),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24,
                ),
                child: Text(
                  "My Cards",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF10151A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: CardApi().getAllCards(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            List<AddNewCard> cardList = snapshot.data;
                            AddNewCard card = cardList[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/mastercardlogo.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      Text(
                                        snapshot.hasData
                                            ? ' ${card.cardNumber}'
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (snapshot.hasData) {
                                        cardNotifier.removeFromDb(card.id);
                                      }
                                    },
                                    child: SizedBox(
                                      width: 20,
                                      height: 30,
                                      child: Image.asset('assets/trash.png'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return Divider();
                          },
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: Text("add card"));
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
                child: SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                      buttonAction: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            direction: AxisDirection.up,
                            child: NewCardScreen(),
                          ),
                        );
                      },
                      buttonColor: Color(0xFF3A953C),
                      buttonText: 'Add New Card'),
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
