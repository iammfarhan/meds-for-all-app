// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_donation_app/widgets/option_card.dart';
import '../widgets/nav_bar.dart';

class MainFeatureScreen extends StatefulWidget {
  const MainFeatureScreen({Key? key}) : super(key: key);

  @override
  State<MainFeatureScreen> createState() => _MainFeatureScreenState();
}

class _MainFeatureScreenState extends State<MainFeatureScreen> {
  Stream medsStream = FirebaseFirestore.instance.collection('meds').snapshots();

  void onChangeNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/donation');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE9E6E6),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff8C52FF),
          title: const Text(
            'Med For All Options ',
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
                  optionTitle: "Medicine Request",
                  optionImage: 'assets/images/med3.png',
                  optionSubTitle: "See meds request here!",
                  onTab: () {
                    Navigator.pushReplacementNamed(
                        context, '/addmedicinerequestscreen');
                  },
                ),
                SizedBox(height: 10),
                OptionCard(
                  optionTitle: "Med Donation Camp",
                  optionImage: 'assets/images/med3.png',
                  optionSubTitle: "Donation camps updates!",
                  onTab: () {
                    Navigator.pushReplacementNamed(
                        context, '/adddonationcampscreen');
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 1,
        ),
      ),
    );
  }
}
