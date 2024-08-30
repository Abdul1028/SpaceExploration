import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 40),
        child: GNav( // USING GOOGLE'S NAV BAR (check pubspec for library)
          activeColor: Colors.black,
          rippleColor: Colors.grey,
          hoverColor: const Color(0xFF9E86FF),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          gap: 6,
          iconSize: 22,
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: const Color(0x799E86FF),
          color: Colors.white,
          textStyle: const TextStyle(
              color: Color(0xFF9E86FF),
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            fontSize: 15
          ),
          tabs: const [ // all the pages and tabs we will be using
            GButton(
              icon: Icons.rocket_launch,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'Recents',
            ),
            GButton(
              icon: CupertinoIcons.chat_bubble_2,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'SpaceBot',
            ),
            GButton(
              icon: Icons.article_outlined,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'News',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: const Column(
        ),
      ),
    );
  }
}
