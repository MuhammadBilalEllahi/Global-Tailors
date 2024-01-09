import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Auth/LoginPage/login.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/sideba_menu.dart';
import 'package:tailor_flutter/Tailor/tailor_complete_info.dart';

class RegisterPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static int ID_NUMBER = -1;

  const RegisterPage({
    super.key,
    required this.type,
    // required this.showLoginPage
  });
  // final VoidCallback showLoginPage;
  final String type;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailEditingController = TextEditingController();
  final _textEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _passwordEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 10,
              ),
              Text(
                "Hello ${widget.type}!",
                style: const TextStyle(fontSize: 52),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 10,
              ),

              // Lottie.asset('assets/login.json',
              //     width: MediaQuery.of(context).size.width / 2,
              //     height: MediaQuery.of(context).size.width / 2),
              Container(
                height: 340,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 224, 224, 224),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sign Up ",
                          style: TextStyle(color: Colors.black, fontSize: 32),
                        ),
                      ),
                      //                 SizedBox(
                      //   height: MediaQuery.of(context).viewInsets.bottom,
                      // ),
                      SizedBox(
                        width: 320,
                        height: 100,
                        child: myTextField(
                          textEditingController: _emailEditingController,
                          label: 'Email',
                          obscureTextBool: false,
                          focus: true,
                          validator: (value) {
                            if (value.isEmpty ||
                                !value.contains('@') ||
                                value.toString().trim().contains(' ') ||
                                !value.toString().trim().contains('.com') ||
                                value.startsWith('@') ||
                                value.endsWith('@') ||
                                value.indexOf('@') != value.lastIndexOf('@') ||
                                value.indexOf('.') == -1 ||
                                value.indexOf('@') > value.lastIndexOf('.') ||
                                value.lastIndexOf('.') > value.length - 3) {
                              print(value.toString().trim().contains(' '));
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      // myTextField(
                      //   textEditingController: _textEditingController,
                      //   label: 'Username',
                      //   obscureTextBool: false,
                      //   focus: true,
                      //   validator: (value) {
                      //     if (value.isEmpty ||
                      //         value.length < 4 ||
                      //         value.length > 20 ||
                      //         !RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                      //       return 'Please enter a valid username (4-20 characters, alphanumeric and underscore only)';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(
                        width: 320,
                        height: 100,
                        child: myTextField(
                          textEditingController: _passwordEditingController,
                          label: 'Passsword',
                          obscureTextBool: false,
                          focus: false,
                          validator: (value) {
                            if (value.isEmpty ||
                                value.length < 6 ||
                                value.toString().trim().contains(' ') ||
                                !RegExp(r'(?=.*[a-z])').hasMatch(value) ||
                                !RegExp(r'(?=.*[A-Z])').hasMatch(value) ||
                                !RegExp(r'(?=.*\d)').hasMatch(value) ||
                                !RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),

                      // TextField(
                      //   focusNode: FocusNode(canRequestFocus: focusNode.canRequestFocus),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                fixedSize:
                                    MaterialStatePropertyAll(Size(150, 30)),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {
                              if (_validateForm()) {
                                // _formKey.currentState?.validate();
                                // signup();
                                _formKey.currentState?.validate();
                                signup(
                                        _emailEditingController.text.trim(),
                                        _passwordEditingController.text.trim(),
                                        widget.type)
                                    .then((value) async {
                                  // getUserDetails(userCredential, _textEditingController.text);
                                  print(
                                      "----------------------------value: $value");

                                  if (widget.type == 'Customer') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HiddenMenuDrawer()));
                                  } else if (widget.type == 'Tailor') {
                                    await newMethod();

                                    firestore
                                        .collection('users')
                                        .doc(firebaseAuth.currentUser!.uid)
                                        .collection("ID")
                                        .doc(firebaseAuth.currentUser!.uid)
                                        .set({
                                      "ID": RegisterPage.ID_NUMBER.isNegative
                                          ? newMethod()
                                          : RegisterPage.ID_NUMBER,
                                      "uid-TID": firebaseAuth.currentUser!.uid,
                                    }).then((value) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TailorCompleteInfo()));
                                    });
                                  }

                                  //  getTotalUsers(widget.type);
                                });
                              }
                              // _textEditingController.text;
                              // _passwordEditingController.text;
                              // if (_textEditingController.text == 'abc' &&
                              //     _passwordEditingController.text == 'abd') {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (context) => const LoggedIn())
                              //       );
                              // }
                            },
                            //  focusNode: focusNode,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 12),
                              child: Text("Register",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            )),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Already Have An Account? "),
                    TextButton(
                        onPressed: () {
                          // widget.showLoginPage();

                          // print(widget.showLoginPage.toString());
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(type: widget.type)));
                        },
                        child: const Text("Login Now",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0))))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int> newMethod() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tailorDocuments =
        querySnapshot.docs
            .where((doc) => doc.data()['type'] == 'Tailor')
            .toList();

    int totalUsers = tailorDocuments.length;
    RegisterPage.ID_NUMBER = totalUsers + 1;
    print("----------------------------tot: $totalUsers");
    print("----------------------------totR: ${RegisterPage.ID_NUMBER}");
    return RegisterPage.ID_NUMBER;
  }

  bool _validateForm() {
    return _emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty;
  }

// void addtoFirestore(int totalUsers) {
//   firestore.collection('ID').doc(firebaseAuth.currentUser!.uid).set({
//     "TID": totalUsers,
//     "uid-TID": firebaseAuth.currentUser!.uid,
//   });
// }
// void addtoFirestore(int totalUsers) {
//   firestore.collection('ID').doc(firebaseAuth.currentUser!.uid).set({
//     "TID": totalUsers,
//     "uid-TID": firebaseAuth.currentUser!.uid,
//   });
// }

// Future<int> newID(type) {
//   Future<int> id = getTotalUsers(type);
//   return id;
// }
}
 
  
// void newID(type) async {
//   //get total users and set new ID
//   QuerySnapshot querySnapshot = await firestore.collection(type).get();
//   int totalUsers = querySnapshot.docs.length;

//   print('Total users------------------: $totalUsers');

//   RegisterPage.ID_NUMBER = totalUsers + 1;
//   print('Total users inRegisterStatic : $totalUsers');
//   // addtoFirestore(totalUsers);

// }