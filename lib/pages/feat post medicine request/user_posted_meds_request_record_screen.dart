// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_donation_app/pages/feat%20post%20medicine%20request/medicine_request_status.dart';
import '../../widgets/medicine_request_card.dart';

class UserPostedMedsRecordScreen extends StatefulWidget {
  UserPostedMedsRecordScreen({Key? key}) : super(key: key);
  final currentUser = FirebaseAuth.instance;

  @override
  State<UserPostedMedsRecordScreen> createState() =>
      _UserPostedMedsRecordScreenState();
}

class _UserPostedMedsRecordScreenState
    extends State<UserPostedMedsRecordScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('medsreq')
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
                'Request Medicine ',
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
                          "Medicine Requests you have done!",
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
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnap =
                                snapshot.data!.docs[index];
                            return (MedicineRequestCard(
                              color:
                                  documentSnap['avail'] == false
                                      ? Colors.red
                                      : Colors.green,
                              status: documentSnap['avail'] == false
                                  ? 'Done'
                                  : 'In Progress',
                              medicineName: documentSnap['medname'].toString(),
                              medicineQuantity:
                                  documentSnap['quant'].toString(),
                              address: documentSnap['address'].toString(),
                              userName: documentSnap['name'].toString(),
                              contactNumber: documentSnap['phone'].toString(),
                              onTab: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MedicineRequestStatus(
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
