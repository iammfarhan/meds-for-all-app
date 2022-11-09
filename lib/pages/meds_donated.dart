import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_donation_app/pages/view_details.dart';

class Medsdonated extends StatefulWidget {
   Medsdonated({Key? key}) : super(key: key);
  final currentUser = FirebaseAuth.instance;

  @override
  State<Medsdonated> createState() => _MedsdonatedState();
}

class _MedsdonatedState extends State<Medsdonated> {
 

  void onChangeNavigation(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/addService');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/size');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/details');
    } else if (index == 4) {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('meds').where("userid",isEqualTo: currentUser.currentUser!.uid ).snapshots(),
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
                              textCapitalization: TextCapitalization.sentences,
        
                              onChanged: (string) {
                                setState(() {});
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
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnap =
                                snapshot.data!.docs[index];
                            return (Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: const Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.blue.shade100,
                                    child: Image.network(
                                      documentSnap['cover_image'].toString(),
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: const AlignmentDirectional(
                                                0, -0.15),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                documentSnap['med_name']
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: const Color(0xFF151B1E),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.1, -0.05),
                                                child: Text(
                                                  'Quantity: ${documentSnap['quant'].toString()}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: Text(
                                      documentSnap['description'].toString(),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ViewProfileDetails(
                                                              documentSnapshot:
                                                                  documentSnap)));
                                            },
                                            child: Text("View Details",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black)),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Color(0xffA7E92F)),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xffA7E92F))))))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              onTap: onChangeNavigation,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_add),
                  label: 'Store Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.boy_rounded),
                  label: 'Sizes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined),
                  label: 'Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Logout',
                ),
              ],
              selectedItemColor: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
