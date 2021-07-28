import 'package:aduaba_app/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  bool remember = false;
  int _radioVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Forgot Password \nto your account",
                  style: TextStyle(
                    // letterSpacing: 1.5,
                    fontSize: 24,
                    color: Color(0xFF10151A),
                    fontWeight: FontWeight.w700,
                  ),
                  //  textAlign: TextAlign.center,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffecf5ec),
                  child: Icon(
                    Icons.security,
                    size: 18,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Select what contact details we use \nto reset your password",
              style: TextStyle(
                fontSize: 17,
                color: Color(0xff999999),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 39),
            Container(
              margin: EdgeInsets.only(bottom: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Color(0xff00A051).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.phone_android_outlined,
                              color: Color(0xff00A051),
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "via sms:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff10151a),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "••• •••• 7767",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff999999),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Radio(
                        activeColor: Color(0xffE75A21),
                        value: 0,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() => this._radioVal = value);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29,
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
            Container(
              margin: EdgeInsets.only(bottom: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Color(0xff00A051).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.email,
                              color: Color(0xff00A051),
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "via email:",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "••• ••••vid@gmail.com",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Radio(
                        activeColor: Color(0xffE75A21),
                        value: 1,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() => this._radioVal = value);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29,
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

            Spacer(),
            SizedBox(
              width: double.infinity,
              child: buttonWidget(
                buttonText: "Continue",
                buttonColor: Color(0xFF3A953C),
                buttonAction: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        height: MediaQuery.of(context).size.height / 100 * 60,
                        child: otpForm(context),
                      );
                    },
                  );
                },
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  Widget otpForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enter 4 Digits Code",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF3C673D),
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Enter the four digits code sent to your email address",
            style: TextStyle(
              fontSize: 17,
              color: Color(0xff999999),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pinField(
                null,
                (value) {
                  nextField(value: value, focusNode: pin2FocusNode);
                },
              ),
              pinField(
                pin2FocusNode,
                (value) {
                  nextField(value: value, focusNode: pin3FocusNode);
                },
              ),
              pinField(
                pin3FocusNode,
                (value) {
                  nextField(value: value, focusNode: pin4FocusNode);
                },
              ),
              pinField(
                pin4FocusNode,
                (value) {
                  nextField(value: value, focusNode: pin5FocusNode);
                },
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: buttonWidget(
                buttonText: "Continue",
                buttonColor: Color(0xFF3A953C),
                buttonAction: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 100 * 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: newPasswordModal(),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget pinField(FocusNode fNode, Function(String) onChange) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFF7F7F7),
      ),
      child: SizedBox(
        width: (75.75),
        height: 47,
        child: TextFormField(
          focusNode: fNode,
          obscureText: false,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF10151A)),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget newPasswordModal() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF3C673D),
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Set the new password for your account so you can login and access the features",
            style: TextStyle(
              fontSize: 17,
              color: Color(0xff999999),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF10151A),
                    ),
                  ),
                  SizedBox(height: 16),
                  buildTextField('Enter Password'),
                  SizedBox(height: 16),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF10151A),
                    ),
                  ),
                  SizedBox(height: 16),
                  buildTextField('Confirm Password'),
                  SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    child: buttonWidget(
                      buttonAction: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: DialogBox(),
                            );
                          },
                        );
                      },
                      buttonColor: Color(0xFF3A953C),
                      buttonText: 'Save password',
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
