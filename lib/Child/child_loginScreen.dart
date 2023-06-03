import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/Components/custome_TextField.dart';
import 'package:women_safety/Components/secoundryButton.dart';
import 'package:women_safety/Child/child_registerScreen.dart';
import 'package:women_safety/Parent/parent_registerScreen.dart';
import 'package:women_safety/db/shared_prefer.dart';
import 'package:women_safety/Child/bottome_screen/child_home_page.dart';
import 'package:women_safety/utils/constrins.dart';
import '../Components/primaryButton.dart';
import '../Parent/parent_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async {
    _formKey.currentState!.save();

    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['email'].toString(),
              password: _formData['password'].toString());
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            print(value['type']);
            MySharedPreference.saveUserType('parent');
            goTo(context, ParentHomeScreen());
          } else {
            MySharedPreference.saveUserType('child');
            goTo(context, HomeScreen());
          }
        });
        goTo(context, HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        ShowdailogBOX(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowdailogBOX(context, 'Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }

    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "User Login",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.normal,
                                    color: primaryColor),
                              ),
                              Image.asset(
                                'assets/womenlogo.jpg',
                                height: 250,
                                width: double.infinity,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    hintText: 'enter email',
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    prefix: Icon(Icons.person),
                                    onsave: (email) {
                                      _formData['email'] = email ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.040,
                                  ),
                                  Column(
                                    children: [
                                      CustomTextField(
                                        hintText: 'enter password',
                                        isPassword: isPasswordShown,
                                        prefix: Icon(Icons.vpn_key_rounded),
                                        validate: (password) {
                                          if (password!.isEmpty ||
                                              password.length < 7) {
                                            return 'enter correct password';
                                          }
                                          return null;
                                        },
                                        onsave: (password) {
                                          _formData['password'] =
                                              password ?? "";
                                        },
                                        suffix: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPasswordShown =
                                                    !isPasswordShown;
                                              });
                                            },
                                            icon: isPasswordShown
                                                ? Icon(Icons.visibility)
                                                : Icon(Icons.visibility_off)),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.040,
                                      ),
                                      PrimaryButton(
                                          title: 'Login',
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _onSubmit();
                                            }
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SecondaryButton(
                                  onPressed: () {
                                    goTo(context, RegisterChildScreen());
                                  },
                                  title: 'Forgot password?'),
                              Text(
                                "Click here",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SecondaryButton(
                              title: 'Register as child',
                              onPressed: () {
                                goTo(context, RegisterChildScreen());
                              }),
                          SecondaryButton(
                              title: 'Register as parent',
                              onPressed: () {
                                goTo(context, RegisterParentScreen());
                              }),
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
