import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/providers/auth_provider.dart';
import 'package:aduaba_app/providers/user_provider.dart';
import 'package:aduaba_app/utilities/constants.dart';
import 'package:aduaba_app/screens/sign_in.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:aduaba_app/widgets/form_errors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPassHidden = true;
  bool _isConfirmPassHidden = true;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _confirmPassword;
  String _firstName;
  String _lastName;

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text(" Registering ... Please wait")
    ],
  );
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  User user;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    VoidCallback doRegister = () {
      print('on doRegister');

      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();

        auth.registeredInStatus = Status.Authenticating;
        auth.notify();

        if (_password.endsWith(_confirmPassword)) {
          auth
              .register(
                  _email, _password, _confirmPassword, _firstName, _lastName)
              .then((response) {
            // auth.register().then((response) {
            if (response['status']) {
              print(response['status']);
              User user = response['data'];

              Provider.of<UserProvider>(context, listen: false).setUser(user);
              Navigator.push(
                context,
                CustomPageRoute(
                  child: SignIn(),
                  direction: AxisDirection.left,
                ),
              );
            } else {
              auth.registeredInStatus = Status.NotRegistered;
              auth.notify();
              Flushbar(
                title: 'Registration fail',
                message: response.toString(),
                duration: Duration(seconds: 10),
              ).show(context);
            }
          });
        } else {
          auth.registeredInStatus = Status.NotRegistered;
          auth.notify();
          Flushbar(
            title: 'Mismatch password',
            message: 'Please enter valid confirm password',
            duration: Duration(seconds: 10),
          ).show(context);
        }
      } else {
        auth.registeredInStatus = Status.NotRegistered;
        auth.notify();
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create \nyour account",
                    style: TextStyle(
                      // letterSpacing: 1.5,
                      fontSize: 24,
                      color: Color(0xFF10151A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xffecf5ec),
                    child: Icon(
                      Icons.person,
                      size: 27,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: signUpOutlineButtonWidget(
                        img: "assets/google.png",
                        buttonText: "Sign in with Google",
                        buttonAction: () {},
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: signUpButtonWidget(
                        img: "assets/fb.png",
                        buttonText: "Register with Facebook",
                        buttonColor: Color(0xff3d5b96),
                        buttonAction: () {},
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: signUpButtonWidget(
                        img: "assets/ios.png",
                        buttonText: "Sign in with Apple ID",
                        buttonColor: Colors.black,
                        buttonAction: () {},
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        "- OR REGISTER WITH EMAIL -",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    formTextTitle("First Name"),
                    SizedBox(height: 10),
                    buildTextFormField(
                      validate: (value) =>
                          value.isEmpty ? 'Please enter first name' : null,
                      pass: false,
                      text: "First Name",
                      onSave: (val) => _firstName = val,
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Last Name"),
                    SizedBox(height: 10),
                    buildTextFormField(
                      validate: (value) =>
                          value.isEmpty ? 'Please enter last name' : null,
                      pass: false,
                      text: "Last Name",
                      onSave: (val) => _lastName = val,
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Email Address"),
                    SizedBox(height: 10),
                    buildTextFormField(
                        pass: false,
                        text: "Email Address",
                        validate: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                            return "Please enter valid email";
                          }
                        },
                        // onChange: (value) {
                        //   if (value.isEmpty ||
                        //       !emailvalidatorRegExp.hasMatch(value)) {
                        //     setState(() {
                        //       errors.add(kEmailNullError);
                        //     });
                        //     return "Please enter valid email";
                        //   }
                        // },
                        onChange: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                            return "Please enter valid email";
                          }
                        },
                        onSave: (newValue) => _email = newValue),
                    SizedBox(height: 20),
                    formTextTitle("Password"),
                    SizedBox(height: 10),
                    buildPasswordTextFormField(
                        text: "Enter Password",
                        onSave: (newValue) => _password = newValue,
                        onChange: (value) => value.isEmpty
                            ? 'Please enter password'
                            : _password = value,
                        validate: (value) =>
                            value.isEmpty ? 'Please enter password' : null,
                        togglePasswordView: () {
                          setState(() {
                            _isPassHidden = !_isPassHidden;
                          });
                        },
                        textInputType: TextInputType.visiblePassword,
                        pass: _isPassHidden),
                    SizedBox(height: 20),
                    formTextTitle("Confirm Password"),
                    SizedBox(height: 20),
                    buildPasswordTextFormField(
                        text: "Confirm Password",
                        onSave: (newValue) => _confirmPassword = newValue,
                        togglePasswordView: () {
                          setState(() {
                            _isConfirmPassHidden = !_isConfirmPassHidden;
                          });
                        },
                        textInputType: TextInputType.visiblePassword,
                        pass: _isConfirmPassHidden),
                    SizedBox(
                      height: 24,
                    ),
                    FormError(errors: errors),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: auth.registeredInStatus == Status.Authenticating
                          ? loading
                          : buttonWidget(
                              buttonText: "Create Account",
                              buttonColor: Color(0xFF3A953C),
                              buttonAction: doRegister,
                            ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: SignIn(),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Have an account?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff999999),
                                    letterSpacing: 1),
                              ),
                              TextSpan(
                                text: (' Sign In'),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3A953C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// log().debug(response);
