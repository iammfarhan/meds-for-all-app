import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';


class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  final Function(int) onChange;

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          duration: Duration(milliseconds: 800),
          tabBackgroundColor: const Color(0xff8C52FF),
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Donate',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Stats',
            ),
            GButton(
              icon: LineIcons.pagelines,
              text: 'More',
            ),
             GButton(
              icon: LineIcons.lock,
              text: 'Logout',
            ),
          ],
          selectedIndex: 0,
          onTabChange: widget.onChange,
        ),
      ),
    );
  }
}
