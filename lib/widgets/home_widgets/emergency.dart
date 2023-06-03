import 'package:flutter/material.dart';

import 'emergencies.dart/ArmyEmergency.dart';
import 'emergencies.dart/ambulanceEmergency.dart';
import 'emergencies.dart/firebrigadeEmergency.dart';
import 'emergencies.dart/police_emergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
          ArmyEmergency(),
        ],
      ),

    );
  }
}