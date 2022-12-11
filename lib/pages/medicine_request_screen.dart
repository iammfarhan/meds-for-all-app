// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'in_progress_request.dart';

class MedicineRequestScreen extends StatefulWidget {
  const MedicineRequestScreen({Key? key}) : super(key: key);

  @override
  State<MedicineRequestScreen> createState() => _MedicineRequestScreenState();
}

class _MedicineRequestScreenState extends State<MedicineRequestScreen> {
  int selectedTab = 0;

  Widget inProgressRequest(BuildContext context) {
    return InProgressRequest();
  }

  Widget inProgressRequestHistory(BuildContext context) {
    return InProgressRequest();
  }

  late List<Widget> content;

  @override
  void initState() {
    content = [
      inProgressRequest(context),
      inProgressRequestHistory(context),
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
            "Requests",
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
                  children: {
                    0: const Text("In Progress"),
                    1: const Text("Requests History"),
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
