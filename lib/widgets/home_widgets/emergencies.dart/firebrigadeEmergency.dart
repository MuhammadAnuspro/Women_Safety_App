import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FirebrigadeEmergency extends StatelessWidget {

   _callNumber(String number) async{
  await FlutterPhoneDirectCaller.callNumber(number);
   }
  const FirebrigadeEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => _callNumber('16'),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Color.fromARGB(255, 255, 181, 206), Colors.blueGrey],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      CircleAvatar(
                        radius: 25,
                        child: Image.asset("assets/fire_fire.jpg"),
                        backgroundColor: Colors.white.withOpacity(0.5),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
        
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Fire brigade",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "In Case Of Fire Emergency Call",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width *
                                        0.035),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "1-6",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.047,
                                      color: Color.fromARGB(255, 255, 179, 205),
                                ),
                              ),
                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
