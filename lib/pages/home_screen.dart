import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_donation_app/pages/view_details.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
      Navigator.pushReplacementNamed(context, '/stats');
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text('Home',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold))
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          hintText: 'Search for Medicine',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: MedCard(medsStream),
                ),
              ],
            ),
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
