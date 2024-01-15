// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
// import 'package:tailor_flutter/FireBase/firebase.dart';

// class TailorChatListPage extends StatelessWidget {
//   const TailorChatListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.grey.shade200,
//           child: _buildUserList(context)),
//     );
//   }

//   void func() {
//     firestore.collection("chat_rooms").get().then(
//       (querySnapshot) {
//         print("Successfully completed");
//         for (var docSnapshot in querySnapshot.docs) {
//           print('${docSnapshot.id} s=> ${docSnapshot.data()}');
//         }
//       },
//       onError: (e) => print("Error completing: $e"),
//     );
//   }

//   Widget _buildUserList(context) {
//     // print( "Snap shot${firestore.collection('users').snapshots}");
//     func();
//     return StreamBuilder<QuerySnapshot>(
//         stream: firestore.collection('chat_rooms').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text("No data");
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           print(" Here is chat room data 10 ${snapshot.data}");
//           return ListView(
//               children: snapshot.data!.docs
//                   .map<Widget>((doc) => _buildUserListItem(doc, context))
//                   .toList());
//         });
//   }
// }

// Widget _buildUserListItem(DocumentSnapshot documentSnapshot, context) {
//   Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
//   print(" Here is chat room data 1 ${documentSnapshot.data()}");
//   print(" Here is chat room data 2 $data");
//   print(" Here is chat room data 3 ${data['messages']}");
//   print("\n");

//   if (firebaseAuth.currentUser!.email != data['email']) {
//     return Column(
//       children: [
//         ListTile(
//           leading: CircleAvatar(
//             // backgroundImage: ,
//             // radius: 20,
//             child: Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   fit: BoxFit.cover, // Adjust this based on your needs
//                   image: NetworkImage(
//                       'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
//                 ),
//               ),
//             ),
//           ),
//           // title: Text(data['email']),
//           subtitle: const Text("Hi, how much is the cost?"),
//           trailing: const Text("9:11 pm"),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => IndividualPage(
//                         receiverName: data['email'], receiverID: data['uid'])));
//           },
//         ),
//         const Divider()
//       ],
//     );
//   } else {
//     // const Divider()
//     return Container();
//   }
// }

//       //    ListView.builder(
//       //   itemCount: 50,
//       //   itemBuilder: (context, snapshot) {
//       //     return GestureDetector(
//       //       onTap: (){

//       //         print("HERe");
//       //         // ignore: prefer_const_constructors
//       //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>    IndividualPage(name: name,)));
//       //       },
//       //       child: Padding(
//       //         padding: const EdgeInsets.all(2.0),
//       //         child: Column(
//       //           children: [
//       //             ListTile(
//       //               leading: CircleAvatar(
//       //                 // backgroundImage: ,
//       //                 // radius: 20,
//       //                 child: Container(
//       //                   decoration: const BoxDecoration(
//       //                     shape: BoxShape.circle,
//       //                     image: DecorationImage(
//       //                       fit: BoxFit
//       //                           .cover, // Adjust this based on your needs
//       //                       image: NetworkImage(
//       //                           'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //               // ignore: prefer_const_constructors
//       //               title:  Text(name),
//       //               subtitle: const Text("Hi, how much is the cost?"),
//       //               trailing: const Text("9:11 pm"),
//       //             ),
//       //             // SizedBox(
//       //             //   width: MediaQuery.of(context).size.width,
//       //             //   child: ,
//       //             // )
//       //             const Divider()
//       //           ],
//       //         ),
//       //       ),
//       //     );
//       //   },
//       // ),

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class TailorChatListPage extends StatelessWidget {
  const TailorChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).cardColor,
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('chat_rooms').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("No data");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  print(" Here is chat room data 10 ${snapshot.data}");

                  List<DocumentSnapshot> userChatRooms =
                      snapshot.data!.docs.where((doc) {
                    String chatRoomID = doc.id;
                    return chatRoomID.contains(firebaseAuth.currentUser!.uid);
                  }).toList();

                  return ListView(
                    children: userChatRooms
                        .map<Widget>((doc) => _buildUserListItem(doc, context))
                        .toList(),
                  );
                })));
  }
}

Future<void> navigateToIndividualPage(context, String otherUser) async {
  String? userName = await getOtherUserNameSnap(otherUser);

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => IndividualPage(
        receiverName: userName ?? "",
        receiverID: otherUser,
      ),
    ),
  );
}

Widget _buildUserListItem(DocumentSnapshot documentSnapshot, context) {
  String chatRoomId = documentSnapshot.id;
  print("FS $chatRoomId");
  if (chatRoomId.contains(firebaseAuth.currentUser!.uid)) {
    // final d = (!chatRoomId.split('_').contains(firebaseAuth.currentUser!.uid));
    final s = chatRoomId.split('_');
    var otherUser = '';
    // var otherUserEmail = '';

    print("${s[0]}, ${s[1]}");
    s[0].contains(firebaseAuth.currentUser!.uid)
        ? otherUser = s[1]
        : otherUser = s[0];

    print("This is other user $otherUser");
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;
    print("FS $data");

    print("What here ");

    return Column(
      children: [
        ListTile(
          onTap: () {
            navigateToIndividualPage(context, otherUser);
          }

          // Navigator.push(
          //     context,

          // MaterialPageRoute(
          //     builder: (context) => IndividualPage(
          //         receiverName:
          //          FutureBuilder<String>(
          //           future: getOtherUserNameSnap(otherUser),
          //           builder: ((context, snapshot) {
          //             print("Snapshot Name ${snapshot.data}");
          //             return Text("${snapshot.data}");
          //           }),
          //         ),
          //         receiverID: otherUser))

          ,
          leading: CircleAvatar(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                ),
              ),
            ),
          ),
          title: FutureBuilder<String>(
            future: getOtherUserNameSnap(otherUser),
            builder: ((context, snapshot) {
              print("Snapshot Name ${snapshot.data}");
              return TextSized(
                text: "${snapshot.data}",
                fontSize: 18,
              );
            }),
          ),
          subtitle: FutureBuilder(
            future: documentSnapshot.reference.collection('messages').get(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              print(
                  "Snap  Value[] ${documentSnapshot.reference.collection('messages').get()}");

              print(
                  "Message  --------> Name ${snapshot.data?.docs[0]['message'] ?? ''}");

              return TextSized(
                text: "${snapshot.data?.docs[0]['message']}",
                fontSize: 15,
              );
            }),
          ),
          trailing: SizedBox(
            width: 50,
            child: StreamBuilder(
              stream:
                  documentSnapshot.reference.collection('messages').snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                if (!snapshot.hasData) {}
                print(
                    "Time Snap  ----------: Value[] ${documentSnapshot.reference.collection('messages').get()}");

                print(
                    "Time Message  ----------: Name ${snapshot.data?.docs[0]['timestamp'] ?? ''}");
                var timestamp = snapshot.data?.docs[0]['timestamp'] ?? '';
                print("Time Latest  ----------: $timestamp");

                if (timestamp.toString().isNotEmpty) {
                  timeConvert(timestamp);
                }

                // var time = timestamp;
                // print("Time Latest  : $time");

                return timestamp.toString().isNotEmpty
                    ? TextSized(
                        text: timeConvert(timestamp),
                        fontSize: 12,
                      )
                    : Text("$timestamp");
              }),
            ),
          ),
        ),
        const Divider()
      ],
    );
  } else {
    return Container();
  }
}

String timeConvert(timestamp) {
  final int seconds =
      int.parse(timestamp.toString().substring(18, 28)); // 1621176915
  final int nanoseconds = int.parse(timestamp
      .toString()
      .substring(42, timestamp.toString().lastIndexOf(')'))); // 276147000
  final Timestamp postConverted = Timestamp(seconds, nanoseconds);

  print("Time pC----------:$postConverted");
  print("Time pC----------:${postConverted.toDate()}");
  int hour = postConverted.toDate().hour;
  String amPm = hour >= 12 ? 'pm' : 'am';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour;
  String formattedHour = hour.toString().padLeft(2, '0');

  String formatedDate =
      "$formattedHour:${postConverted.toDate().minute} ${postConverted.toDate().hour > 12 ? "pm" : "am"}";
  //  formatedDate = postConverted.toDate().toString().splitMapJoin(pattern);
  return formatedDate;
}
