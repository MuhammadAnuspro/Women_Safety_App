import 'package:flutter/material.dart';

class PolicStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const PolicStationCard({super.key, this.onMapFunction,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!("Police Station Near me");
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 50,
                width: 50,
                //color: Colors.white,
                child: Center(child: Image.asset("assets/policebadge.png",height: 45,),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Police Station"),
          ),

        ],
        
      ),
    );
  }
}