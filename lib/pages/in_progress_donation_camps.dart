import 'package:flutter/material.dart';
import 'package:medicine_donation_app/widgets/medicine_donation_camp_card.dart';
import 'package:medicine_donation_app/widgets/medicine_request_card.dart';

class InProgressDonationCamps extends StatefulWidget {
  const InProgressDonationCamps({Key? key}) : super(key: key);

  @override
  State<InProgressDonationCamps> createState() =>
      _InProgressDonationCampsState();
}

class _InProgressDonationCampsState extends State<InProgressDonationCamps> {
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    // Icon(
                    //   Icons.chevron_right,
                    //   size: 30,
                    //   color: Color(0xff8C52FF),
                    // ),
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
                MedicineDonationCampCard(
                    orgName: "JDC Foundation",
                    address: "House: 02 Street: 04 F8/3 Islamabad",
                    contactNumber: '03112347453',
                    description:
                        "We are collecting medicine donations in our camp for Balochistan flood affected people."),

                // Expanded(
                //   child: MedCard(medsStream),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
