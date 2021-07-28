import 'dart:async';

import 'package:aduaba_app/providers/address_notifier.dart';
import 'package:aduaba_app/providers/card_notifier.dart';
import 'package:aduaba_app/providers/auth_provider.dart';
import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/providers/category_provider.dart';
import 'package:aduaba_app/providers/product_provider.dart';
import 'package:aduaba_app/providers/user_account_edit_provider.dart';
import 'package:aduaba_app/providers/user_provider.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/screens/landing_page.dart';
import 'package:aduaba_app/screens/onboarding.dart';
import 'package:aduaba_app/services/card_api.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

void main() {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryModel()),
        ChangeNotifierProvider(create: (_) => ProductModel()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CardNotifier()),
        ChangeNotifierProvider(create: (_) => CardApi()),
        ChangeNotifierProvider(create: (_) => AddressNotifier()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'TT Norms Pro', scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
