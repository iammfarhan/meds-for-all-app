import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_donation_app/widgets/medicine_request_card.dart';

class InProgressRequest extends StatefulWidget {
  const InProgressRequest({Key? key}) : super(key: key);

  @override
  State<InProgressRequest> createState() => _InProgressRequestState();
}

class _InProgressRequestState extends State<InProgressRequest> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('medsreq')
      .where("avail", isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'Medicines Request List',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  height: 1.5,
                  color: Colors.grey.shade900,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: MedReqCard(medsStream),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget MedReqCard(medsStream) {
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

          return (MedicineRequestCard(
            color: documentSnap['avail'] == false ? Colors.red : Colors.green,
            status: documentSnap['avail'] == false ? 'Done' : 'In Progress',
            medicineName: documentSnap['medname'].toString(),
            medicineQuantity: documentSnap['quant'].toString(),
            address: documentSnap['address'].toString(),
            userName: documentSnap['name'].toString(),
            contactNumber: documentSnap['phone'].toString(),
          ));
        },
      );
    },
  );
}
