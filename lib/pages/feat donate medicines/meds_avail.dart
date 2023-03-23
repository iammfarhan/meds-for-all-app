import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ViewProfileDetail extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const ViewProfileDetail({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _ViewProfileDetailState createState() => _ViewProfileDetailState();
}

class _ViewProfileDetailState extends State<ViewProfileDetail> {
  @override
  Widget build(BuildContext context) {
    var docId = widget.documentSnapshot.reference.id.toString();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 4, right: 4),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
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
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                ))
                          ],
                        )
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.documentSnapshot['med_name'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8C52FF),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Medicine Quantity:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.documentSnapshot['quant'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xff8C52FF),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Medicine Description",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Container(
                        child: Text(
                            widget.documentSnapshot['description'].toString(),
                            style: const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Donater Name",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text(widget.documentSnapshot['name'].toString(),
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Donater Contact",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Text(widget.documentSnapshot['phone'].toString(),
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Pick Up Address",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Text(widget.documentSnapshot['address'].toString(),
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 12),
                      const Text("Medicine Pictures",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
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
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              widget.documentSnapshot['details'][index]
                                  .toString(),
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text("Set Medicine Availabilty",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      const Text(
                          'Press this button if this medicine is taken someone from you, Its time to make it unavailable from available meds list',
                          maxLines: 5,
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 12),
                      widget.documentSnapshot['avail'] == true
                          ? Container(
                              width: double.maxFinite,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(10)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xff8C52FF)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: const BorderSide(
                                                color: Color(0xff8C52FF))))),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('meds')
                                      .doc(docId)
                                      .update({'avail': false});
                                },
                                child: const Text(
                                  'Press!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          : const Text(
                              'Thank you for donating!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff8C52FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
