import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine_donation_app/pages/feat%20post%20meds%20donation%20camp/donation_camps_history.dart';
import 'package:medicine_donation_app/pages/feat%20post%20meds%20donation%20camp/in_progress_donation_camps.dart';

class MedicineDonationCampScreen extends StatefulWidget {
  const MedicineDonationCampScreen({Key? key}) : super(key: key);

  @override
  State<MedicineDonationCampScreen> createState() =>
      _MedicineDonationCampScreenState();
}

class _MedicineDonationCampScreenState
    extends State<MedicineDonationCampScreen> {
  int selectedTab = 0;

  Widget inProgressDonationCamp(BuildContext context) {
    return const InProgressDonationCamps();
  }

  Widget inProgressDonationCampHistory(BuildContext context) {
    return const DonationCampHistory();
  }

  late List<Widget> content;

  @override
  void initState() {
    content = [
      inProgressDonationCamp(context),
      inProgressDonationCampHistory(context),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE9E6E6),
        appBar: AppBar(
          title: const Text(
            "Donation Camps",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff8C52FF),
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: CupertinoSlidingSegmentedControl<int>(
                  children: const {
                    0: Text("In Progress"),
                    1: Text("Camps History"),
                  },
                  groupValue: selectedTab,
                  onValueChanged: (value) {
                    setState(
                      () {
                        selectedTab = value!;
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: content[selectedTab],
            ),
          ],
        ),
      ),
    );
  }
}
