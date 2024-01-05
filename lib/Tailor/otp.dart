// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tailor_app/Common/full_dimension_container.dart';
// import 'package:tailor_app/Common/my_elevatedbutton.dart';
// import 'package:tailor_app/Common/my_textfield.dart';
// import 'package:tailor_app/Common/otp_field.dart';
// import 'package:tailor_app/FireBase/firebase.dart';
// import 'package:tailor_app/Tailor/tailor_book.dart';
// import 'package:tailor_app/Tailor/tailor_init.dart';

// class OtpPhone extends StatefulWidget {
//   const OtpPhone({super.key, required this.ph});
//   final TextEditingController ph;

//   @override
//   State<OtpPhone> createState() => _OtpPhoneState();
// }

// class _OtpPhoneState extends State<OtpPhone> {
//   TextEditingController otp1 = TextEditingController();
//   TextEditingController otp2 = TextEditingController();
//   TextEditingController otp3 = TextEditingController();
//   TextEditingController otp4 = TextEditingController();
//   TextEditingController otp5 = TextEditingController();
//   TextEditingController otp6 = TextEditingController();
//   var otpCode = '';

 
//   late FocusNode otp1FocusNode;
//   late FocusNode otp2FocusNode;
//   late FocusNode otp3FocusNode;
//   late FocusNode otp4FocusNode;
//   late FocusNode otp5FocusNode;
//   late FocusNode otp6FocusNode;
//   late FocusNode enterKeyFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     otp1FocusNode = FocusNode();
//     otp2FocusNode = FocusNode();
//     otp3FocusNode = FocusNode();
//     otp4FocusNode = FocusNode();
//     otp5FocusNode = FocusNode();
//     otp6FocusNode = FocusNode();
//     enterKeyFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     otp1.dispose();
//     otp2.dispose();
//     otp3.dispose();
//     otp4.dispose();
//     otp5.dispose();
//     otp6.dispose();

//     otp1FocusNode.dispose();
//     otp2FocusNode.dispose();
//     otp3FocusNode.dispose();
//     otp4FocusNode.dispose();
//     otp5FocusNode.dispose();
//     otp6FocusNode.dispose();
//     enterKeyFocusNode.dispose();

//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//           child: FullDimensionContainer(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const MySizedBox(val: 30),
//             const TextSized(fontSize: 30, text: "Finish Your Sign Up"),
//             const MySizedBox(val: 50),

//             const TextSized(
//                 fontSize: 15, text: "Otp has been sent to your phone number"),

//             // const TextSized(fontSize: 30, text: "Your Phone Number"),
//             const MySizedBox(val: 20),

//             SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 height: 80,
//                 child: myTextField(
//                     textEditingController: widget.ph,
//                     label: "Your Phone Number",
//                     obscureTextBool: false,
//                     focus: false,
//                     validator: null,
//                     readOnly: false,
//                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                     inputBorder: const OutlineInputBorder())),

//             const MySizedBox(val: 20),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 myOTPField(
//                   textEditingController: otp1,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
//                   focusNode: otp1FocusNode,
//       nextFocusNode: otp2FocusNode,
                  
//                 ),
//                 myOTPField(
//                   textEditingController: otp2,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
                  
//        focusNode: otp2FocusNode,
//   nextFocusNode: otp3FocusNode,
//                 ),
//                 myOTPField(
//                   textEditingController: otp3,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
//                   focusNode: otp3FocusNode,
//       nextFocusNode: otp4FocusNode,
//                 ),
//                 myOTPField(
//                   textEditingController: otp4,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
//                   focusNode: otp4FocusNode,
//       nextFocusNode: otp5FocusNode,
//                 ),
//                 myOTPField(
//                   textEditingController: otp5,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
//                   focusNode: otp5FocusNode,
//       nextFocusNode: otp6FocusNode,
//                 ),
//                 myOTPField(
//                   textEditingController: otp6,
//                   label: "X",
//                   obscureTextBool: false,
//                   focus: false,
//                   validator: null,
//                   readOnly: false,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   inputBorder: const OutlineInputBorder(),
//                   focusNode: otp6FocusNode,
//       nextFocusNode: enterKeyFocusNode,
//                 ),
//               ],
//             ),
//             const MySizedBox(val: 20),

//             MyElevatedButtom(
//               focusNode: enterKeyFocusNode,
//               label: 'Finish',
//               fontSize: 24,
//               onPressed: () async {
//                 //delete it back
//                                   // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const TailorBook()));
//                 //uncomment later
//                 try {
//                 if (_validateOTP()){
//                   otpCodefunc();
//                   print(otpCode);
//                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                       verificationId: TailorStartPage.otpcode,
//                       smsCode: otpCodefunc());
//                    print("This is otp${otpCodefunc()}");
                   
//                   // Sign the user in (or link) with the credential
//                   await firebaseAuth.verifyPhoneNumber(credential).then((value) {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const TailorBook()));

//                   });
//                 }
//               } catch (e) {
//                       // Handle verification failure
//                       print("Error verifying OTP: $e");
//                       showDialogForOTPError(context);
//                     }
//               })
            
//           ],
//         ),
//       )),
//     );
//   }
//   void showDialogForOTPError(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: const Text("Invalid OTP. Please try again."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   String otpCodefunc() {
//     return otpCode =
//         "${otp1.text}${otp2.text}${otp3.text}${otp4.text}${otp5.text}${otp6.text}";
//   }

//   bool _validateOTP() {
//     return otp1.text.isNotEmpty &&
//         otp2.text.isNotEmpty &&
//         otp3.text.isNotEmpty &&
//         otp4.text.isNotEmpty &&
//         otp5.text.isNotEmpty &&
//         otp6.text.isNotEmpty;
//   }
// }
