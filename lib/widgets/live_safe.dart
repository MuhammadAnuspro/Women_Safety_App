import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_widgets/liveSafe/police_station_card.dart';
import 'home_widgets/liveSafe/HospitalCard.dart';
import 'home_widgets/liveSafe/BusStationCard.dart';
import 'home_widgets/liveSafe/PharmacyCard.dart';




class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async{
    String googleUrl ='https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try{
      await launchUrl(_url);

    }catch(e){
      Fluttertoast.showToast(msg: "Something ent wrong! please emergency Call Now ");


    }

  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PolicStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
        ],
      ),


    );
  }
}