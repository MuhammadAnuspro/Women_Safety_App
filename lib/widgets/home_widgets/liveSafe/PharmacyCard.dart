import 'package:flutter/material.dart';

class PharmacyCard extends StatelessWidget {
  final Function? onMapFunction;
  const PharmacyCard({super.key,this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction! ("Pharmacy near me");
            },
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    //color: Colors.white,
                    child: Center(child: Image.asset("assets/pharmacy.png",height: 32,),
                    ),
                  ),
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Pharmacy"),
          ),

        ],
        
      ),
    );
  }
}