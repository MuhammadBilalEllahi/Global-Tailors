import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_flutter/Auth/LoginPage/login.dart';
import 'package:tailor_flutter/Choice/lets_get_started_page.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

Future signup(emailEditingController, passwordEditingController, type) async {
  try {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: emailEditingController, password: passwordEditingController);
    //  print(firestore.collection("Users").doc("HRM33G4lup9mtHVDJRR3").get(
    //  ).toString());
    firebaseAuth.currentUser!.updateEmail(emailEditingController);
    // firebaseAuth.currentUser.sendEmailVerification()
    setUserDetails(userCredential, type);
  } catch (e) {
    print(e.toString());
  }
}

void setUserDetails(UserCredential userCredential, String type) {
  try {
    firestore
        // .collection(type)
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(
      {
        'type': type,
        'email': userCredential.user!.email,
        'uid': firebaseAuth.currentUser!.uid,
      },
    );
  } catch (e) {
    print('Error updating document: $e');
  }
}

// getUserDetails(userCredential, _textEditingController.text);
Future signin(textEditingController, passwordEditingController, context) async {
  print(textEditingController.text);
  print(passwordEditingController.text);

  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      });

  final userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: textEditingController.text.trim(),
    password: passwordEditingController.text.trim(),
  )
      .onError((error, stackTrace) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Credentials'),
          content:
              const Text('The email or password you entered is incorrect.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    throw Exception(error);
  });

  // Navigator.of(context).pop();
  print('Sign-in successful for ${userCredential.user!.email}');
}

Future<void> signout(context) async {
  firebaseAuth.signOut().then((value) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage(type: "User")),
        (route) => false);
  });
}

Future<String?> getBookIDSnap() async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_book_number")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var firstDocument = querySnapshot.docs.first;
      Map<String, dynamic> data = firstDocument.data();
      print(firstDocument.reference);
      print(firstDocument.reference.id);
      print(data);
      print(data['book_id']);

      return data['book_id'];
    } else {
      // Handle the case where no documents are found
      return 'No Book ID';
    }
  } catch (e) {
    // Handle any errors that occurred during the process
    print("Error: $e");
    return null;
  }
}

Future<String?> getPhoneNumberTailorSnap() async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_info")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var firstDocument = querySnapshot.docs.first;
      Map<String, dynamic> data = firstDocument.data();
      print(firstDocument.reference);
      print(firstDocument.reference.id);
      print(data);
      print(data['tailor_phone_number']);

      return data['tailor_phone_number'];
    } else {
      // Handle the case where no documents are found
      return 'No Phone ID';
    }
  } catch (e) {
    // Handle any errors that occurred during the process
    print("Error: $e");
    return null;
  }
}

Future<String?> getTailorIDSnap() async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("ID")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var firstDocument = querySnapshot.docs.first;
      Map<String, dynamic> data = firstDocument.data();
      print(firstDocument.reference);
      print(firstDocument.reference.id);
      print(data);
      print(data['ID']);

      return data['ID'].toString();
    } else {
      // Handle the case where no documents are found
      return 'No Tailor ID';
    }
  } catch (e) {
    // Handle any errors that occurred during the process
    print("Error: $e");
    return null;
  }
}

Future<String> getOtherUserNameSnap(otherUser) async {
  Completer completer = Completer();
  print("Testing");
  var querySnapshot =
      FirebaseFirestore.instance.collection("users").doc(otherUser).get();

  querySnapshot.then((value) {
    // value.data()
    // var firstDoc = value..docs.first;
    Map<String, dynamic> data = value.data()!;
    print("Other Uer Name is $data");
    data['email'];
    completer.complete(data['email']);
    print("Other Uer Name is ${data['email']}");
  });

  var data = await completer.future;
  print("Completer Info $data");
  return data;
}

String getOtherUserNameSnapIndividual(otherUser) {
  String datax = '';
  print("Testing");
  var querySnapshot =
      FirebaseFirestore.instance.collection("users").doc(otherUser).get();

  querySnapshot.then((value) {
    // value.data()
    // var firstDoc = value..docs.first;
    Map<String, dynamic> data = value.data()!;
    print("Other Uer Name is $data");
    data['email'];
    datax = data['email'];

    print("Other Uer Name is ${data['email']}");
  });
  return datax;
}

/*  ?? not using rn

void updateBookID() async {
  var querySnapshot = await firestore
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .collection("tailor_book_number")
      // .doc(firebaseAuth.currentUser!.uid)
      // .collection("book_id")
      .get().then((snapshot) => snapshot.docs.forEach((element) {

          Map<String, dynamic> data = element.data() ;
           print(element.reference);
          print(element.reference.id);
          print(data);
          print(data['book_id']);

        //  element= data['book_id'];

          return data['book_id'];
      }));
}


void customerBook(receiver_uid){
  firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_book_number")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("customer_book")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
              "" : ""
        });
}

Future<int> incBookID() async {
  try {
    
    var userDocRef = firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_book_number")
        .doc(firebaseAuth.currentUser!.uid);

    // Get the current book_id value before the update
    var currentBookId = (await userDocRef.get()).data()?['book_id'] ?? 0;

    // Update the book_id with an increment
    await userDocRef.update({
      'book_id': FieldValue.increment(1),
    });

    // Return the updated book_id value
    return currentBookId + 1;
  } catch (error) {
    print("Error incrementing book ID: $error");
    return 0; // Return a default value or handle the error accordingly
  }
}
*/

void getTailorInArea(String area) {
  //
  Stream<QuerySnapshot> data = firestore
      .collection('users')
      .where('type', isEqualTo: "Tailor")
      .snapshots();

  print("Data is >> $data");
  data.listen((QuerySnapshot querySnapshot) {
    print("Data is >> $querySnapshot");
    for (var docs in querySnapshot.docs) {
      print("All tailor determined uid ${docs.reference.id}");
      firestore
          .collection('users')
          .doc(docs.id)
          .collection('tailor_info')
          .get()
          .then((tailorInfoSnapshot) {
        print("current determined uid ${docs.reference.id}");
        var tailorInfoDoc = tailorInfoSnapshot.docs.first;
        print("Tailor Location: ${tailorInfoDoc['tailor_location']}");
        print("\n");

        var filteredTailorInfoDocs = tailorInfoSnapshot.docs
            .where((doc) => doc['tailor_location'] == area);

        for (var tailorInfoDoc in filteredTailorInfoDocs) {
          print(
              ">Filtered Tailor Location: ${tailorInfoDoc['tailor_location']} uid ${tailorInfoDoc.id}");
        }
      });
    }
  });
}

Future<String?> getUserType() async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    // print(
    //     ".................................................................................................> < $querySnapshot");

    if (querySnapshot.exists) {
      var userData = querySnapshot.data();
      print("User Data: (uid, sigin) > $userData");

      if (userData != null && userData.containsKey('type')) {
        String userType = userData['type'];
        print("User Type: $userType");
        return userType;
      } else {
        print("No 'type' field found in user data");
        return 'No type';
      }
    } else {
      // Handle the case where the user document doesn't exist
      print("User document not found");
      return 'No type';
    }
  } catch (e) {
    // Handle any errors that occurred during the process
    print("Error: $e");
    return "bnbnb";
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // print("---------------------f-----------${googleUser!.email}");

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

// print("--------------------------------${googleAuth.accessToken}");
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // print("--------------------------------$credential");

  // Once signed in, return the UserCredential
  UserCredential signed =
      await FirebaseAuth.instance.signInWithCredential(credential);

  return signed;
}

// }import 'dart:async';
Future<List<Map<String, dynamic>>> getTailorInArea2(String area) async {
  print("objectINNN");

  // Use Completer to wait for the asynchronous operation to complete
  Completer<List<Map<String, dynamic>>> completer = Completer();
  List<Map<String, dynamic>> resultList = [];

  StreamSubscription<QuerySnapshot> subscription = firestore
      .collection('users')
      .where('type', isEqualTo: "Tailor")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) async {
    print("Data is >> $querySnapshot");
    for (var docs in querySnapshot.docs) {
      print("All tailor determined uid ${docs.reference.id}");
      var tailorInfoSnapshot = await firestore
          .collection('users')
          .doc(docs.id)
          .collection('tailor_info')
          .get();

      var tailorIDSnapshot = await firestore
          .collection('users')
          .doc(docs.id)
          .collection('ID')
          .get();

      print("current determined uid ${docs.reference.id}");
      var tailorInfoDoc = tailorInfoSnapshot.docs.first;
      print("Tailor Location: ${tailorInfoDoc['tailor_location']}");
      print("\n");

      var filteredTailorInfoDocs = tailorInfoSnapshot.docs
          .where((doc) => doc['tailor_location'] == area);

      for (var tailorInfoDoc in filteredTailorInfoDocs) {
        print(
            ">Filtered Tailor Location: ${tailorInfoDoc['tailor_location']} uid ${tailorInfoDoc.id}");

        var tailorIDDoc = tailorIDSnapshot.docs.firstWhere(
          (idDoc) => idDoc.id == tailorInfoDoc.id,
        );
        // Add the data to the list
        resultList.add({
          'location': tailorInfoDoc['tailor_location'],
          'shop_name': tailorInfoDoc['tailor_shop_name'],
          'name': tailorInfoDoc['tailor_name'],
          'uid': docs.reference.id,
          't_id': tailorIDDoc['ID'].toString()
        });
      }
    }

    // Resolve the Completer with the list of results
    completer.complete(resultList);
  });

  // Use await to wait for the Future to complete
  List<Map<String, dynamic>> result = await completer.future;
  print("Data > $result");

  // Cancel the subscription to avoid memory leaks
  subscription.cancel();

  // Return the result
  return result;
}

// Future<String?> getUserType() async {
//   try {
//     var querySnapshot = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .get();
//       print("Snaps >>>>>>>>>>>> $querySnapshot");

//     if (querySnapshot.exists) {
//        Map<String, dynamic> data = querySnapshot.data()!;
//        print("data >>>>>>>>>>>> $data");
//       // Map<String, dynamic> data = firstDocument.data();

//       print("Snaps >>>>>>>>>>>> ${data.entries}");
//       print(data.entries.where((element) => false));

//       print("Snaps >>>>>>>>>>>> $data");

// print("Snaps >>>>>>>>>>>> ${data['type']}");
//       return data['type'];
//     } else {
//       // Handle the case where no documents are found
//       return 'No type';
//     }
//   } catch (e) {
//     // Handle any errors that occurred during the process
//     print("Error: $e");
//     return null;
//   }
// }

// Widget _buildUserList(DocumentSnapshot documentSnapshot){
//   return StreamBuilder<QuerySnapshot>(stream: firestore.collection('users').snapshots(),
//    builder: (context,snapshot){
//     if(snapshot.hasError){
//       return const Text("No data");
//     }
//     if(snapshot.connectionState == ConnectionState.waiting){
//       return const CircularProgressIndicator();
//     }
//     return ListView(
//         children:
//           snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList()

//     );
//   });
// }

// Widget _buildUserListItem(DocumentSnapshot documentSnapshot){
//   Map<String,dynamic> data = documentSnapshot.data()! as Map<String,dynamic> ;

//   if(firebaseAuth.currentUser!.email != data['email']){
//     return ListTile(
//       title: data['email'],
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatListPage()));
//       },
//     );
//   }
//   else {
//     throw Exception();
//   }
// }



// void getAllMeasurements() {
//   Map<String,dynamic> res ={} ;

//  var data=  firestore
//       .collection('users')
//       .doc(firebaseAuth.currentUser!.uid)
//       .collection("measurements").get();

  
//       data.then((value) {
//         res = value.docs.first.data();
//         print("Data inside > $res");
//         // print(value.docs.first.data());
//       });
//     // print();
//     print("Data outside > $res");
    
// }


// void getAllMeasurements2()  async{

//     Map<String,dynamic> res ={} ;

//  var data=  await firestore
//       .collection('users')
//       .doc(firebaseAuth.currentUser!.uid)
//       .collection("measurements")
//       .get();

//     //   data.then((value) {
//     //     res = value.docs.first.data();
//     //     print("Data inside > $res");
//     //     // print(value.docs.first.data());

//     //     neckEditingController = res.first where neck 
//     //   });
//     // // print();
//     // print("Data outside > $res");
// }


// void updateBookID()  async {
//     var querySnapshot =   await firestore
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection("tailor_book_number").
//         doc(firebaseAuth.currentUser!.uid). 
//         collection("book_id")
//         .get();
//         print("here");

//   // querySnapshot.then((value) {
//   //   print(value.docChanges);
//   // });
//   // querySnapshot.then((value) {
//   //   var v = value.docs.first;
//   //   print(v.id);
//   // });

//    for (var doc in querySnapshot.docChanges) {
//     print("Book ID: ${doc.doc}, Data: ${doc.doc.data()}");
//   }

// }








//  Future<String?> getTailorIDSnap() async {

//   await FirebaseFirestore.instance
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection("tailor_book_number")

//         .get().then((snapshot) => snapshot.docs.forEach((element) {

//           Map<String, dynamic> data = element.data() ;
//            print(element.reference);
//           print(element.reference.id);
//           print(data);
//           print(data['book_id']);

//          element= data['book_id'];

//           return data['book_id'];

//         }));

// }
// void incBookID() async {
//   try {
//     var userDocRef = firestore
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection("tailor_book_number")
//         .doc(firebaseAuth.currentUser!.uid);

//     await userDocRef.update({
//       'book_id': FieldValue.increment(1),
//     });

//     print("Book ID incremented successfully");
//   } catch (error) {
//     print("Error incrementing book ID: $error");
//   }
// }