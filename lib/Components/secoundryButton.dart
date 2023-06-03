import 'package:flutter/material.dart';
class SecondaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  SecondaryButton({Key? key,required this.onPressed,required this.title}):super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(onPressed: (){
        onPressed;
      }, child: Text(title),
      ),

    );
  }
}