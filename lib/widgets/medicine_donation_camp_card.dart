// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MedicineDonationCampCard extends StatelessWidget {
  MedicineDonationCampCard({
    Key? key,
    required this.orgName,
    required this.address,
    required this.contactNumber,
    required this.description,
    this.onTab,
    this.color,
    this.status,
  }) : super(key: key);
  final String orgName;
  final String description;
  final String address;
  final String contactNumber;
  final Color? color;
  final String? status;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTab,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notifications_active,
                      size: 30,
                      color: Color(0xff8C52FF),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Medicines Donation Camp',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff8C52FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      "In Progress",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Organization Name:",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  orgName,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xff8C52FF),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  "Contact No:",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  contactNumber,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xff8C52FF),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Divider(
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 6),
                Text(
                  "Camp Description:",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xff8C52FF),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Divider(
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 30,
                      color: Color(0xff8C52FF),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      address,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
