import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_book.dart';

final tailorNameEditingController = TextEditingController();
final shopNameEditingController = TextEditingController();
final locationEditingController = TextEditingController();
final addressEditingController = TextEditingController();
final phoneNumberEditingController = TextEditingController();

class TailorCompleteInfo extends StatelessWidget {
  const TailorCompleteInfo({super.key});

  static String otpcode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // const SearchBar(),
              const TextSized(text: "Let's get you started. ", fontSize: 35),
              const SizedBox(
                height: 10,
              ),
              const TextSized(
                fontSize: 38,
                text: "Complete Your Profile to Join Market",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  myTextField(
                    textEditingController: tailorNameEditingController,
                    label: 'Your Name',
                    obscureTextBool: false,
                    focus: false,
                    validator: null,
                  ),
                  myTextField(
                      textEditingController: shopNameEditingController,
                      label: 'Shop Name',
                      obscureTextBool: false,
                      focus: false,
                      validator: null),
                  myTextField(
                      textEditingController: locationEditingController,
                      label: 'Location',
                      obscureTextBool: false,
                      focus: false,
                      validator: null),
                  myTextField(
                      textEditingController: addressEditingController,
                      label: 'Address',
                      obscureTextBool: false,
                      focus: false,
                      validator: null),
                  // myTextField(
                  //     textEditingController: phoneNumberEditingController,
                  //     label: 'Phone Number',
                  //     obscureTextBool: false,
                  //     focus: false,
                  //     validator: null,
                  //     inputFormatters: [
                  //       FilteringTextInputFormatter.digitsOnly
                  //     ]),

                  MyPhoneTextField(
                      textEditingController: phoneNumberEditingController,
                      label: 'Phone Number',
                      focus: false,
                      validator: null,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ],
              ),

              MyElevatedButtom(
                  label: 'Next',
                  fontSize: 18,
                  onPressed: () {
                    print({
                      "tailor_name": tailorNameEditingController.text,
                      "tailor_shop_name": shopNameEditingController.text,
                      "tailor_location": locationEditingController.text,
                      "tailor_address": addressEditingController.text,
                      "tailor_phone_number": phoneNumberEditingController.text,
                    });

                    if (_validateForm()) {
                      firebaseAuth.currentUser!
                          .updateDisplayName(tailorNameEditingController.text);
                      // firebaseAuth.currentUser!.updatePhoneNumber(phoneNumberEditingController.text);
                      // firebaseAuth.currentUser.linkWithCredential()
                      firestore
                          .collection('users')
                          .doc(firebaseAuth.currentUser!.uid)
                          .collection('tailor_info')
                          .doc(firebaseAuth.currentUser!.uid)
                          .set({
                        "tailor_name": tailorNameEditingController.text,
                        "tailor_shop_name": shopNameEditingController.text,
                        "tailor_location": locationEditingController.text,
                        "tailor_address": addressEditingController.text,
                        "tailor_phone_number":
                            phoneNumberEditingController.text,
                      }).then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TailorBook()));
                        // OtpPhone(ph: phoneNumberEditingController)));
                      });
                      // .then((value) {
                      //   verifyPhone(phoneNumberEditingController.text);
                      // }).then((value) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) =>
                      //           OtpPhone(ph: phoneNumberEditingController)));
                      // });
                    } else {
                      showDialogForFields(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  verifyPhone(phoneNumber) async {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verfictionId, int? resendToken) {
          TailorCompleteInfo.otpcode = verfictionId;
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  bool _validateForm() {
    return tailorNameEditingController.text.isNotEmpty &&
        shopNameEditingController.text.isNotEmpty &&
        locationEditingController.text.isNotEmpty &&
        addressEditingController.text.isNotEmpty &&
        phoneNumberEditingController.text.isNotEmpty;
  }

  Future<dynamic> showDialogForFields(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            shape: BeveledRectangleBorder(),
            backgroundColor: Colors.black,
            content: Text(
              "Fields can not be empty",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          );
        });
  }
}

class TextSized extends StatelessWidget {
  const TextSized({
    super.key,
    required this.fontSize,
    required this.text,
    this.textAlign,
    this.textColor,
  });
  final double fontSize;
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? Theme.of(context).primaryColorLight,
      ),
    );
  }
}
