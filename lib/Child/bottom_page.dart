import 'package:flutter/material.dart';
import 'package:women_safety/Child/bottome_screen/add_contacts.dart';
import 'package:women_safety/Child/bottome_screen/chat_page.dart';
import 'package:women_safety/Child/bottome_screen/child_home_page.dart';
import 'package:women_safety/Child/bottome_screen/profile_page.dart';
import 'package:women_safety/Child/bottome_screen/review_page.dart';
import 'package:women_safety/utils/constrins.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ProfileScreen(),
    AddContactsPage(),
    ChatScreen(),
    ReviewScreen(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 143, 184, 204),
              icon: Icon(
                Icons.holiday_village,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person_pin_outlined,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Contact',
              icon: Icon(
                Icons.contact_phone,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(
                Icons.chat_outlined,
                color: primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Review',
              icon: Icon(
                Icons.star_purple500,
                color: primaryColor,
              ),
            ),
          ]),
    );
  }
}
