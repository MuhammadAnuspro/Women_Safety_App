import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety/Child/bottom_page.dart';
import 'package:women_safety/Child/child_loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:women_safety/Parent/parent_home_screen.dart';
import 'package:women_safety/db/shared_prefer.dart';
import 'package:women_safety/utils/constrins.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MySharedPreference.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.aclonicaTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: MySharedPreference.getUserType(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == "") {
                return LoginScreen();
              }
              if (snapshot.data == 'child') {
                return BottomScreen();
              }
              if (snapshot.data == 'parent') {
                return ParentHomeScreen();
              }
              return progressIndicator(context);
            }));
  }
}

// class CheckAuth extends StatelessWidget {
//   // const CheckAuth({super.key});

//   checkData() {
//     if (MySharedPreference.getUserType() == 'parent') {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
