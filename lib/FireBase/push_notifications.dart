import 'package:firebase_messaging/firebase_messaging.dart';

// FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken =   _firebaseMessaging.getToken();

    print(fCMToken.then((String? value) {
      print("Token is $value");
    }));
    print('Token:  $fCMToken');
  }
}

  // void myOnBackgroundMessage(){
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }
  
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");

  // }

  //f2XFagqJQtGfLkyiaHXJHW:APA91bGwTSD16uQz0ScYbU8t32-Eh-Tb-ju9DJaEzekIy3ZnXP5r7drKuyGi43084yiyCq0cSWMIYRrdaKbzlLadan9xrT0Yxf8Lqor4dtUWOtB-GWTGESJTfU5DU-dwuS8axY8P62T9
 