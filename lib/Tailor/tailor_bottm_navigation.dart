import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/all_chats_tailor.dart';
import 'package:tailor_flutter/Tailor/tailor_create_post.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';
import 'package:tailor_flutter/Tailor/tailor_notifications.dart';
import 'package:tailor_flutter/Tailor/tailor_post_screen.dart';
import 'package:tailor_flutter/Tailor/tailor_previous_orders.dart';
import 'package:tailor_flutter/Common/profile_settings.dart';
import 'package:tailor_flutter/provider.dart';

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
    const TailorChatListPage(),
    const ProfileSettings(),
  ];
  String tailorId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTailorIDSnap().then((value) {
      Provider.of<UserProvider>(context, listen: false).tailorID(value!);
    });
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
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: TextButton(
            onPressed: () {},
            child: FutureBuilder<String?>(
              future: getTailorIDSnap(),
              builder: (content, snapshot) {
                print(
                    "Tailor ID (lib/Tailor/tailor_bottm_navigation.dart) :  ${snapshot.data}");
                Provider.of<UserProvider>(context, listen: false)
                    .tailorID("T-${snapshot.data.toString()}");
                return TextSized(
                  text: "T-${snapshot.data.toString()}",
                  fontSize: 20,
                  textAlign: TextAlign.left,
                  textColor: Theme.of(context).primaryColorLight,
                );
              },
            )),
        // leadingWidth: 0,
        centerTitle: true,

        actions: [
          // TextButton(
          //     onPressed: () {
          //       // getTailorIDSnap();
          //       // getTailorInArea("India");
          //       // getOtherUserNameSnap();
          //     },
          //     child: const Text("T")),
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
      endDrawer: const Drawer(
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
          elevation: 2,
          selectedIconTheme: const IconThemeData(weight: 40, size: 28),
          unselectedIconTheme: const IconThemeData(weight: 1, size: 22),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).canvasColor,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Theme.of(context).primaryColorLight,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  // color: Theme.of(context).iconTheme.color,
                  Icons.access_time_outlined,
                )),
            BottomNavigationBarItem(label: '', icon: Icon(
                // color: Theme.of(context).iconTheme.color,
                Icons.home_filled)),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                  // color: Theme.of(context).iconTheme.color,
                  Icons.add_circle_outline),
            ),
            BottomNavigationBarItem(label: '', icon: Icon(
                // color: Theme.of(context).iconTheme.color,
                Icons.chat)),
            BottomNavigationBarItem(label: '', icon: Icon(
                // color: Theme.of(context).iconTheme.color,
                Icons.person)),
          ]),
    );
  }

  void _showCreatePostBottomSheet(BuildContext context) {
    // double height = 0.5;
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          minChildSize: 0.2,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              // height: MediaQuery.of(context).size.height -40,
              // width: MediaQuery.of(context).size.width,
              color: Theme.of(context).splashColor,
              child: SingleChildScrollView(
                // controller: scrollController,
                child: CreatePost(
                  onTap: () {
                    // setState(() {
                    //   height = 2000;
                    // });
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
