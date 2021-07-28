import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

const kSECRET_KEY = "sk_test_414a941f5dd0feeca0465bf86813cf5d830e562f";

// Widget buildNumberField(String text) {
//   final color = Colors.white;
//
//   return TextField(
//     keyboardType: TextInputType.number,
//     style: TextStyle(
//       color: Color(0xFFF7F7F7),
//     ),
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       hintText: text,
//       hintStyle: TextStyle(
//           color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
//       filled: true,
//       fillColor: Color(0xFFF7F7F7),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Color(0xFFF7F7F7)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Color(0xFFF7F7F7)),
//       ),
//     ),
//   );
// }

List<String> searchValues = [];

bool validateEmail(String value) {
  bool _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    // _msg = "Your username is required";
    _msg = false;
  } else if (!regex.hasMatch(value)) {
    // _msg = "Please provide a valid emal address";
    _msg = false;
  }
  return true;
}

final detailsPageTransitionType = ContainerTransitionType.fade;

Widget buildTextField(String text) {
  final color = Colors.white;

  return TextField(
    keyboardType: TextInputType.name,
    style: TextStyle(
      color: Color(0xFF10151A),
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      hintText: text,
      hintStyle: TextStyle(
          color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
    ),
  );
}

Widget buildVendorSearchField(String text) {
  final color = Colors.white;

  return TextField(
    style: TextStyle(
      color: Color(0xFFF7F7F7),
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      hintText: text,
      hintStyle: TextStyle(
          color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
      prefixIcon: Icon(
        Icons.search_rounded,
        color: Color(0xFFBABABA),
      ),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
    ),
  );
}

Widget buildSearchField(String text, Function(String) onSubmit, control) {
  final color = Colors.white;

  return TextField(
    onSubmitted: onSubmit,
    controller: control,
    style: TextStyle(
      color: Color(0xFF10151A),
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      hintText: text,
      hintStyle: TextStyle(
          color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
      prefixIcon: Icon(
        Icons.search_rounded,
        color: Color(0xFFBABABA),
      ),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
    ),
  );
}

Widget buildRangeField(String text) {
  final color = Colors.white;

  return TextField(
    style: TextStyle(
      color: Color(0xFFF7F7F7),
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      hintText: text,
      hintStyle: TextStyle(
          color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
    ),
  );
}

Row subTitle({String title, Color color, VoidCallback onTapped}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 17,
          color: Color(0xFF3C673D),
          fontWeight: FontWeight.w700,
        ),
      ),
      GestureDetector(
        onTap: onTapped,
        child: Row(
          children: [
            Text(
              "View all  ",
              style: TextStyle(
                fontSize: 13,
                color: color ?? Color(0xFF999999),
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              "assets/arrow.png",
              color: color ?? Color(0xFF999999),
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildMenuItem({
  @required String text,
  Image image,
  Icon icon,
  VoidCallback onClicked,
}) {
  final color = Color(0xFF10151A);

  return Column(
    children: [
      ListTile(
        leading: image ?? icon,
        title: Text(
          text,
          style: TextStyle(
              fontSize: 17, color: color, fontWeight: FontWeight.w400),
        ),
        onTap: onClicked,
      ),
      Divider(
        color: Color(0xFFF5F5F5),
        // color: Colors.grey,
        thickness: 1,
        height: 0,
      )
    ],
  );
}

Widget buttonWidget(
    {@required VoidCallback buttonAction,
    @required Color buttonColor,
    @required String buttonText}) {
  return Material(
    color: buttonColor,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    elevation: 1,
    child: MaterialButton(
      onPressed: buttonAction,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

Widget signUpButtonWidget(
    {@required VoidCallback buttonAction,
    @required Color buttonColor,
    String img,
    @required String buttonText}) {
  return Material(
    color: buttonColor,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    elevation: 1,
    child: MaterialButton(
      onPressed: buttonAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img),
          SizedBox(
            width: 13.5,
          ),
          Text(
            buttonText,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}

Widget signUpOutlineButtonWidget(
    {@required VoidCallback buttonAction,
    String img,
    @required String buttonText}) {
  return Material(
    color: Colors.transparent,
    // elevation: 1,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xFF10151A)),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: MaterialButton(
      onPressed: buttonAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img),
          SizedBox(
            width: 13.5,
          ),
          Text(
            buttonText,
            style: TextStyle(
                color: Color(0xFF10151A),
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}

Widget outlineButtonWidget(
    {@required VoidCallback buttonAction,
    // @required Color buttonColor,
    @required String buttonText}) {
  return Material(
    color: Colors.transparent,
    // elevation: 1,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xFF10151A)),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: MaterialButton(
      onPressed: buttonAction,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Color(0xFF10151A),
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
    ),
  );
}

final RegExp emailvalidatorRegExp =
    RegExp(r"^[a-zA-Z0-9,]+@[a-zA-Z0-9,]+\.[a-zA-Z])+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter a valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password too short";
const String kMatchPassError = "Passwords don't match";

Widget buildAddressInputField(
    {String text,
    TextEditingController controller,
    Function(String) onChange,
    Function(String) onSave,
    Function(String) validate}) {
  return TextFormField(
    autofocus: false,
    cursorColor: Color(0xFF10151A),
    style: TextStyle(
        fontSize: 15, color: Color(0xFF10151A), fontWeight: FontWeight.w700),
    onSaved: onSave,

    onChanged: onChange,
    validator: validate,
    controller: controller,
    // onChanged: (tit) {
    //   if (tit.isNotEmpty) {
    //     setState(() {
    //       title = tit;
    //     });
    //   }
    // },
    maxLines: null,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 13.5, vertical: 16),
      hintText: text,
      hintStyle: TextStyle(
          color: Color(0xFFBABABA), fontWeight: FontWeight.w400, fontSize: 15),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
    ),
  );
}

Padding buildAddressSubTitle(String text, VoidCallback onPress) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFF10151A)),
        ),
        TextButton.icon(
            onPressed: onPress,
            icon: Icon(
              Icons.add,
              color: Color(0xFF3E3E3E),
              size: 18,
            ),
            label: Text(
              "Add Address",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF3E3E3E)),
            ))
      ],
    ),
  );
}

List<Color> categoryColors = [
  // Color(0xFF3A953C1A),
  Color(0xFF3A953C),
  Color(0xFFBB2F48),
  Color(0xFF3C673D),
  Color(0xFFE75A21),
];

TextFormField buildTextFormField(
    {Function(String) validate,
    Function(String) onSave,
    Function(String) onChange,
    @required bool pass,
    TextInputType textInputType,
    String text}) {
  return TextFormField(
    obscureText: pass,
    onSaved: onSave,
    onChanged: onChange,
    validator: validate,
    keyboardType: textInputType ?? TextInputType.name,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      fillColor: Color(0xfff7f7f7),
      filled: true,
      hintText: text,
      hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Color(0xffbababa),
      ),
    ),
  );
}

TextFormField buildPasswordTextFormField(
    {Function(String) validate,
    Function(String) onSave,
    Function(String) onChange,
    VoidCallback togglePasswordView,
    @required bool pass,
    TextInputType textInputType,
    String text}) {
  return TextFormField(
    obscureText: pass,
    onSaved: onSave,
    onChanged: onChange,
    validator: validate,
    keyboardType: textInputType ?? TextInputType.name,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Color(0xFFF7F7F7)),
      ),
      fillColor: Color(0xfff7f7f7),
      filled: true,
      hintText: text,
      suffixIcon: InkWell(
        onTap: togglePasswordView,
        child: Icon(
          pass ? Icons.visibility : Icons.visibility_off_outlined,
          color: Color(0xff999999),
        ),
      ),
      hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Color(0xffbababa),
      ),
    ),
  );
}

Text formTextTitle(text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 15,
      color: Color(0xFF10151A),
      fontWeight: FontWeight.w700,
    ),
  );
}
