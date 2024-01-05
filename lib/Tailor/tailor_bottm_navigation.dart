
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/all_chats_tailor.dart';
import 'package:tailor_flutter/Tailor/tailor_create_post.dart';
import 'package:tailor_flutter/Tailor/tailor_init.dart';
import 'package:tailor_flutter/Tailor/tailor_notifications.dart';
import 'package:tailor_flutter/Tailor/tailor_post_screen.dart';
import 'package:tailor_flutter/Tailor/tailor_previous_orders.dart';
import 'package:tailor_flutter/Tailor/tailor_settings.dart';

class TailorBottomNavigation extends StatefulWidget {
  const TailorBottomNavigation({super.key});

  @override
  State<TailorBottomNavigation> createState() => _TailorBottomNavigationState();
}

class _TailorBottomNavigationState extends State<TailorBottomNavigation> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 1;
  List<Widget> pages = [
    const PreviousOrders(),
    const TailorHome(),
    Container(),
    const ChatListPage(),
    const ProfileSettings(),
    // const Settings(),
  ];
  String tailorId = ""; // Variable to hold the tailor ID

  @override
  void initState() {
    getTailorIDSnap();
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        _showCreatePostBottomSheet(context);
      } else {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 236, 236),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: TextButton(
            onPressed: () {},
            child:
             FutureBuilder<String?>(
              future: getTailorIDSnap(),
              builder: (content, snapshot) {
                print("Tailor ID (lib/Tailor/tailor_bottm_navigation.dart) : > ${snapshot.data}");
                return TextSized(
                  text: "T-${snapshot.data.toString()}" ,
                  fontSize: 20,
                  textAlign: TextAlign.left,
                  textColor: Colors.black,
                );
              },
            )
            ),
        // leadingWidth: 0,
        centerTitle: true,

        actions: [
          TextButton(
              onPressed: () {
                // getTailorIDSnap();
                getTailorInArea("India");
              },
              child: const Text("T")),
          IconButton(
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      endDrawer:  const Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 90),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextSized(
                fontSize: 30,
                text: 'Notifications',
                textAlign: TextAlign.left,
              ),
              Notifications(),
            ],
          ),
        ),
      ),
      drawer: const Drawer(),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade300,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black87,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.local_activity_outlined,
                )),
            BottomNavigationBarItem(
                label: '', icon: Icon(Icons.access_time_sharp)),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.control_point_duplicate_sharp),
            ),
            BottomNavigationBarItem(label: '', icon: Icon(Icons.chat)),
            BottomNavigationBarItem(
                label: '', icon: Icon(Icons.short_text_rounded)),
          ]),
    );
  }
}

void _showCreatePostBottomSheet(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.5,
        minChildSize: 0.2,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            // height: MediaQuery.of(context).size.height -40,
            // width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: const SingleChildScrollView(
              // controller: scrollController,
              child: CreatePost(),
            ),
          );
        },
      );
    },
  );
}
