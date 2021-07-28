import 'dart:convert';

import 'package:aduaba_app/model/category.dart';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/providers/category_provider.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/screens/search_screen.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:aduaba_app/widgets/cart_icon_widget.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'categories_list_screen.dart';
import 'category_screen.dart';
import 'details_screen.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback openDraw;
  final String name;
  HomeTab({Key key, this.openDraw, this.name}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _cartEmpty = false;

  Future<List<Category>> categoryAlbum;
  Future<List<Product>> productAlbum;
  TextEditingController searchController = new TextEditingController();

  Widget _buildCategoryList(int index, context, Category category) {
    final color = categoryColors[index % categoryColors.length];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: CategoryScreen(
              categoryName: category.categoryName,
            ),
          ),
        );
      },
      child: Container(
        width: 92,
        height: 50,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            category.categoryName.toLowerCase(),
            style: TextStyle(
              fontSize: 13,
              color: color,
            ),
            // maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  UserPreferences user = UserPreferences();

  // Future<User> userData;

  Future<User> getUserData() {
    return UserPreferences().getUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    print("here");
    // Cart().itemsFromDb();

    categoryAlbum = CategoryModel().getAllCategories();
    getUserData();
    productAlbum = ProductModel().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (BuildContext context) {
                return GestureDetector(
                  child: Icon(Icons.menu_outlined),
                  onTap: widget.openDraw,
                );
              }),
              Text(
                "Aduaba Fresh",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              BuildCartIcon(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? "Hi ${snapshot.data.firstName}"
                          : "Hi there!",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff3A683B),
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
              SizedBox(
                height: 8,
              ),
              Text(
                "What are you looking for today?",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff819272),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        buildSearchField('Search Product', (val) {
          // searchValues.add(val);
          searchController.clear();
          Navigator.push(
            context,
            CustomPageRoute(
              child: SearchScreen(search: val),
            ),
          );
        }, searchController),
        SizedBox(
          height: 20,
        ),
        subTitle(
          title: "Categories",
          onTapped: () {
            Navigator.push(
                context,
                CustomPageRoute(
                    direction: AxisDirection.left,
                    child:
                        CategoriesListingScreen(openDrawer: widget.openDraw)));
          },
        ),
        SizedBox(
          height: 16,
        ),
        FutureBuilder(
            future: categoryAlbum,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: snapshot.hasData
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: snapshot.data
                            .asMap()
                            .entries
                            .map<Widget>(
                              (MapEntry map) => _buildCategoryList(
                                  map.key, context, map.value),
                            )
                            .toList(),
                      )
                    : Container(),
              );
            }),
        SizedBox(height: 32),
        subTitle(title: "Today's Promo"),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, i) {
              return Container(
                width: MediaQuery.of(context).size.width - 80,
                // width: 300,
                margin: EdgeInsets.only(top: 16, bottom: 32, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 40, right: 180),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Organic Brands",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3A953C),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "exclusive \nbrands",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF10151A),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Visit our shop for a complete list of our  products",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF999999),
                              ),
                            ),
                            SizedBox(
                              height: 9.5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Shop now",
                                  style: TextStyle(
                                      color: Color(0xFF8AB543),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 10,
                                  color: Color(0xFF8AB543),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 18,
                    //   bottom: 18,
                    //   right: 30,
                    // left: 178,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: AssetImage("assets/fruitbasket.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        subTitle(title: "Best Selling"),
        Container(
          height: 347,
          child: FutureBuilder(
              future: productAlbum,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products[index];
                      return OpenContainer(
                        closedElevation: 0,
                        openElevation: 0,
                        transitionDuration: Duration(milliseconds: 500),
                        transitionType: detailsPageTransitionType,
                        openBuilder: (context, _) => DetailsScreen(
                          imageUrl: "assets/fruitbasket.png",
                          product: product,
                        ),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            GestureDetector(
                          onTap: openContainer,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 16, bottom: 32, right: 16),
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            // color: Colors.red,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  bottom: 10,
                                  child: Container(
                                    height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            32,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            product.vendorName ??
                                                "Aduaba Produce",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 1.2,
                                              color: Color(0xFF819272),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            product.name ??
                                                "Herbsconnect Organic Acai Berry Powder Freeze Dried",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "N${product.unitPrice.toString()}",
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
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFF3A953C),
                                                ),
                                              ),
                                              Text(
                                                product.isAvailable
                                                    ? "In stock"
                                                    : "Sold out",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFF3A953C),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black54,
                                    //     offset: Offset(0, 2),
                                    //     blurRadius: 6,
                                    //   ),
                                    // ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          32,
                                      height:
                                          MediaQuery.of(context).size.width /
                                                  2 -
                                              32,
                                      image: NetworkImage(product.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Image.asset("assets/whiteheart.png"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return Container();
              }),
        ),
        subTitle(title: "Featured Products", color: Colors.black),
        Container(
          height: MediaQuery.of(context).size.width / 2,
          child: FutureBuilder(
              future: productAlbum,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products[index];
                      return OpenContainer(
                        closedElevation: 0,
                        openElevation: 0,
                        transitionDuration: Duration(milliseconds: 500),
                        transitionType: detailsPageTransitionType,
                        openBuilder: (context, _) => DetailsScreen(
                          imageUrl: "assets/fruitbasket.png",
                          product: product,
                        ),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            GestureDetector(
                          onTap: openContainer,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 16, bottom: 32, right: 16),
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            // color: Colors.red,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  bottom: 10,
                                  child: Container(
                                    height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            32,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            product.vendorName ??
                                                "Aduaba Produce",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 1.2,
                                              color: Color(0xFF819272),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            product.name ??
                                                "Herbsconnect Organic Acai Berry Powder Freeze Dried",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "N${product.unitPrice.toString()}",
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
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFF3A953C),
                                                ),
                                              ),
                                              Text(
                                                product.isAvailable
                                                    ? "In stock"
                                                    : "Sold out",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFF3A953C),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black54,
                                    //     offset: Offset(0, 2),
                                    //     blurRadius: 6,
                                    //   ),
                                    // ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          32,
                                      height:
                                          MediaQuery.of(context).size.width /
                                                  2 -
                                              32,
                                      image: NetworkImage(product.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Image.asset("assets/whiteheart.png"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return Container();
              }),
          // child: ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: 6,
          //   itemBuilder: (BuildContext context, int index) {
          //     return OpenContainer(
          //       closedElevation: 0,
          //       openElevation: 0,
          //       transitionDuration: Duration(milliseconds: 500),
          //       transitionType: detailsPageTransitionType,
          //       openBuilder: (context, _) => DetailsScreen(
          //         imageUrl: "assets/fruitbasket.png",
          //       ),
          //       closedBuilder: (context, VoidCallback openContainer) =>
          //           GestureDetector(
          //         onTap: openContainer,
          //         child: Container(
          //           margin: EdgeInsets.only(top: 16, bottom: 32, right: 16),
          //           width: MediaQuery.of(context).size.width / 2 - 32,
          //           // color: Colors.red,
          //           child: Stack(
          //             alignment: Alignment.topCenter,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(5),
          //                   child: Image(
          //                     width: MediaQuery.of(context).size.width / 2 - 32,
          //                     height:
          //                         MediaQuery.of(context).size.width / 2 - 32,
          //                     image: AssetImage("assets/fruitbasket.png"),
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 top: 10,
          //                 right: 10,
          //                 child: Image.asset("assets/whiteheart.png"),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
