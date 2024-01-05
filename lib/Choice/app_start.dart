// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Auth/LoginPage/login.dart';
import 'package:tailor_flutter/Auth/Registration%20Page/register.dart';
import 'package:tailor_flutter/Choice/auth_page.dart';
import 'package:tailor_flutter/Common/choosing_screen.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/sideba_menu.dart';
import 'package:tailor_flutter/Customer/measurement.dart';
import 'package:tailor_flutter/FireBase/Notification%20Services/notification_services.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/SplashScreen/splash_worker.dart';
import 'package:tailor_flutter/Tailor/otp.dart';
import 'package:tailor_flutter/Tailor/tailor_book.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/Tailor/tailor_init.dart';
class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}


class _StartState extends State<Start> {
  bool showSplashPage = true;
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
    if(showSplashPage){
          // print(showSplashPage);

      return SplashStarterPage(showAuthPage: togglePage);
    }
    else{
      
      // print(showSplashPage);

      // return const TailorBook(); // The book id

      // return const TailorBottomNavigation();  // tailor  main page

      return  const AuthPage();  // lets get started page

      // return const RegisterPage(type: "Tailor"); //tailor sign up
      
      // return const TailorStartPage(); //tailor page with shop info
      
      // return  const  SignInUpAs(); //signup page

      // return const LoginPage(type: 'User'); //user login page

      // return const MeasurementCustomer(); // mesaurement page customer

      // return OtpPhone(ph: TextEditingController()); //otp page with phone
      
      // return   const HiddenMenuDrawer(); //customer start page
    }
  }
}