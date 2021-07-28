import 'package:aduaba_app/providers/card_notifier.dart';
import 'package:aduaba_app/model/add_new_card_moderl.dart';
import 'package:aduaba_app/services/card_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({Key key}) : super(key: key);

  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // List<AddNewCard> cardList = [];

  // addCard(AddNewCard addNewCard) {
  //   setState(() {
  //     cardList.add(addNewCard);
  //   });
  // }

  // deleteCard(AddNewCard addNewCard) {
  //   setState(() {
  //     cardList.removeWhere(
  //         (_addNewCard) => _addNewCard.cardNumber == addNewCard.cardNumber);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CardApi cardNotifier = Provider.of<CardApi>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
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
                  "Payment",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF819272),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 42),
            child: CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              cardBgColor: Color(0xffE75A21),
              obscureCardNumber: true,
              obscureCardCvv: true,
              height: 179,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
              animationDuration: Duration(milliseconds: 1000),
              // width: 290,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: _formKey,
                    obscureCvv: true,
                    obscureNumber: false,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    cardNumberDecoration: cardnputField(Text: 'Card Number'),
                    expiryDateDecoration: cardnputField(Text: 'Expiry Date'),
                    cvvCodeDecoration: cardnputField(Text: 'Cvv '),
                    cardHolderDecoration:
                        cardnputField(Text: 'Card Holders Name'),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 33),
        child: buttonWidget(
          buttonText: "Save",
          buttonColor: Color(0xFF3A953C),
          buttonAction: () {
            // if (!_formKey.currentState.validate()) {
            //
            // }
            _formKey.currentState.save();
            // cardNotifier.registerCard(
            //     cardNumber, cardHolderName, expiryDate, cvvCode);
            print(cardNumber.replaceAll(" ", ""));
            print(cardHolderName);
            cardNotifier.registerCard(
                cardNo: cardNumber.replaceAll(" ", ""),
                cardName: cardHolderName,
                exp: expiryDate,
                cvv: cvvCode);

            Navigator.pop(context);
            // }

            // cardNotifier.addCard(
            //   AddNewCard(
            //     cardHolderName: cardHolderName,
            //     cardNumber: cardNumber,
            //     ccv: cvvCode,
            //     expiryDate: expiryDate,
            //   ),
            // );
            // addCard(
            //   AddNewCard(
            //     cardHolderName: cardHolderName,
            //     cardNumber: cardNumber,
            //     ccv: cvvCode,
            //     expiryDate: expiryDate,
            //   ),
            // );
          },
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(
      () {
        cardNumber = creditCardModel.cardNumber;
        expiryDate = creditCardModel.expiryDate;
        cardHolderName = creditCardModel.cardHolderName;
        cvvCode = creditCardModel.cvvCode;
        isCvvFocused = creditCardModel.isCvvFocused;
      },
    );
  }

//   InputDecoration cardInputField({
//     //Function(String) validate,
//     String text,
//     Function(String) onSaved,
//     initialValue,
//     @required bool pass,
//     TextInputType textInputType,
//   }) {
//     onSaved;

//     pass;
//     return InputDecoration(
//       // validator: (String value) {
//       //   if (value.isEmpty) {
//       //     return 'field is requiued';
//       //   }
//       //   ;
//       //   return null;
//       // },

//       filled: true,
//       fillColor: Color(0xFFF7F7F7),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(width: 0, color: Color(0xFFF7F7F7)),
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         borderSide: BorderSide(color: Color(0xFFF7F7F7)),
//       ),
//       hintText: text,
//       labelText: text,
//     );
//   }
// }

  InputDecoration cardnputField({
    String Text,
    final Function onSaved,
  }) {
    Widget build(BuildContext context) {
      return TextFormField(
        decoration: cardnputField(),
        initialValue: '',
        validator: (String value) {
          if (value.isEmpty) {
            return '$Text is required';
          }

          return null;
        },
        onSaved: onSaved,
      );
    }

    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: '$Text',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}
