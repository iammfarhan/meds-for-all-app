import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/feat donate medicines/view_details.dart';
import 'donation_card.dart';

Widget MedCard(medsStream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: medsStream,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasError) {
        print('Something went Wrong');
      }
      if (snapshot.data == null) {
        print('yo');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot documentSnap = snapshot.data!.docs[index];

          return (DonationCard(
            status:
                documentSnap['avail'] == false ? 'Not Available' : 'Available',
            color: documentSnap['avail'] == false ? Colors.red : Colors.green,
            medicineName: '${documentSnap['med_name'].toString()}',
            optionImage: documentSnap['cover_image'].toString(),
            medicineQuantity: 'Quantity: ${documentSnap['quant'].toString()}',
            onTab: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ViewProfileDetails(documentSnapshot: documentSnap),
                ),
              );
            },
          ));
        },
      );
    },
  );
}


