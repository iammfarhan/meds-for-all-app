// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/med_stat_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       
         return false; 
       },
      child: Scaffold(
        backgroundColor: Color(0xFFE9E6E6),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('meds').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var ds = snapshot.data!.docs;
                double sum = 0;
    
                for (int i = 0; i < ds.length; i++) {
                  sum += (ds[i]['quant']).toDouble();
                }
                String mnTxt = (sum * 127).toString();
                String cntText = sum.toString();
                return Column(
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
                    MedStatCard(
                      title: cntText,
                      subTitle: "boxes of medicine are donated",
                      iconImage: 'assets/images/med1.png',
                    ),
                    const SizedBox(height: 20),
                    MedStatCard(
                      title: "${mnTxt}\$",
                      subTitle: "we saved",
                      iconImage: 'assets/images/med2.png',
                    ),
                    const SizedBox(height: 20),
                    const MedStatCard(
                      title: "530,19",
                      subTitle: "people & ngo's have been helped",
                      iconImage: 'assets/images/med3.png',
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
