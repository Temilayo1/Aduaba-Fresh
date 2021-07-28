import 'dart:convert';

import 'package:aduaba_app/model/category.dart';
import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/providers/category_provider.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/screens/search_screen.dart';
import 'package:aduaba_app/services/product_api.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:aduaba_app/widgets/cart_icon_widget.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:aduaba_app/widgets/product_widget.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import 'category_screen.dart';
import 'details_screen.dart';

import 'package:http/http.dart' as http;

class DiscoverTab extends StatefulWidget {
  final VoidCallback openDraw;
  DiscoverTab({Key key, this.openDraw}) : super(key: key);

  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  List<Category> _categoryList = [];
  List<Product> productList = [];
  String message = '';
  Future<List<Product>> productAlbum;
  Future<List<Category>> categoryAlbum;
  UserPreferences user = UserPreferences();

  Widget _buildCategoryList(int index, context, Category category) {
    final color = Colors.white;
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
          margin: EdgeInsets.only(right: 16, top: 35),
          alignment: Alignment.center,
          child: Text(
            category.categoryName,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF999999),
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productAlbum = ProductModel().fetchProducts();
    categoryAlbum = CategoryModel().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productAlbum,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Product> products = snapshot.data;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      child: Icon(Icons.menu_outlined),
                                      onTap: widget.openDraw,
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 28,
                                ),
                                Text(
                                  "Discover",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF819272),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SearchScreen()));
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xFFBABABA),
                                    size: 35,
                                  ),
                                ),
                                SizedBox(
                                  width: 28,
                                ),
                                BuildCartIcon(),
                              ],
                            ),
                          ],
                        ),
                        FutureBuilder(
                            future: categoryAlbum,
                            builder: (context, snapshot) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: snapshot.hasData
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: snapshot.data
                                            .asMap()
                                            .entries
                                            .map<Widget>(
                                              (MapEntry map) =>
                                                  _buildCategoryList(map.key,
                                                      context, map.value),
                                            )
                                            .toList(),
                                      )
                                    : Container(),
                              );
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: products.length,
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(2, 3),
                      mainAxisSpacing: 28.0,
                      crossAxisSpacing: 16.0,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return OpenContainer(
                          closedElevation: 0,
                          openElevation: 0,
                          transitionDuration: Duration(milliseconds: 500),
                          transitionType: detailsPageTransitionType,
                          openBuilder: (context, _) => DetailsScreen(
                            imageUrl: product.imageUrl,
                            product: products[index],
                          ),
                          closedBuilder:
                              (context, VoidCallback openContainer) =>
                                  ProductWidget(
                            onPress: openContainer,
                            productName: product.vendorName ?? "Aduaba Fresh",
                            productSubText: product.name,
                            productPrice: product.unitPrice.toString(),
                            img: product.imageUrl,
                            productAvailability: product.isAvailable,
                            isLiked: product.itemIsinWishlist,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Text('Error retrieving results: ${snapshot.error}');
        });
  }
}
