import 'package:aduaba_app/model/product.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/services/product_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  final String search;

  const SearchScreen({this.search});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool noResult = false;
  List<Product> productList;
  String message = '';
  String history;
  // Future<List<Product>> productAlbum;
  List<Product> productAlbum;

  TextEditingController searchController = new TextEditingController();
  int count = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.search != null) {
      // productAlbum = ProductModel().searchProducts(widget.search);
      productAlbum = ProductModel().searchProductByName(widget.search);
      history = widget.search;
    }
  }

  // Product productFound;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FutureBuilder(
      //     future: productAlbum,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //
      //       if (snapshot.hasData) {
      //         // setState(() {
      //         //   noResult = false;
      //         // });
      //         List<Product> productFound = snapshot.data;
      //         print("found!!!!!!!!!!!!!!!!!");
      //         print(productFound);
      //         return Container(
      //           padding: EdgeInsets.symmetric(horizontal: 24.0),
      //           child: Column(
      //             children: [
      //               Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 30, horizontal: 0),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Icon(
      //                         Icons.arrow_back,
      //                         color: Color(0xFF424347),
      //                         size: 35,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 22,
      //                     ),
      //                     Text(
      //                       "Search",
      //                       style: TextStyle(
      //                           fontSize: 24,
      //                           color: Color(0xFF819272),
      //                           fontWeight: FontWeight.w700),
      //                     ),
      //                     SizedBox(
      //                       height: 16,
      //                     ),
      //                     buildSearchField('Search Product', (value) {
      //                       setState(() {
      //                         productAlbum =
      //                             ProductModel().searchProducts(value);
      //                         history = value;
      //                       });
      //                     }),
      //                   ],
      //                 ),
      //               ),
      //               Column(
      //                 children: [
      //                   Align(
      //                     alignment: Alignment.centerLeft,
      //                     child: Text(
      //                       noResult ? "No Search Result" : "Latest Search",
      //                       style: TextStyle(
      //                         fontSize: 17,
      //                         color: Color(0xFF10151A),
      //                         fontWeight: FontWeight.w700,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   noResult
      //                       ? Align(
      //                           alignment: Alignment.topLeft,
      //                           child: Container(
      //                             width: 280,
      //                             child: Text(
      //                               "We currently dont have what you’re looking for.  Why not try out similar products",
      //                               style: TextStyle(
      //                                 fontSize: 13,
      //                                 color: Color(0xFF10151A),
      //                                 fontWeight: FontWeight.w400,
      //                               ),
      //                             ),
      //                           ),
      //                         )
      //                       : Container(
      //                           height: MediaQuery.of(context).size.width / 3,
      //                           // flex: 1,
      //                           child: history == null
      //                               ? Container()
      //                               : ListView.builder(
      //                                   itemCount: count,
      //                                   shrinkWrap: true,
      //                                   itemBuilder: (context, index) {
      //                                     bool delete = false;
      //                                     return Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         ListTile(
      //                                           leading: Icon(
      //                                               Icons.access_time_outlined),
      //                                           title: Text(history),
      //                                           trailing: GestureDetector(
      //                                               onTap: () {
      //                                                 setState(() {
      //                                                   count = 0;
      //                                                 });
      //                                               },
      //                                               child: Icon(Icons.close)),
      //                                           contentPadding:
      //                                               EdgeInsets.only(left: 0),
      //                                         ),
      //                                         Divider(
      //                                           color: Color(0xFFF5F5F5),
      //                                           // color: Colors.grey,
      //                                           thickness: 1,
      //                                           height: 0,
      //                                         )
      //                                       ],
      //                                     );
      //                                   }),
      //                         ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: 32,
      //               ),
      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text(
      //                   noResult ? "Related Searches" : "Popular Searches",
      //                   style: TextStyle(
      //                     fontSize: 17,
      //                     color: Color(0xFF10151A),
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //                 ),
      //               ),
      //               snapshot.hasData
      //                   ? Expanded(
      //                       // flex: 5,
      //                       child: productFound == null
      //                           ? Center(
      //                               child: CircularProgressIndicator(),
      //                             )
      //                           : ListView.builder(
      //                               itemCount: productFound.length,
      //                               itemBuilder: (_, index) {
      //                                 Product product = productFound[index];
      //                                 return GestureDetector(
      //                                   onTap: () {
      //                                     Navigator.push(
      //                                       context,
      //                                       MaterialPageRoute(
      //                                         builder: (BuildContext context) =>
      //                                             DetailsScreen(
      //                                           // imageUrl: "assets/fruitbasket.png",
      //
      //                                           imageUrl: product.imageUrl,
      //                                         ),
      //                                       ),
      //                                     );
      //                                   },
      //                                   child: Container(
      //                                     margin: EdgeInsets.only(
      //                                         bottom: 16, top: 0),
      //                                     child: Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Row(
      //                                           children: [
      //                                             Container(
      //                                               width: 90,
      //                                               height: 120,
      //                                               decoration: BoxDecoration(
      //                                                 image: DecorationImage(
      //                                                   image: NetworkImage(
      //                                                     // "assets/fruitbasket.png",
      //                                                     product.imageUrl,
      //                                                   ),
      //                                                   fit: BoxFit.fill,
      //                                                 ),
      //                                               ),
      //                                             ),
      //                                             SizedBox(
      //                                               width: 10,
      //                                             ),
      //                                             Container(
      //                                               height: 120,
      //                                               child: Column(
      //                                                 crossAxisAlignment:
      //                                                     CrossAxisAlignment
      //                                                         .start,
      //                                                 mainAxisAlignment:
      //                                                     MainAxisAlignment
      //                                                         .spaceAround,
      //                                                 children: [
      //                                                   Container(
      //                                                     width: 250,
      //                                                     child: Text(
      //                                                       product.description,
      //                                                       style: TextStyle(
      //                                                         fontSize: 15,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .w400,
      //                                                       ),
      //                                                     ),
      //                                                   ),
      //                                                   SizedBox(
      //                                                     height: 5,
      //                                                   ),
      //                                                   Text(
      //                                                     product.name,
      //                                                     style: TextStyle(
      //                                                       fontSize: 13,
      //                                                       fontWeight:
      //                                                           FontWeight.w400,
      //                                                       letterSpacing: 1.2,
      //                                                       color: Color(
      //                                                           0xFF819272),
      //                                                     ),
      //                                                   ),
      //                                                   SizedBox(
      //                                                     height: 5,
      //                                                   ),
      //                                                   Row(
      //                                                     mainAxisAlignment:
      //                                                         MainAxisAlignment
      //                                                             .spaceBetween,
      //                                                     children: [
      //                                                       Text(
      //                                                         product.unitPrice
      //                                                             .toString(),
      //                                                         style: TextStyle(
      //                                                           fontSize: 13,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .w700,
      //                                                           letterSpacing:
      //                                                               1.2,
      //                                                           color: Color(
      //                                                               0xFFF39E28),
      //                                                         ),
      //                                                       ),
      //                                                       Text(
      //                                                         "・",
      //                                                         style: TextStyle(
      //                                                           fontSize: 13,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .w700,
      //                                                           color: Color(
      //                                                               0xFFF3A953C),
      //                                                         ),
      //                                                       ),
      //                                                       Text(
      //                                                         product.isAvailable
      //                                                             ? "In stock"
      //                                                             : "Sold out",
      //                                                         style: TextStyle(
      //                                                           fontSize: 15,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .w400,
      //                                                           color: Color(
      //                                                               0xFFF3A953C),
      //                                                         ),
      //                                                       ),
      //                                                     ],
      //                                                   )
      //                                                 ],
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                         SizedBox(
      //                                           height: 28,
      //                                         ),
      //                                         Divider(
      //                                           color: Color(0xFFF5F5F5),
      //                                           // color: Colors.grey,
      //                                           thickness: 1,
      //                                           height: 0,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 );
      //                               }),
      //                     )
      //                   : Container(),
      //             ],
      //           ),
      //         );
      //       }
      //
      //       return Text('Error retrieving results: ${snapshot.error}');
      //     }),
      //   body: List<Product> productFound = snapshot.data;
      //     print("found!!!!!!!!!!!!!!!!!");
      // print(productFound);
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
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
                    "Search",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF819272),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  buildSearchField('Search Product', (value) {
                    searchController.clear();
                    setState(() {
                      productAlbum = ProductModel().searchProductByName(value);
                      history = value;
                    });
                  }, searchController),
                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    noResult ? "No Search Result" : "Latest Search",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF10151A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                noResult
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 280,
                          child: Text(
                            "We currently dont have what you’re looking for.  Why not try out similar products",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF10151A),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.width / 3,
                        // flex: 1,
                        child: history == null
                            ? Container()
                            : ListView.builder(
                                itemCount: count,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  bool delete = false;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading:
                                            Icon(Icons.access_time_outlined),
                                        title: Text(history),
                                        trailing: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                count = 0;
                                              });
                                            },
                                            child: Icon(Icons.close)),
                                        contentPadding:
                                            EdgeInsets.only(left: 0),
                                      ),
                                      Divider(
                                        color: Color(0xFFF5F5F5),
                                        // color: Colors.grey,
                                        thickness: 1,
                                        height: 0,
                                      )
                                    ],
                                  );
                                }),
                      ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                noResult ? "Related Searches" : "Popular Searches",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF10151A),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            productAlbum.isNotEmpty
                ? Expanded(
                    // flex: 5,
                    child: ListView.builder(
                        itemCount: productAlbum.length,
                        itemBuilder: (_, index) {
                          Product product = productAlbum[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailsScreen(
                                    // imageUrl: "assets/fruitbasket.png",
                                    product: product,
                                    imageUrl: product.imageUrl,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16, top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              // "assets/fruitbasket.png",
                                              product.imageUrl,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 250,
                                              child: Text(
                                                product.description,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Color(0xFF819272),
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
                                                  product.unitPrice.toString(),
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
                                                  product.isAvailable
                                                      ? "In stock"
                                                      : "Sold out",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFFF3A953C),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
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
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

// class searchWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Latest Search",
//             style: TextStyle(
//               fontSize: 17,
//               color: Color(0xFF10151A),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         Container(
//           height: MediaQuery.of(context).size.width / 3,
//           // flex: 1,
//           child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       leading: Icon(Icons.access_time_outlined),
//                       title: Text("Recent search"),
//                       trailing: Icon(Icons.close),
//                       contentPadding: EdgeInsets.only(left: 0),
//                     ),
//                     Divider(
//                       color: Color(0xFFF5F5F5),
//                       // color: Colors.grey,
//                       thickness: 1,
//                       height: 0,
//                     )
//                   ],
//                 );
//               }),
//         ),
//         SizedBox(
//           height: 32,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Popular Searches",
//             style: TextStyle(
//               fontSize: 17,
//               color: Color(0xFF10151A),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         Expanded(
//           // flex: 5,
//           child: ListView.builder(
//               itemCount: 6,
//               itemBuilder: (_, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => DetailsScreen(
//                           imageUrl: "assets/fruitbasket.png",
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 16, top: 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Hero(
//                               tag: "assets/fruitbasket.png",
//                               child: Container(
//                                 width: 90,
//                                 height: 120,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                       "assets/fruitbasket.png",
//                                     ),
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               height: 120,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Container(
//                                     width: 250,
//                                     child: Text(
//                                       "Herbsconnect Organic Acai Berry Powder Freeze Dried",
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     "Emmanuel Produce",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 1.2,
//                                       color: Color(0xFF819272),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "N35,000.00",
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w700,
//                                           letterSpacing: 1.2,
//                                           color: Color(0xFFF39E28),
//                                         ),
//                                       ),
//                                       Text(
//                                         "・",
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xFFF3A953C),
//                                         ),
//                                       ),
//                                       Text(
//                                         "In stock",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color(0xFFF3A953C),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 28,
//                         ),
//                         Divider(
//                           color: Color(0xFFF5F5F5),
//                           // color: Colors.grey,
//                           thickness: 1,
//                           height: 0,
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       ],
//     );
//   }
// }
