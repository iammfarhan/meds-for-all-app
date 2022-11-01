// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_donation_app/pages/view_details.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medicine_donation_app/widgets/option_card.dart';

import '../widgets/carousal_widget.dart';
import '../widgets/label.dart';
import '../widgets/med_card.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream medsStream = FirebaseFirestore.instance.collection('meds').snapshots();

  void onChangeNavigation(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/addService');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/donation');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E6E6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff8C52FF),
        title: const Text(
          'Med For All ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              CarouselSliderWidget(),
              SizedBox(height: 30),
              LableWidget(title: 'Dashboard'),
              SizedBox(height: 10),
              OptionCard(
                optionTitle: "Your Record",
                optionImage: 'assets/images/trophy.png',
                optionSubTitle: "Medicine you donated",
                onTab: () {
                  Navigator.pushReplacementNamed(context, '/userrecord');
                },
              ),
              SizedBox(height: 20),
              LableWidget(title: 'App Stats'),
              SizedBox(height: 10),
              OptionCard(
                optionTitle: "Med For All Stats",
                optionImage: 'assets/images/stats.png',
                optionSubTitle: "See app stats & impact!",
                onTab: () {
                  Navigator.pushReplacementNamed(context, '/stats');
                },
              ),
              SizedBox(height: 20),
              LableWidget(title: 'Options'),
              SizedBox(height: 10),
              OptionCard(
                optionTitle: "Donate",
                optionImage: 'assets/images/med2.png',
                optionSubTitle: "Donate medicine here!",
                onTab: () {
                  Navigator.pushReplacementNamed(context, '/addService');
                },
              ),
              SizedBox(height: 10),
              OptionCard(
                optionTitle: "Get Medicne",
                optionImage: 'assets/images/med3.png',
                optionSubTitle: "Grab FREE Medicine here!",
                onTab: () {
                  Navigator.pushReplacementNamed(context, '/donation');
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onChange: onChangeNavigation,
        cIndex: 0,
      ),
    );
  }
}
