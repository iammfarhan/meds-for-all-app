// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MedicineRequestStatus extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const MedicineRequestStatus({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _MedicineRequestStatusState createState() => _MedicineRequestStatusState();
}

class _MedicineRequestStatusState extends State<MedicineRequestStatus> {
  @override
  Widget build(BuildContext context) {
    var docId = widget.documentSnapshot.reference.id.toString();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff8C52FF),
            title: const Text(
              'Camp Status ',
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
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text("Change Med Request Status",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(
                    'Press this button if you have got the desired medicine which you have requested, Its time to make it unavailable from inprogress medicine request list',
                    maxLines: 5,
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 12),
                widget.documentSnapshot['avail'] == true
                    ? Container(
                        width: double.maxFinite,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff8C52FF)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Color(0xff8C52FF))))),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('medsreq')
                                  .doc(docId)
                                  .update({'avail': false});
                            },
                            child: const Text(
                              'Press!',
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    : Center(
                        child: Text(
                          'Thank you for updating medicine request status!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xff8C52FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ],
            )),
          )),
    );
  }
}
