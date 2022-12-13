// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_donation_app/pages/feat%20post%20meds%20donation%20camp/camp_status_screen.dart';
import '../../widgets/medicine_donation_camp_card.dart';

class UserPostedDonationCampScreen extends StatefulWidget {
  UserPostedDonationCampScreen({Key? key}) : super(key: key);
  final currentUser = FirebaseAuth.instance;

  @override
  State<UserPostedDonationCampScreen> createState() =>
      _UserPostedDonationCampScreenState();
}

class _UserPostedDonationCampScreenState
    extends State<UserPostedDonationCampScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('medcamp')
          .where("userid", isEqualTo: currentUser.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
                'Donation Camps ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              elevation: 4,
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
            ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Medicine donation camps events you posted!",
                          textAlign: TextAlign.center,
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
                          "Thank you for sharing of it!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnap =
                                snapshot.data!.docs[index];
                            return (MedicineDonationCampCard(
                              orgName: documentSnap['name'].toString(),
                              address: documentSnap['address'].toString(),
                              contactNumber: documentSnap['phone'].toString(),
                              description: documentSnap['desc'].toString(),
                              onTab: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CampStatus(
                                            documentSnapshot: documentSnap),
                                  ),
                                );
                              },
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
