import 'dart:async';

import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/providers/auth_provider.dart';
import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/providers/user_provider.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/screens/onboarding.dart';
import 'package:aduaba_app/screens/sign_in.dart';
import 'package:aduaba_app/screens/sign_up.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void initState() {
    super.initState();

    authUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/landing_image.png',
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  authUser() async {
    var data = await UserPreferences().getUser();
    print(data.token);
    if (data.token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    }
  }
}
