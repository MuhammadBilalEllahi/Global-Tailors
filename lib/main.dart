import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_flutter/Choice/toggle_app_start.dart';
import 'package:tailor_flutter/Choice/lets_get_started_page.dart';
import 'package:tailor_flutter/Common/prefs.dart';
import 'package:tailor_flutter/FireBase/push_notifications.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/provider.dart';
import 'FireBase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await PreferenceManager.initializePrefs();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// await FirebaseAppCheck.instance.activate(
//   androidProvider: AndroidProvider.playIntegrity,
//     // webRecaptchaSiteKey: 'ADA04DFD-33A0-405E-9DC6-8702C84A23A0',
//   );

  await FirebaseApi().initNotifications();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
          // navigatorKey: navigatorKey,
          showPerformanceOverlay: false,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              canvasColor: Colors.black87,
              primaryColor: Colors.grey.shade700,
              primaryColorLight: Colors.white,
              splashColor: Colors.grey.shade700,
              primaryColorDark: Colors.white38,
              iconTheme: const IconThemeData(color: Colors.white),
              iconButtonTheme: const IconButtonThemeData(
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(Colors.white)))),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              canvasColor: Colors.black87,
              primaryColor: Colors.grey.shade700,
              primaryColorLight: Colors.white,
              splashColor: Colors.grey.shade700,
              primaryColorDark: Colors.white38,
              iconTheme: const IconThemeData(color: Colors.white),
              iconButtonTheme: const IconButtonThemeData(
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(Colors.white)))),
          home: const Start())));
}


// Teamviewer 98743hrjdbj




//only andriod
//shaered preference
//startup
// cms 
// api endpoints (can also be with firebase)
// custom theme 
// Backend(),
// backend controls 
// ads atleast 10
// Notifications(),
// Unique 
// firebase/ 












  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }

// void navigateToPageBasedOnNotification(RemoteMessage message) {

//   Map<String, dynamic> data = message.data;

//   print("Firebase notification Data is $data");

//   String notificationType = data['type']; 


//   if (notificationType == 'new_user') {
//      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const AuthPage()));
//   } else if (notificationType == 'went_away') {
//     navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const TailorBottomNavigation()));
//   }
// }




//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Received message: $message");
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print("Message opened: $message");
//     navigateToPageBasedOnNotification(message);
//   });

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);