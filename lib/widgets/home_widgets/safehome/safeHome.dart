import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SafeHome extends StatelessWidget {
  showModelSafeHome(BuildContext context){
 showModalBottomSheet(context: context, builder: (context){
  return SingleChildScrollView(
    child: ClipPath(
  clipper: WaveClipperTwo(),
  child: Container(
    height: MediaQuery.of(context).size.width / 1.4,
    color: Colors.black.withOpacity(0.7),
    
  ),
  
    ),
  );
 },

 );
  }
  const SafeHome({super.key});

  @override
  Widget build(BuildContext context) {
     return
    InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 170,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Send Location"),
                        subtitle: Text("Share Location",style: TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/helpme.jpg",),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
