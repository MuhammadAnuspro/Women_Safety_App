import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:women_safety/Components/custome_TextField.dart';
import 'package:women_safety/utils/constrins.dart';

import 'Components/primaryButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "User Login",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.normal,color: primaryColor),
              ),
              Image.asset(
                'assets/womenlogo.jpg',
                height: 250,
                width: 250,
              ),
             
                  CustomeTextFeild(),
                   CustomeTextFeild(),
                PrimaryButton(title: 'Register', onPressed: (){}),
              
            ],
          ),
        ),
      )),
    );
  }
}
