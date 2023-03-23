import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicine_donation_app/pages/feat%20post%20medicine%20request/add_medicine_request.dart';
import 'package:medicine_donation_app/pages/feat%20post%20meds%20donation%20camp/add_donation_camp.dart';
import 'package:medicine_donation_app/pages/feat%20donate%20medicines/add_meds.dart';
import 'package:medicine_donation_app/pages/feat%20donate%20medicines/donation_screen.dart';
import 'package:medicine_donation_app/pages/feat%20post%20medicine%20request/user_posted_meds_request_record_screen.dart';
import 'package:medicine_donation_app/pages/feat%20post%20meds%20donation%20camp/user_posted_meds_camp_record_screen.dart';
import 'package:medicine_donation_app/pages/feat%20stats/main_features_screen.dart';
import 'package:medicine_donation_app/pages/feat%20donate%20medicines/meds_donated.dart';
import 'package:medicine_donation_app/pages/feat%20more/more_screen.dart';
import 'pages/auth screens/home_screen.dart';
import 'pages/auth screens/login_screen.dart';
import 'pages/auth screens/reset_screen.dart';
import 'pages/auth screens/signup_screen.dart';
import 'pages/auth screens/splash_screen.dart';
import 'pages/feat more/shortages_screen.dart';
import 'pages/feat post meds donation camp/medicine_donation_camp_screen.dart';
import 'pages/feat post medicine request/medicine_request_screen.dart';
import 'pages/feat stats/stats_screen.dart';
import 'pages/feat donate medicines/user_donated_record.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
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
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset': (context) => const ResetScreen(),
        '/donation': (context) => DonationScreen(),
        '/stats': (context) => const StatsScreen(),
        '/meddon': (context) => Medsdonated(),
        '/more': (context) => const MoreScreen(),
        '/shortage': (context) => ShortageScreen(),
        '/userrecord': (context) => UserDonatedRecord(),
        '/usermedsrequest': (context) => UserPostedMedsRecordScreen(),
        '/userdonationcampsrecord': (context) => UserPostedDonationCampScreen(),
        '/mainfeaturescreen': (context) => const MainFeatureScreen(),
        '/medicinedonationcampscreen': (context) =>
            const MedicineDonationCampScreen(),
        '/medicinerequestscreen': (context) => const MedicineRequestScreen(),
        '/adddonationcampscreen': (context) => const AddDonationCampScreen(),
        '/addmedicinerequestscreen': (context) => const AddMedicineRequestScreen(),
        '/addService': (context) => const AddMedicineScreen(),
      },
    );
  }
}
