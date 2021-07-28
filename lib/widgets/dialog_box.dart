import 'dart:async';

import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/screens/sign_in.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({Key key}) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //     const Duration(seconds: 3),
  //     () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MyHomePage(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      margin: EdgeInsets.only(top: 45),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        // ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Your password has \nbeen reset",
              style: TextStyle(
                color: Color(0xFF10151A),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 45,
            ),
            SizedBox(
              width: double.infinity,
              child: buttonWidget(
                  buttonText: "Sign In",
                  buttonColor: Color(0xFF3A953C),
                  buttonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
