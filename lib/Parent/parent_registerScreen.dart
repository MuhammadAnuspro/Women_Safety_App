import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/Child/child_loginScreen.dart';
import 'package:women_safety/model/user_model.dart';

import '../Components/custome_TextField.dart';
import '../Components/primaryButton.dart';
import '../Components/secoundryButton.dart';
import '../utils/constrins.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  bool isPasswordShown = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  _onSubmit() async {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      ShowdailogBOX(
          context, 'password and retype password should be not equal');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['cemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
          setState(() {
            isLoading = false;
          });
          final value = userCredential.user!.uid;

          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(value);
          final user = UserModel(
              name: _formData['name'].toString(),
              phone: _formData['phone'].toString(),
              childEmail: _formData['cemail'].toString(),
              guardianEmail: _formData['gemail'].toString(),
              id: value,
              type: 'parent');

          final jsondata = user.toJson();
          await db
              .set(jsondata)
              .whenComplete((() => goTo(context, LoginScreen())));
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          ShowdailogBOX(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          ShowdailogBOX(context, 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        ShowdailogBOX(context, e.toString());
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Register User As Parent",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 29,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor),
                                ),
                                Image.asset(
                                  'assets/womenlogo.jpg',
                                  height: 250,
                                  width: double.infinity,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        hintText: 'enter name',
                                        textInputAction: TextInputAction.next,
                                        keyboardtype:
                                            TextInputType.emailAddress,
                                        prefix: Icon(Icons.person),
                                        onsave: (name) {
                                          _formData['name'] = name ?? "";
                                        },
                                        validate: (name) {
                                          if (name!.isEmpty ||
                                              name.length < 8) {
                                            return 'enter correct name';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.009,
                                      ),
                                      Column(
                                        children: [
                                          CustomTextField(
                                            hintText: 'enter phone',
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardtype: TextInputType.phone,
                                            prefix: Icon(Icons.phone),
                                            onsave: (phone) {
                                              _formData['phone'] = phone ?? "";
                                            },
                                            validate: (phone) {
                                              if (phone!.isEmpty ||
                                                  phone.length < 10) {
                                                return 'enter correct phone no';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.009,
                                          ),
                                          Column(children: [
                                            Column(
                                              children: [
                                                CustomTextField(
                                                  hintText: 'enter email',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardtype: TextInputType
                                                      .emailAddress,
                                                  prefix: Icon(Icons.person),
                                                  onsave: (email) {
                                                    _formData['gemail'] =
                                                        email ?? "";
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.009,
                                                ),
                                                CustomTextField(
                                                  hintText: 'enter child email',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardtype: TextInputType
                                                      .emailAddress,
                                                  prefix:
                                                      Icon(Icons.contact_mail),
                                                  onsave: (cemail) {
                                                    _formData['cemail'] =
                                                        cemail ?? "";
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.009,
                                                ),
                                                Column(
                                                  children: [
                                                    CustomTextField(
                                                      hintText:
                                                          'enter password',
                                                      isPassword:
                                                          isPasswordShown,
                                                      prefix:
                                                          Icon(Icons.password),
                                                      validate: (password) {
                                                        if (password!.isEmpty ||
                                                            password.length <
                                                                7) {
                                                          return 'requried password';
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
                                                              ? Icon(Icons
                                                                  .visibility)
                                                              : Icon(Icons
                                                                  .visibility_off)),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.009,
                                                    ),
                                                    CustomTextField(
                                                      hintText:
                                                          'enter re-type password',
                                                      isPassword:
                                                          isPasswordShown,
                                                      prefix: Icon(Icons
                                                          .vpn_key_rounded),
                                                      validate: (password) {
                                                        if (password!.isEmpty ||
                                                            password.length <
                                                                7) {
                                                          return 'requried re-type password';
                                                        }
                                                        return null;
                                                      },
                                                      onsave: (rpassword) {
                                                        _formData['rpassword'] =
                                                            rpassword ?? "";
                                                      },
                                                      suffix: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isPasswordShown =
                                                                  !isPasswordShown;
                                                            });
                                                          },
                                                          icon: isPasswordShown
                                                              ? Icon(Icons
                                                                  .visibility_off)
                                                              : Icon(Icons
                                                                  .visibility)),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.040,
                                                    ),
                                                    PrimaryButton(
                                                        title: 'Login',
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _onSubmit();
                                                          }
                                                        }),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.040,
                                                    ),
                                                    SecondaryButton(
                                                        title:
                                                            'Login your Account',
                                                        onPressed: () {
                                                          goTo(context,
                                                              LoginScreen());
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
