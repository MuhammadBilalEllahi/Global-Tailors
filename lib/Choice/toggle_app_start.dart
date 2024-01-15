// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_flutter/Auth/LoginPage/login.dart';
import 'package:tailor_flutter/Auth/Registration%20Page/register.dart';
import 'package:tailor_flutter/Choice/lets_get_started_page.dart';
import 'package:tailor_flutter/Common/choosing_screen.dart';
import 'package:tailor_flutter/Common/prefs.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/sideba_menu.dart';
import 'package:tailor_flutter/Customer/measurement.dart';
import 'package:tailor_flutter/FireBase/Notification%20Services/notification_services.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/SplashScreen/splash_worker.dart';
import 'package:tailor_flutter/Tailor/otp.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_book.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';
import 'package:http/http.dart' as http;
import 'package:tailor_flutter/provider.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool showSplashPage = true;
  late Future<bool>? reviewStatus;

  // NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //TODO uncomment when noticcation services needed
    // notificationServices.requestNotificationPermission();
    // notificationServices.forgroundMessage();
    // notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();

    // notificationServices.getDeviceToken().then((value){
    //   if (kDebugMode) {
    //     print('device token');
    //     print("'device token' $value");
    //   }
    // });

    reviewStatus = fetchReviewStatus();
  }

  Future<bool> fetchReviewStatus() async {
    final response = await http
        .get(Uri.parse("https://tailor-api-seven.vercel.app/controller"));
    final Map<String, dynamic> data = json.decode(response.body);

    print("The data is $data");
    print("The data is ${data['in_review']}");

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("error bro");
      print(response.statusCode);
    }
    return data['in_review'];
    //suppose in_review2 if you want false bool , this will not go to auth page then
  }

  void togglePage() {
    setState(() {
      // print(showSplashPage);
      showSplashPage = !showSplashPage;

      // print(showSplashPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: reviewStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return const Text('Error fetching review status');
          }

          if (snapshot.data == true) {
            return SplashStarterPage(showAuthPage: togglePage);
          } else {
            bool isFirstTime =
                PreferenceManager.instance.getBool("isFirstTime") ?? true;

            if (showSplashPage) {
              return SplashStarterPage(showAuthPage: togglePage);
            }

            if (isFirstTime) {
              return const AuthPage();
            } else {
              if (firebaseAuth.currentUser == null) {
                return const LoginPage(type: "User");
              } else {
                getUserType().then((value) {
                  if (value == 'Tailor') {
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserType(value.toString());
                    Provider.of<UserProvider>(context, listen: false)
                        .setAuthId(firebaseAuth.currentUser!.uid);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const TailorBottomNavigation(),
                      ),
                      (route) => false,
                    );
                  } else if (value == "Customer") {
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserType(value.toString());
                    Provider.of<UserProvider>(context, listen: false)
                        .setAuthId(firebaseAuth.currentUser!.uid);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HiddenMenuDrawer(),
                      ),
                      (route) => false,
                    );
                  }
                });
              }
            }
            return Scaffold(
              body: Container(
                color: Theme.of(context).canvasColor.withOpacity(0.7),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "On The Right App",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sentiment_very_satisfied_sharp,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    )
                  ],
                )),
              ),
            );
          }
        });
    // );
    // if (showSplashPage) {
    //   // print(showSplashPage);

    //   return SplashStarterPage(showAuthPage: togglePage);
    // } else {
    //   func().then((value) {
    //     print("App access is $value");
    //     if (value == false) {
    //       showSplashPage = true;
    //       return ;
    //     }

    //   });
    //   bool isFirstTime =
    //       PreferenceManager.instance.getBool("isFirstTime") ?? true;

    //   return isFirstTime
    //       ? const AuthPage()
    //       : const LoginPage(type: "User"); // lets get started page

    //   // print(showSplashPage);

    //   // return const TailorBook(); // The book id

    //   // return const TailorBottomNavigation();  // tailor  main page

    //   // return const RegisterPage(type: "Tailor"); //tailor sign up

    //   // return const TailorStartPage(); //tailor page with shop info

    //   // return  const  SignInUpAs(); //signup page

    //   // return const LoginPage(type: 'User'); //user login page

    //   // return const MeasurementCustomer(); // mesaurement page customer

    //   // return OtpPhone(ph: TextEditingController()); //otp page with phone

    //   // return   const HiddenMenuDrawer(); //customer start page
    // }
  }
}
