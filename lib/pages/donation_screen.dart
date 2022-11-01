// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_donation_app/pages/available_meds.dart';
import 'package:medicine_donation_app/pages/donated_medicine.dart';
import '../widgets/med_card.dart';
import '../widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';

class DonationScreen extends StatefulWidget {
  DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int selectedTab = 0;

  Widget availableMedicine(BuildContext context) {
    return AvailableMeds();
  }

  Widget donatedMedicineHistory(BuildContext context) {
    return DonatedMedicine();
  }

  late List<Widget> content;

  void onChangeNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/addService');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
    }
  }

  @override
  void initState() {
    content = [
      availableMedicine(context),
      donatedMedicineHistory(context),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E6E6),
      appBar: AppBar(
        title: const Text(
          "Donations",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff8C52FF),
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: CupertinoSlidingSegmentedControl<int>(
                children: {
                  0: Text("Available Medicine"),
                  1: Text("Donated History"),
                },
                groupValue: selectedTab,
                onValueChanged: (value) {
                  setState(
                    () {
                      selectedTab = value!;
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: content[selectedTab],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onChange: onChangeNavigation,
        cIndex: 3,
      ),
    );
  }
}
