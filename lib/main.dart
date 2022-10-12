
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicine_donation_app/pages/reset_screen.dart';
import 'package:medicine_donation_app/pages/signup_screen.dart';
import 'package:medicine_donation_app/pages/splash_screen.dart';
import 'pages/home_screen.dart';
import 'pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ResetScreen(),
      ),
    );
  }
}

// class Routes extends StatefulWidget {
//   const Routes({required Key key}) : super(key: key);

//   @override
//   _RoutesState createState() => _RoutesState();
// }

// class _RoutesState extends State<Routes> {
//   bool _initialized = false;
//   bool _error = false;

//   @override
//   void initState() {
//     super.initState();

//     initializeFlutterFire();
//   }

//   void initializeFlutterFire() async {
//     try {
//       //Wait for Firebase to initialize and set `_initialized` state to true
//       await Firebase.initializeApp();
//       setState(() {
//         _initialized = true;
//       });
//     } catch (e) {
//       // Set `_error` state to true if Firebase initialization fails
//       setState(() {
//         _error = true;
//       });
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
