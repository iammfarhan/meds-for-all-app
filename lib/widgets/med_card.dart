import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/view_details.dart';
import 'donation_card.dart';

Widget MedCard(medsStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: medsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        print('Something went Wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot documentSnap = snapshot.data!.docs[index];
          return (DonationCard(
            color: documentSnap['avail']==false ? Colors.red : Colors.green,
            medicineName: ' ${documentSnap['med_name'].toString()}',
            optionImage: documentSnap['cover_image'].toString(),
            medicineQuantity: 'Quantity: ${documentSnap['quant'].toString()}',
            onTab: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ViewProfileDetails(documentSnapshot: documentSnap)));
            },
          ));
        },
      );
    },
  );
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../pages/view_details.dart';

// Widget MedCard(medsStream) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: medsStream,
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         print('Something went Wrong');
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       return ListView.builder(
//         itemCount: snapshot.data!.docs.length,
//         itemBuilder: (context, index) {
//           final DocumentSnapshot documentSnap = snapshot.data!.docs[index];
//           return (
//             Card(
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             color: const Color(0xFFF5F5F5),
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   color: Colors.blue.shade100,
//                   child: Image.network(
//                     documentSnap['cover_image'].toString(),
//                     width: double.infinity,
//                     height: 120,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                     padding:
//                         const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Align(
//                           alignment: const AlignmentDirectional(0, -0.15),
//                           child: Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 0, 4, 0, 0),
//                             child: Text(
//                               documentSnap['med_name'].toString(),
//                               style: const TextStyle(
//                                 fontFamily: 'Poppins',
//                                 color: const Color(0xFF151B1E),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Align(
//                               alignment: const AlignmentDirectional(0.1, -0.05),
//                               child: Text(
//                                 'Quantity: ${documentSnap['quant'].toString()}',
//                                 textAlign: TextAlign.start,
//                                 style: const TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
//                   child: Text(
//                     documentSnap['description'].toString(),
//                     maxLines: 2,
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(fontSize: 13),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           FocusScope.of(context).unfocus();
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       ViewProfileDetails(
//                                           documentSnapshot: documentSnap)));
//                         },
//                         child: const Text("View Details",
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.black)),
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               const Color(0xffA7E92F)),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               side: const BorderSide(
//                                 color: Color(0xffA7E92F),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ));
//         },
//       );
//     },
//   );
// }
