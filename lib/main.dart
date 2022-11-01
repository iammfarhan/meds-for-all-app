import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medicine_donation_app/pages/add_meds.dart';
import 'package:medicine_donation_app/pages/login_screen.dart';
import 'package:medicine_donation_app/pages/donation_screen.dart';
import 'package:medicine_donation_app/pages/meds_avail.dart';
import 'package:medicine_donation_app/pages/meds_donated.dart';
import 'package:medicine_donation_app/pages/more_screen.dart';
import 'package:medicine_donation_app/pages/splash_screen.dart';
import 'pages/home_screen.dart';
import 'pages/login_screen.dart';
import 'pages/reset_screen.dart';
import 'pages/shortages_screen.dart';
import 'pages/splash_screen.dart';
import 'pages/signup_screen.dart';
import 'dart:ffi';

import 'pages/stats_screen.dart';
import 'pages/user_donated_record.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();

    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      //Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/reset': (context) => ResetScreen(),
        '/donation': (context) => DonationScreen(),
        '/stats': (context) => StatsScreen(),
        '/meddon': (context) => Medsdonated(),
        '/more': (context) => MoreScreen(),
        '/shortage': (context) => ShortageScreen(),
        '/userrecord': (context) => UserDonatedRecord(),
        
            '/addService': (context) => ServiceAddPage(
              initialized: _initialized,
              error: _error,
            ),
      },
    );
  }
}
