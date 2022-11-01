// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_donation_app/widgets/more_card.dart';

import '../widgets/nav_bar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onChangeNavigation(int index) {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/addService');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/donation');
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFE9E6E6),
      appBar: AppBar(
        title: const Text(
          "More",
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
            SizedBox(height: 30),
            MoreCard(
              title: "Shoratges",
              iconData: Icons.location_city_outlined,
              onTab: () {
                Navigator.pushReplacementNamed(context, '/shortage');
              },
            ),
            SizedBox(height: 10),
            MoreCard(
              title: "Logout",
              iconData: Icons.lock,
              onTab: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onChange: onChangeNavigation,
        cIndex: 0,
      ),
    );
  }
}
