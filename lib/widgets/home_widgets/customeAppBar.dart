import 'package:flutter/material.dart';
import 'package:women_safety/utils/quotes.dart';

class CustomeAppBar extends StatelessWidget {
  Function? onTap;
  int? quoteindex;
  CustomeAppBar({this.onTap, this.quoteindex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: SafeArea(
        child: Container(
          child: Text(sweetSayings[quoteindex!],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
