import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Row(children: [
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        direction: Axis.horizontal,
                        rating: 4.0,
                        unratedColor: Colors.grey.shade300,
                        itemCount: 5,
                        itemSize: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("(${widget.documentSnapshot['quant']})",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700))
                    ]),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Container(
                      child: Text(
                          widget.documentSnapshot['description'].toString(),
                          style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Services Names",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Text(widget.documentSnapshot['name'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Brand Contact",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Text(widget.documentSnapshot['address'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 3,
                    ),
                    Text(widget.documentSnapshot['phone'].toString(),
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 25),
                    Text("Portfolio",
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
                        (index) => new Container(
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
                      child: ElevatedButton(
                          child: const Text('Write a Review'),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(10)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.blue)))),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    height: 400,
                                    color: Colors.white,
                                    child: Center(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 30, 20, 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                              'Please provide your opinion about the Brand',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          TextField(
                                            style: TextStyle(fontSize: 14),
                                            minLines: 5,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            width: 2)),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        0, 15, 15, 3),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2)),
                                                hintText: 'Write your review',
                                                labelText: ""),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Container(
                                              width: double.maxFinite,
                                              child: ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text(
                                                      'Submit Review'),
                                                  style: ButtonStyle(
                                                      padding: MaterialStateProperty.all<
                                                              EdgeInsets>(
                                                          EdgeInsets.all(10)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              Colors.blue),
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(30.0),
                                                              side: BorderSide(color: Colors.blue)))))),
                                        ],
                                      ),
                                    )),
                                  ),
                                );
                              },
                            );
                          }),
                    )
                  ],
                ))
          ])),
        ));
  }
}
