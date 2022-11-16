// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class ViewProfileDetails extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const ViewProfileDetails({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _ViewProfileDetailsState createState() => _ViewProfileDetailsState();
}

class _ViewProfileDetailsState extends State<ViewProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 4.0), //(x,y)
                        blurRadius: 10.0,
                      ),
                    ]),
                width: double.maxFinite,
                height: 350,
                child: Stack(
                  children: [
                    Image.network(widget.documentSnapshot['cover_image'],
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        height: 350),
                    Row(
                      children: [
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                            ))
                      ],
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.documentSnapshot['med_name'],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8C52FF),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Medicine Quantity:",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(widget.documentSnapshot['quant'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff8C52FF),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Medicine Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Container(
                      child: Text(
                          widget.documentSnapshot['description'].toString(),
                          style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Donater Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text(widget.documentSnapshot['name'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Donater Contact",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text(widget.documentSnapshot['phone'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Pick Up Address",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text(widget.documentSnapshot['address'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(height: 12),
                    Text("Medicine Pictures",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        widget.documentSnapshot['details'].length,
                        (index) => Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            widget.documentSnapshot['details'][index]
                                .toString(),
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            height: 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Contact Me!',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff8C52FF)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Color(0xff8C52FF))))),
                          onPressed: () {
                            final number =
                                widget.documentSnapshot['phone'].toString();
                            launch('tel://$number');
                          }),
                    )
                  ],
                ))
          ])),
        ));
  }
}
