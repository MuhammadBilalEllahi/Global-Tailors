import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:tailor_flutter/Choice/lets_get_started_page.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/customer_all_pages.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';

class HiddenMenuDrawer extends StatefulWidget {
  const HiddenMenuDrawer({super.key});

  @override
  State<HiddenMenuDrawer> createState() => _HiddenMenuDrawerState();
}

class _HiddenMenuDrawerState extends State<HiddenMenuDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final myBaseTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 0, 0, 0));

  final myActiveTextStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 0, 0, 0));

  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.grey.shade700,
              name: "Home",
              baseStyle: myBaseTextStyle,
              selectedStyle: myActiveTextStyle),
          const CustomerStartPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.grey.shade700,
              name: "Tailor",
              baseStyle: myBaseTextStyle,
              selectedStyle: myActiveTextStyle),
          const TailorBottomNavigation()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.grey.shade700,
              name: "Main Page",
              baseStyle: myBaseTextStyle,
              selectedStyle: myActiveTextStyle),
          const AuthPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.grey.shade700,
              name: "Signout",
              baseStyle: myBaseTextStyle,
              selectedStyle: myActiveTextStyle),
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: const Icon(Icons.logout)))
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.grey.shade300,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      // curveAnimation: Curves.bounceIn,
    );
  }
}
