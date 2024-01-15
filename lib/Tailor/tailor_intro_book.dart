import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class TailorBook extends StatefulWidget {
  const TailorBook({super.key});

  @override
  State<TailorBook> createState() => _TailorBookState();
}

class _TailorBookState extends State<TailorBook> {
  final bookIdEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   // automaticallyImplyLeading: false,
      //   backgroundColor: Colors.grey.shade300,
      //   leading: TextButton(
      //       onPressed: () {},
      //       child: const TextSized(
      //         text: "T-  ",
      //         fontSize: 20,
      //         textAlign: TextAlign.left,
      //         textColor: Colors.black,
      //       )),
      //   leadingWidth: 100,
      //   actions: [
      //     IconButton(
      //         onPressed: () => scaffoldKey.currentState?.openDrawer(),
      //         icon: const Icon(Icons.notifications))
      //   ],
      // ),
      // endDrawer: const Drawer(      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const TextSized(
                fontSize: 25, text: "You're now available in the marketplace"),
            const SizedBox(
              height: 80,
            ),
            Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(color: Theme.of(context).canvasColor),
                child: const Center(
                    child: TextSized(
                  text: "video here",
                  fontSize: 19,
                ))),
            const SizedBox(
              height: 20,
            ),
            const TextSized(fontSize: 18, text: "Set Your Book ID"),
            const TextSized(fontSize: 15, text: "You can also Change it Later"),
            myTextField(
                textEditingController: bookIdEditingController,
                label: 'B-XXXX',
                obscureTextBool: false,
                focus: true,
                keybordType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    print("Enter Book ID ");
                    myShowDialog(context, "Enter Book ID");
                    //set custom value
                  }
                  if (value.toString().contains(",") ||
                      value.toString().contains("-") ||
                      value.toString().contains(".")) {
                    print("Enter Numbers Only ");
                    myShowDialog(context, "Enter Numbers Only");
                    //set custom value
                  }
                  if (value.toString().contains(" ")) {
                    value = value.toString().replaceAll(" ", "");
                  }

                  return null;
                }),
            MyElevatedButtom(
              label: 'Complete',
              fontSize: 12,
              onPressed: () {
                if (verifyIfBookIdIsWritten()) {
                  var isOK = addToTailorBook(bookIdEditingController.text);

                  //navigator already written in addToTailorBook()

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const TailorBottomNavigation()));
                }
              },
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> myShowDialog(BuildContext context, title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title,
          );
        });
  }

  bool verifyIfBookIdIsWritten() {
    return bookIdEditingController.text.isNotEmpty;
  }

  void addToTailorBook(value) {
    firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_book_number")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "uid": firebaseAuth.currentUser!.uid,
      "book_id": value.toString(),
    }).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const TailorBottomNavigation()),
          (route) => false);
    });
  }
}
