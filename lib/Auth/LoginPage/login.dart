import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/Common/choosing_screen.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/Customer/Menu%20Scaffold/sideba_menu.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_bottm_navigation.dart';
import 'package:tailor_flutter/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:project/Auth/Common/my_textfield.dart';
// import 'package:project/Auth/Forgot%20Password/forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.type,
    // required this.showRegisterPage
  });
  // final VoidCallback showRegisterPage;
  final String type;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    // TODO: implement initState
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
                  Text(
                    "Hi ${widget.type}",
                    style: const TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  // Lottie.asset('assets/login.json',
                  //     width: MediaQuery.of(context).size.width / 2,
                  //     height: MediaQuery.of(context).size.width / 2),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25, bottom: 10),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const ForgotPasswordPage()));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                  // TextField(
                  //   focusNode: FocusNode(canRequestFocus: focusNode.canRequestFocus),
                  // ),

                  ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(200, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () {
                        // Navigator.replace(context, oldRoute: MaterialPageRoute(builder: (context)=> LoginPage(type: widget.type)), newRoute: MaterialPageRoute(builder: (context)=> const TailorBottomNavigation()));

                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //   builder: (context) =>  const TailorBottomNavigation()));
                        print(_textEditingController.text);
                        print(_passwordEditingController.text);
                        // 439mb with debug

                        /*
                         
                         ?*
                         *?use this code later in
          
                        */

                        if (_formKey.currentState!.validate()) {
                          signin(_textEditingController,
                                  _passwordEditingController, context)
                              .then((value) {
                            getUserType().then(
                              (value) {
                                print(">>>>>> $value");
                                if (value == 'Tailor') {
                                  print("(login page ) > okTailor");

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TailorBottomNavigation()),
                                      (route) => false);
                                      
                                  Provider.of<UserProvider>(context, listen: false)
                                  .setUserType(value.toString());
                                } 
                                 if (value == "Customer") {
                                  print("(login page ) > okCustomer");

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HiddenMenuDrawer()),
                                          (route) => false );

                                  Provider.of<UserProvider>(context, listen: false)
                                  .setUserType(value.toString());
                                  }
                              },
                            );
                          });
                
                          // Navigator.replace(context, oldRoute: oldRoute, newRoute: newRoute)
                        }
                      },
                      //  focusNode: focusNode,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 12),
                        child: Text(
                          "Log In",
                          // style: GoogleFonts.bebasNeue(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("No Account? "),
                        TextButton(
                            onPressed: () {
                              // widget.showRegisterPage();
                              // print(widget.showRegisterPage.toString());
                              Navigator.pop(context);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInUpAs()));
                            },
                            child: const Text(
                              "Sign Up Now",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
