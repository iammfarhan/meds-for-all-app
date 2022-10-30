import 'package:flutter/material.dart';

class MedStatCard extends StatefulWidget {
  const MedStatCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.iconImage,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String iconImage;

  @override
  State<MedStatCard> createState() => _MedStatCardState();
}

class _MedStatCardState extends State<MedStatCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          widget.iconImage,
          height: 70,
          width: 70,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff8C52FF),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.subTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}
