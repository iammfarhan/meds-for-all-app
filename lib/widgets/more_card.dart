// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MoreCard extends StatelessWidget {
  const MoreCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTab,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 30,
                    color: Color(0xff8C52FF),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                size: 30,
                color: Color(0xff8C52FF),
              )
            ],
          ),
        ),
      ),
    );
  }
}
