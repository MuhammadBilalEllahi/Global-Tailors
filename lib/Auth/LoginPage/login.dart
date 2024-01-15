import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/Common/choosing_screen.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/sideba_menu.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';
import 'package:tailor_flutter/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final StreamController<bool> _loginStreamController =
      StreamController<bool>();

  @override
  void dispose() {
    _textEditingController.dispose();
    _passwordEditingController.dispose();
    _loginStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    // print(" check if logged in ${firebaseAuth.currentUser!.uid}");
    _textEditingController.text = 'newuser@gmail.com';
    _passwordEditingController.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.width / 2),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextSized(
                  text: "Hi ${widget.type}",
                  fontSize: 32,
                ),
                myTextField(
                  textEditingController: _textEditingController,
                  label: 'Email',
                  obscureTextBool: false,
                  focus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                myTextField(
                  textEditingController: _passwordEditingController,
                  label: 'Passsword',
                  obscureTextBool: true,
                  focus: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signin(_textEditingController, _passwordEditingController,
                              context)
                          .then((value) {
                        getUserType().then((value) {
                          if (value == 'Tailor') {
                            _loginStreamController
                                .add(true); // Notify login state change
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TailorBottomNavigation(),
                              ),
                              (route) => false,
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .setUserType(value.toString());

                            Provider.of<UserProvider>(context, listen: false)
                                .setAuthId(firebaseAuth.currentUser!.uid);
                          } else if (value == "Customer") {
                            _loginStreamController
                                .add(true); // Notify login state change
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HiddenMenuDrawer(),
                              ),
                              (route) => false,
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .setUserType(value.toString());
                            Provider.of<UserProvider>(context, listen: false)
                                .setAuthId(firebaseAuth.currentUser!.uid);
                          }
                        });
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 12),
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("No Account? "),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignInUpAs(),
                            ),
                          );
                        },
                        child: const TextSized(
                          text: "Sign Up Now",
                          fontSize: 13,
                          // style: TextStyle(
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
