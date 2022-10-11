import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:medicine_donation_app/pages/view_meds_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> medsStream =
      FirebaseFirestore.instance.collection('meds').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: medsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Scaffold(
            backgroundColor: const Color(0xFFE6E6E6),
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
                      Expanded(
                          child: ListView.builder(
                              itemCount: storedocs.length,
                              itemBuilder: (context, index) {
                                final Index = storedocs[index];
                                return (Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
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
                                            storedocs[index]['cover_image']
                                                .toString(),
                                            width: double.infinity,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -0.15),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 0, 0),
                                                    child: Text(
                                                      storedocs[index]
                                                              ['med_name']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF151B1E),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.1, -0.05),
                                                      child: Text(
                                                        storedocs[index]
                                                                ['med_name']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 10, 10, 10),
                                          child: Text(
                                            storedocs[index]['description']
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  ViewMedDetails(
                                                                      /*indexxxx*/)));
                                                    },
                                                    child: Text("View Details",
                                                        style: TextStyle(
                                                            fontSize: 12)),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty.all<
                                                                    Color>(
                                                                Colors.blue),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        18.0),
                                                                side: BorderSide(
                                                                    color:
                                                                        Colors.blue)))))
                                              ],
                                            ))
                                      ],
                                    )));
                              }))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
