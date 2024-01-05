import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final bool isNormal;

  Message(
      {required this.senderID,
      required this.senderEmail,
      required this.receiverId,
      required this.message,
      required this.timestamp, 
      required this.isNormal , 
      });

  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "message": message,
      "timestamp": timestamp,
      "isNormal" : isNormal
    };
  }
}
