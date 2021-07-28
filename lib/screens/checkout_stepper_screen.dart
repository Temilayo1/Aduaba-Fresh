// import 'package:aduaba_app/screens/confirmation_screen.dart';
// import 'package:aduaba_app/screens/payment_tab.dart';
// import 'package:aduaba_app/screens/shipping_tab.dart';
// import 'package:flutter/material.dart';
//
// import '../constants.dart';
// import 'card_selection_screen.dart';
// import 'home_screen.dart';
//
// class CheckoutStepperScreen extends StatefulWidget {
//   @override
//   _CheckoutStepperScreenState createState() => _CheckoutStepperScreenState();
// }
//
// class _CheckoutStepperScreenState extends State<CheckoutStepperScreen> {
//   int _n = 0;
//   Widget _widget;
//
//   // _n == 0
//   // ? _widget = ShippingAddressTab()
//   //     : _n == 1
//   //   ? _widget = ConfirmationTab()
//   //     : _n == 2
//   //   ? _widget = PaymentTab()
//   //     : Container(),
//
//   Widget stepperScreen(n) {
//     print(n);
//     if (n == 0) {
//       return _widget = ShippingAddressTab();
//     } else if (n == 1) {
//       return _widget = PaymentTab();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: stepperScreen(_n),
//       bottomNavigationBar: _n == 2
//           ? Container()
//           : Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 33),
//               child: buttonWidget(
//                   buttonText: _n == 0 ? "Proceed To Payment" : "Pay Now",
//                   buttonColor: Color(0xFF3A953C),
//                   buttonAction: () {
//                     setState(() {
//                       print(_n);
//                       _n++;
//                       print(_n);
//
//                       if (_n == 2) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   CardSelection()),
//                         );
//                       }
//                     });
//                   }),
//             ),
//     );
//   }
// }
