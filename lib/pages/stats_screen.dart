// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_donation_app/widgets/divider.dart';
import '../widgets/med_stat_card.dart';
import '../widgets/nav_bar.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  void onChangeNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/addService');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
    } else if (index == 4) {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "Med Stats",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff8C52FF),
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Our app impact on community",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Thank you for being part of it!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const MedStatCard(
              title: "210,19",
              subTitle: "boxes of medicine are donated",
              iconImage: 'assets/images/med1.png',
            ),
            const SizedBox(height: 20),
            const MedDivider(),
            const SizedBox(height: 20),
            const MedStatCard(
              title: "450,67\$",
              subTitle: "we saved",
              iconImage: 'assets/images/med2.png',
            ),
            const SizedBox(height: 20),
            const MedDivider(),
            const SizedBox(height: 20),
            const MedStatCard(
              title: "530,19",
              subTitle: "people & ngo's have been helped",
              iconImage: 'assets/images/med3.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onChange: onChangeNavigation,
        cIndex: 2,
      ),
    );
  }
}
