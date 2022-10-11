import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_screen.dart';

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
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class Routes extends StatefulWidget {
  const Routes({required Key key}) : super(key: key);

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
    // TODO: implement build
    throw UnimplementedError();
  }
}
