import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

class PrimaryButton extends StatelessWidget {

  final String title;
  final Function onPressed;
  bool  isloading;

  PrimaryButton({
    required this.title,required this.onPressed,this.isloading = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(onPressed: (){}, child: Text(title),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
          
        )
      ),
      ),
    );
    

  }
}