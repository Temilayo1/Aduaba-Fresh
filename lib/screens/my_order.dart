import 'package:aduaba_app/model/order_model.dart';
import 'package:aduaba_app/model/order_item.dart';
import 'package:aduaba_app/screens/discover_tab.dart';
import 'package:aduaba_app/screens/home_tab.dart';
import 'package:aduaba_app/screens/order_summary.dart';
import 'package:aduaba_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:aduaba_app/providers/order_provider.dart';

import 'package:intl/intl.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  List<OrderModel> orderList = [
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Estimated Delivery Due Date on 21 Dec",
      id: "Order #: 341924186",
    ),
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Cancelled",
      id: "Order #: 341924186",
    ),
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Delivered 31 Dec",
      id: "Order #: 341924186",
    ),
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Estimated Delivery Due Date on 21 Dec",
      id: "Order #: 341924186",
    ),
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Cancelled",
      id: "Order #: 341924186",
    ),
    OrderModel(
      deliveryDate: " On 22 January, 2020 1:15 pm ",
      status: "Delivered 31 Dec",
      id: "Order #: 341924186",
    ),
  ];
  Future<List<OrderItem>> orderAlbum;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;
  Widget _widget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderAlbum = OrderProvider().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    // OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerWidget(
          openDraw: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      // appBar: AppBar(),
      body: _widget ??
          FutureBuilder(
              future: orderAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 24),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "My Orders",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF819272),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "${snapshot.data.length} item(s) listed",
                              style: TextStyle(
                                  color: Color(0xFFBBBBBB),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            OrderItem orderItem = snapshot.data[index];
                            var parsedOrderDate =
                                DateTime.parse(orderItem.orderDate);
                            print(parsedOrderDate);
                            var parsedDeliveryDate =
                                DateTime.parse(orderItem.deliveryDate);
                            print(parsedDeliveryDate);
                            var deliveryDate =
                                DateFormat('d MMM').format(parsedDeliveryDate);
                            var orderDate =
                                DateFormat('d MMM').format(parsedOrderDate);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSummary(
                                        item: orderItem,
                                        deliveryDate: deliveryDate,
                                        orderDate: orderDate),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 16, top: 0, left: 24, right: 24),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/image.png",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 250,
                                              child: Text(
                                                "Order #: ${orderItem.orderId}",
                                                style: TextStyle(
                                                  color: Color(0xff131313),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              // DateFormat('ddM M yyyy kk:mm')
                                              "On ${DateFormat('d MMM, yyyy h:mm a').format(parsedOrderDate)}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                // letterSpacing: 1.2,
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 265,
                                              child: Text(
                                                "Estimated Delivery Due Date on $deliveryDate",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xfff2902f),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Divider(
                                      color: Color(0xFFF5F5F5),
                                      // color: Colors.grey,
                                      thickness: 1,
                                      height: 0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  child: Center(child: Text("No order")),
                );
              }),
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
