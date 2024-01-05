import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard(
      {super.key,
      required this.text,
      required this.name,
      required this.timestamp,
      required this.isNormal,
      required this.uid});

  final String text;
  final String name;
  final Timestamp timestamp;
  final bool isNormal;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width/1.5,
        ),
        child: GestureDetector(
          onLongPress: () {
            _copyToClipboard(context, text);
          },
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // color: const Color(0xffdcf8c6),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 20),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 10,
                      child: Row(
                        children: [
                          Text(
                            "${timestamp.toDate().hour}:${timestamp.toDate().minute}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                isNormal
                    ? Container()
                    : Container(
                        child: TextButton(
                        onPressed: () async {
                          try {
                            // String uid = '';

                            var orderDocRef = firestore
                                .collection("users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("tailor_orders")
                                .doc(uid);

                            var orderDoc = await orderDocRef.get();

                            // Get the current book_id value before the update
                            var currentBookId = (await firestore
                                        .collection("users")
                                        .doc(firebaseAuth.currentUser!.uid)
                                        .collection("tailor_book_number")
                                        .doc(firebaseAuth.currentUser!.uid)
                                        .get())
                                    .data()?['book_id'] ??
                                0;

                            if (orderDoc.exists) {
                              // Document already exists, update the data without incrementing book_id
                              await orderDocRef.update({
                                "data": text,
                                "customer_uid": uid,
                              }, );
                            } else {
                              // Document doesn't exist, increment book_id and add the new order data
                              await orderDocRef.set({
                                "data": text,
                                "book_id": currentBookId + 1,
                                "customer_uid": uid,
                              }, SetOptions(merge: true));

                              // Increment book_id
                              await firestore
                                  .collection("users")
                                  .doc(firebaseAuth.currentUser!.uid)
                                  .collection("tailor_book_number")
                                  .doc(firebaseAuth.currentUser!.uid)
                                  .update({
                                'book_id': FieldValue.increment(1),
                              });
                            }

                            // You can add additional logic here if needed
                          } catch (error) {
                            print("Error updating order: $error");
                          }
                        },
                        child: const Text("Add to Order"),
                      )
                        // child: TextButton(
                        //   onPressed: () async{
                        //     //get cusotmer id

                        //     //increase book id
                        //     firestore
                        //         .collection("users")
                        //         .doc(firebaseAuth.currentUser!.uid)
                        //         .collection("tailor_orders")
                        //         .doc(uid)
                        //         .set({
                        //           "data" : text,
                        //           "book_id" : await incBookID(),
                        //           "customer_uid" : uid
                        //         });
                        //         // updateBookID();
                        //           // incBookID();
                        //     // send back book id
                        //   },
                        //   child: const Text("Add to Order"),
                        // ),
                        )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }
}
