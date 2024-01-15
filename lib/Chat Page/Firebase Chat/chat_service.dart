import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/Firebase%20Chat/message.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';

class ChatService extends ChangeNotifier {
  Future<void> sendMessage(String receiverID, String message, isNormal) async {
    final String currentUserID = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    // final  bool? isNormal ;

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: receiverID,
        message: message,
        timestamp: timestamp,
        isNormal: isNormal);
    List<String> ids = [currentUserID, receiverID]; //uid, receiverID
    ids.sort();
    String chatRoomID = ids.join("_");
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
    firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .set({"uid_chat": firebaseAuth.currentUser!.uid});
  }

  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID]; ////uid, receiverID
    ids.sort();
    String chatRoomID = ids.join("_");

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
