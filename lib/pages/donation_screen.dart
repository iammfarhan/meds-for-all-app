// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    Stream medsStream =
        FirebaseFirestore.instance.collection('meds').snapshots();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Text(
                    'Grab free medicine here!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          String searchKey = value;
                          medsStream = FirebaseFirestore.instance
                              .collection('meds')
                              .where('med_name',
                                  isGreaterThanOrEqualTo: searchKey)
                              .where('med_name', isLessThan: searchKey + 'z')
                              .snapshots();
                        });
                      },
                      style: const TextStyle(fontSize: 13),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        hintText: 'Search for Medicine',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: MedCard(medsStream),
                //  child: availableMedicine(medsStream),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget donatedMedicineHistory(BuildContext context) {
    return Column();
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
