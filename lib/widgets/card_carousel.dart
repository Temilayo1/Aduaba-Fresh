import 'package:aduaba_app/model/card_detail_model.dart';
import 'package:aduaba_app/screens/card_selection_screen.dart';
import 'package:aduaba_app/screens/confirmation_screen.dart';
import 'package:aduaba_app/services/card_api.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

final List<CardModel> cards = [
  CardModel(
      cardNo: "3282328232823282",
      cardType: "VISA",
      name: "Aycan Doganlar",
      expDate: "09/23"),
  CardModel(
      cardNo: "3282328232823282",
      cardType: "MasterCard",
      name: "Aycan Doganlar",
      expDate: "09/23"),
  CardModel(
      cardNo: "3282328232823282",
      cardType: "VISA",
      name: "Aycan Doganlar",
      expDate: "09/23"),
  CardModel(
      cardNo: "3282328232823282",
      cardType: "VISA",
      name: "Aycan Doganlar",
      expDate: "09/23"),
  CardModel(
      cardNo: "3282328232823282",
      cardType: "MasterCard",
      name: "Aycan Doganlar",
      expDate: "09/23"),
  CardModel(
      cardNo: "3282328232823282",
      cardType: "VISA",
      name: "Aycan Doganlar",
      expDate: "09/23"),
];

class CardCarousel extends StatefulWidget {
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CardApi().getAllCards(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          _currentIndex = index;
                        },
                      );
                    },
                  ),
                  items: snapshot.data.asMap().entries.map<Widget>((item) {
                    final color =
                        categoryColors[item.key % categoryColors.length];
                    List<BoxShadow> customShadow = [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: -5,
                          offset: Offset(-5, -5),
                          blurRadius: 20),
                      BoxShadow(
                          color: color.withOpacity(.5),
                          spreadRadius: 2,
                          offset: Offset(7, 7),
                          blurRadius: 10),
                    ];
                    return Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            cards.add(CardModel(
                                cardType: item.value.cardType,
                                name: item.value.cardHolderName,
                                expDate: item.value.expiryDate,
                                cardNo: item.value.cardNumber));
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ConfirmationTab()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.99),
                            color: color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                top: 100,
                                bottom: -200,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: customShadow,
                                      shape: BoxShape.circle,
                                      color: Colors.white24),
                                ),
                              ),
                              Positioned.fill(
                                // left: -300,
                                left: -26,
                                top: -125,
                                right: 100,
                                bottom: -125,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: customShadow,
                                      shape: BoxShape.circle,
                                      color: Colors.white24),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                    height: 45,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: color,
                                      boxShadow: customShadow,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              item.value.cardType == "VISA"
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          // width: 100,
                                          padding: const EdgeInsets.all(30.0),
                                          child:
                                              Image.asset("assets/visa.png")),
                                    )
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 31, top: 20),
                                        child: Container(
                                            width: 210,
                                            child: Image.asset(
                                                "assets/mastercardlogo.png")),
                                      ),
                                    ),
                              Positioned(
                                top: 75,
                                left: 31,
                                right: 31,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${item.value.cardNumber.substring(0, 4)}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Text(
                                        " ****",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Text(
                                        " **** ",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Text(
                                        "${item.value.cardNumber.substring(12, 16)}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 121,
                                left: 31,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Card Holder",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    // Text(
                                    //   "${item.value.cardHolderName}",
                                    //   style: TextStyle(
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w400,
                                    //       color: Color(0xFFFFFFFF)),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 121,
                                right: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expires",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    Text(
                                      "${item.value.expiryDate}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cards.map((urlOfItem) {
                    int index = cards.indexOf(urlOfItem);
                    return Container(
                      width: 6.0,
                      height: 6.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color.fromRGBO(0, 0, 0, 0.8)
                            : Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Color(0xFFF5F5F5),
                  // color: Colors.grey,
                  thickness: 1,
                  height: 0,
                ),
              ],
            );
          }
          return Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: cards.asMap().entries.map((item) {
                  final color =
                      categoryColors[item.key % categoryColors.length];
                  List<BoxShadow> customShadow = [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: -5,
                        offset: Offset(-5, -5),
                        blurRadius: 20),
                    BoxShadow(
                        color: color.withOpacity(.5),
                        spreadRadius: 2,
                        offset: Offset(7, 7),
                        blurRadius: 10),
                  ];
                  return Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          cards.add(CardModel(
                              cardType: item.value.cardType,
                              name: item.value.name,
                              expDate: item.value.expDate,
                              cardNo: item.value.cardNo));
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ConfirmationTab()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.99),
                          color: color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              top: 100,
                              bottom: -200,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: customShadow,
                                    shape: BoxShape.circle,
                                    color: Colors.white24),
                              ),
                            ),
                            Positioned.fill(
                              // left: -300,
                              left: -26,
                              top: -125,
                              right: 100,
                              bottom: -125,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: customShadow,
                                    shape: BoxShape.circle,
                                    color: Colors.white24),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 45,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: color,
                                    boxShadow: customShadow,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            item.value.cardType == "VISA"
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        // width: 100,
                                        padding: const EdgeInsets.all(30.0),
                                        child: Image.asset("assets/visa.png")),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 31, top: 20),
                                      child: Container(
                                          width: 210,
                                          child: Image.asset(
                                              "assets/mastercardlogo.png")),
                                    ),
                                  ),
                            Positioned(
                              top: 75,
                              left: 31,
                              right: 31,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item.value.cardNo.substring(0, 4)}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    Text(
                                      " ****",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    Text(
                                      " **** ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    Text(
                                      "${item.value.cardNo.substring(12, 16)}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 121,
                              left: 31,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Card Holder",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                  Text(
                                    "${item.value.name}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 121,
                              right: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expires",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                  Text(
                                    "${item.value.expDate}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cards.map((urlOfItem) {
                  int index = cards.indexOf(urlOfItem);
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                color: Color(0xFFF5F5F5),
                // color: Colors.grey,
                thickness: 1,
                height: 0,
              ),
            ],
          );
          // return Container();
        });
  }
}
