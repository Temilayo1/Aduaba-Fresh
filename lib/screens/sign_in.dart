import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/providers/auth_provider.dart';
import 'package:aduaba_app/providers/cart.dart';
import 'package:aduaba_app/providers/user_provider.dart';
import 'package:aduaba_app/utilities/constants.dart';
import 'package:aduaba_app/screens/home_screen.dart';
import 'package:aduaba_app/screens/reset_password.dart';
import 'package:aduaba_app/screens/sign_up.dart';
import 'package:aduaba_app/widgets/custom_page_route.dart';
import 'package:aduaba_app/widgets/form_errors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPassHidden = true;
  final emailControllerr = TextEditingController();
  final passwordController = TextEditingController();
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

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

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doLogin = () {
      final form = _formKey.currentState;

      if (form.validate()) {
        form.save();

        auth.loggedInStatus = Status.Authenticating;
        auth.notify();

        // final Future<Map<String, dynamic>> response =
        auth.login(_email, _password).then((response) {
          if (response['status']) {
            print(response['status']);
            User user = response['user'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Provider.of<Cart>(context, listen: false).getAllCartItems();

            Navigator.push(
              context,
              CustomPageRoute(
                child: MyHomePage(name: user.firstName),
                direction: AxisDirection.up,
              ),
            );
          } else {
            auth.loggedInStatus = Status.NotLoggedIn;
            auth.notify();
            Flushbar(
              title: "Failed Login",
              // message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        auth.loggedInStatus = Status.NotLoggedIn;
        auth.notify();
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );

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
                    "Sign in \nto your account",
                    style: TextStyle(
                      // letterSpacing: 1.5,
                      fontSize: 24,
                      color: Color(0xFF10151A),
                      fontWeight: FontWeight.w700,
                    ),
                    //  textAlign: TextAlign.center,
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
              SizedBox(
                height: 48,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formTextTitle("Email Address"),
                    SizedBox(height: 20),
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
                      onChange: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            errors.add(kEmailNullError);
                          });
                          return "Please enter valid email";
                        }
                      },
                      onSave: (newValue) => _email = newValue,
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Password"),
                    SizedBox(height: 20),
                    buildPasswordTextFormField(
                        text: "Enter Password",
                        onSave: (newValue) => _password = newValue,
                        onChange: (value) =>
                            value.isEmpty ? 'Please enter password' : null,
                        validate: (value) =>
                            value.isEmpty ? 'Please enter password' : null,
                        togglePasswordView: () {
                          setState(() {
                            _isPassHidden = !_isPassHidden;
                          });
                        },
                        textInputType: TextInputType.visiblePassword,
                        pass: _isPassHidden),
                    FormError(
                      errors: errors,
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: ResetPassword(),
                              direction: AxisDirection.up,
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF819272),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: auth.loggedInStatus == Status.Authenticating
                          ? loading
                          : buttonWidget(
                              buttonText: "Login",
                              buttonColor: Color(0xFF3A953C),
                              buttonAction: doLogin),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "- OR SIGN IN WITH SOCIALS -",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: signUpButtonWidget(
                        img: "assets/ios.png",
                        buttonText: "Sign in with Apple ID",
                        buttonColor: Colors.black,
                        buttonAction: () {},
                      ),
                    ),
                    SizedBox(height: 16),
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
                    SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: SignUp(),
                            direction: AxisDirection.right,
                          ),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff999999),
                                    letterSpacing: 1),
                              ),
                              TextSpan(
                                text: (' Sign Up'),
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
