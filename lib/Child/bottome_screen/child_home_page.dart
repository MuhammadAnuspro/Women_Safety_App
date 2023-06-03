import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safety/widgets/home_widgets/safehome/safeHome.dart';
import 'package:women_safety/widgets/live_safe.dart';

import '../../widgets/home_widgets/CustomeCarousel.dart';
import '../../widgets/home_widgets/customeAppBar.dart';
import '../../widgets/home_widgets/emergency.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});
  int qindex = 0;

  getRandomQuote() {
    Random random = Random();

    setState(() {
      qindex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomeAppBar(
                quoteindex: qindex,
                onTap: () {
                  getRandomQuote();
                }),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomeCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emergency call",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Emergency(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Explore LiveSafe",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: LiveSafe(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SafeHome(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
