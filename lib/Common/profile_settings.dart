import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';
import 'package:tailor_flutter/provider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool isTailor = false;
  bool updated = false;

  final TextEditingController _bookNumberController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedImage;
  final StreamController<String?> _bookIdStreamController =
      StreamController<String?>();

  // FormFieldValidator
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // Access userType in initState

    if (Provider.of<UserProvider>(context, listen: false).userType == null) {
      getUserType().then(
        (value) {
          Provider.of<UserProvider>(context, listen: false)
              .setUserType(value.toString());
        },
      );
    }

    String? userType =
        Provider.of<UserProvider>(context, listen: false).userType;
    print("UserType $userType");
    // Set isCustomer based on userType
    isTailor = (userType == 'Tailor');

    if (isTailor) {
      getBookIDSnap().then(
        (value) {
          print("This is book id ? $value");
          _bookNumberController.text = value.toString();
          Provider.of<UserProvider>(context, listen: false)
              .setBookID(value.toString());
          _bookIdStreamController.add(value.toString());
        },
      );
      getPhoneNumberTailorSnap().then((value) {
        print("This is tailor ? $value");
        _phoneNumberController.text = value.toString();
      });
    }
    print("Is it tailor > $isTailor");

    firebaseAuth.currentUser?.photoURL;

    // Initialize controllers with current values
    _displayNameController.text = firebaseAuth.currentUser?.displayName ?? '';
    _phoneNumberController.text =
        firebaseAuth.currentUser?.phoneNumber ?? 'No Number Added';
    _emailController.text = firebaseAuth.currentUser!.email!;

    super.initState();
  }

  // Add a function to update the user profile
  void updateProfileTailorNamePhonePhone(
      String displayName, String phoneNumber) {
    firebaseAuth.currentUser!.updateDisplayName(displayName);
    firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_book_number")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"book_id": _bookNumberController.text}).then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Book ID Updated'),
              content: const Text('The data has been updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    });
    firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("tailor_info")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"tailor_phone_number": _phoneNumberController.text}).then(
            (value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Number Updated'),
              content: const Text('The data has been updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    });
    // firebaseAuth.currentUser!.updatePhoneNumber();
  }

  // Future _pickImageFromCamera() async {
  //   final pickedFile = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 100);
  //   if (pickedFile == null) return;
  //   setState(() {
  //     _selectedImage = File(pickedFile.path);
  //   });
  // }

  // Future _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(
  //       source: ImageSource.gallery, imageQuality: 100);
  //   if(pickedFile == null ) return;
  //   setState(() {
  //     _selectedImage = File(pickedFile.path);
  //     Future<Uint8List> file = pickedFile.readAsBytes();
  //       firebaseAuth.currentUser!.updatePhotoURL(file as String?);
  //   });

  //   // if (pickedFile != null) {
  //   //   print('Selected image path: ${pickedFile.path}');
  //   //   firebaseAuth.currentUser!.updatePhotoURL(pickedFile.path);
  //   // } else {
  //   //   print('No image selected.');
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          color: Theme.of(context).cardColor.withOpacity(0.8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // firebaseAuth.currentUser!.updatePhotoURL("photoURL");
                  _pickImage(ImageSource.gallery)
                      .then((value) => updated = true);
                },
                child: updated
                    ? firebaseAuth.currentUser!.photoURL != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                firebaseAuth.currentUser!.photoURL!))
                        : Image.asset("assetss/tailor.png")
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "${firebaseAuth.currentUser!.photoURL}")),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _pickImage(ImageSource.camera)
                            .then((value) => updated = true);
                      },
                      icon: const Icon(Icons.camera_alt)),
                  IconButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery)
                            .then((value) => updated = true);
                      },
                      icon: const Icon(Icons.sd_storage))
                ],
              ),
              isTailor
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String?>(
                        future: getTailorIDSnap(),
                        builder: (content, snapshot) {
                          print(
                              "Tailor ID (lib/Tailor/tailor_settings.dart) : > ${snapshot.data}");
                          return TextSized(
                            text: "Tailor Id : T-${snapshot.data.toString()}",
                            fontSize: 25,
                            textAlign: TextAlign.left,
                            // textColor: Colors.black,
                          );
                        },
                      ),
                    )
                  : Container(),
              isTailor
                  // ? Provider.of<UserProvider>(context, listen: false).bookIDs !=
                  //         null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: StreamBuilder<String?>(
                        stream: _bookIdStreamController.stream,
                        builder: (context, snapshot) {
                          print(
                              "Tailor ID (lib/Tailor/tailor_settings.dart) : > ${snapshot.data}");
                          return TextSized(
                            text: "Book Id : B-${snapshot.data ?? ''}",
                            fontSize: 25,
                            textAlign: TextAlign.left,
                            // textColor: Colors.black,
                          );
                        },
                      ),
                      //  FutureBuilder<String?>(
                      //   future: getBookIDSnap(),
                      //   builder: (content, snapshot) {
                      //     print(
                      //         "Tailor ID (lib/Tailor/tailor_settings.dart) : > ${snapshot.data}");
                      //     return TextSized(
                      //       text: "Book Id : B-${snapshot.data.toString()}",
                      //       fontSize: 25,
                      //       textAlign: TextAlign.left,
                      //       // textColor: Colors.black,
                      //     );
                      //   },
                      // ),
                    )
                  // : TextSized(
                  //     text:
                  //         "Book Id : B-${Provider.of<UserProvider>(context, listen: false).bookIDs}",
                  //     fontSize: 25,
                  //     textAlign: TextAlign.left,
                  //     // textColor: Colors.black,
                  //   )
                  : Container(),

              myTextField(
                validator: (value) {
                  if (value.toString().isEmpty ||
                      value.toString().contains(RegExp('rd'))) {
                    return "No Numbers";
                  }
                  return null;
                },
                focus: false,
                obscureTextBool: false,
                // keybordType: TextInputType.name,
                textEditingController: _displayNameController,
                readOnly: false,
                height: 70,
                padZero: 0,

                width: MediaQuery.of(context).size.width,

                label: 'Full Name',

                // Add other decoration properties as needed
              ),
              myTextField(
                validator: null,
                // (value) {
                //   if (value.isEmpty ||
                //       !value.contains('@') ||
                //       value.toString().trim().contains(' ') ||
                //       !value.toString().trim().contains('.com') ||
                //       value.startsWith('@') ||
                //       value.endsWith('@') ||
                //       value.indexOf('@') != value.lastIndexOf('@') ||
                //       value.indexOf('.') == -1 ||
                //       value.indexOf('@') > value.lastIndexOf('.') ||
                //       value.lastIndexOf('.') > value.length - 3) {
                //     print(value.toString().trim().contains(' '));
                //     return 'Please enter a valid email address';
                //   }
                //   return null;
                // },
                focus: false,
                obscureTextBool: false,

                textEditingController: _emailController,
                readOnly: true,
                height: 70,
                padZero: 0,

                width: MediaQuery.of(context).size.width,

                label: 'Email',

                // Add other decoration properties as needed
              ),

              myTextField(
                validator: (value) {
                  if (RegExp(r'^[0-9+]+$').hasMatch(value!)) {
                    return null;
                  } else {
                    return 'numbers only';
                  }
                },
                focus: false,
                obscureTextBool: false,
                keybordType: TextInputType.phone,
                textEditingController: _phoneNumberController,
                readOnly: false,
                height: 70,
                padZero: 0,

                width: MediaQuery.of(context).size.width,

                label: 'Phone Number',

                // Add other decoration properties as needed
              ),
              const SizedBox(height: 8),

              isTailor
                  ? SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      // height: 90,
                      child: Row(
                        children: [
                          myTextField(
                            // validatorForm: (value) {
                            //   String newValue =
                            //       value.toString().replaceAll("^0+", "");
                            //   print("val $value");

                            //   if (value.toString().contains(",") ||
                            //       value.toString().contains("-") ||
                            //       value.toString().contains(".")) {
                            //     print("Enter Numbers Only ");
                            //     value.toString().replaceAll(",", "");
                            //     value.toString().replaceAll("-", "");
                            //     value.toString().replaceAll(".", "");
                            //     // myShowDialog(context, "Enter Numbers Only");
                            //     //set custom value
                            //   }
                            //   if (value.toString().contains(" ")) {
                            //     value = value.toString().replaceAll(" ", "");
                            //   }
                            //   return value;
                            // },
                            validator: (value) {
                              if (RegExp(r'^0+[1-9]').hasMatch(value!)) {
                                value = value
                                    .toString()
                                    .replaceAll(RegExp(r'^0+'), "");
                                _bookNumberController.text = value;
                                print("val $value");
                              }

                              if (value.toString().contains(",") ||
                                  value.toString().contains("-") ||
                                  value.toString().contains(".")) {
                                print("Enter Numbers Only ");
                                value = value.toString().replaceAll(",", "");
                                value = value.toString().replaceAll("-", "");
                                value = value.toString().replaceAll(".", "");
                                _bookNumberController.text = value;
                                return "No - , . allowed";
                                // myShowDialog(context, "Enter Numbers Only");
                                //set custom value
                              }
                              if (value.toString().contains(" ")) {
                                value = value.toString().replaceAll(" ", "");
                                _bookNumberController.text = value;
                                return null;
                              }
                              return null;
                            },

                            focus: false,
                            obscureTextBool: false,
                            keybordType: TextInputType.number,
                            textEditingController: _bookNumberController,
                            readOnly: false,
                            height: 80,
                            padZero: 0,

                            width: MediaQuery.of(context).size.width - 80,

                            label: 'Book Number',

                            // Add other decoration properties as needed
                          ),
                          IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                firestore
                                    .collection("users")
                                    .doc(firebaseAuth.currentUser!.uid)
                                    .collection("tailor_book_number")
                                    .doc(firebaseAuth.currentUser!.uid)
                                    .update({
                                  "book_id": _bookNumberController.text.trim()
                                }).then((value) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .setBookID(
                                          _bookNumberController.text.trim());
                                  _bookIdStreamController
                                      .add(_bookNumberController.text.trim());

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Data Updated'),
                                          content: const Text(
                                              'The data has been updated successfully.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      });
                                });
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(height: 16),
              MyElevatedButtom(
                onPressed: () {
                  if (isTailor && formKey.currentState!.validate()) {
                    updateProfileTailorNamePhonePhone(
                      _displayNameController.text,
                      _phoneNumberController.text,
                    );
                  } else {
                    updateProfileCustomer(
                      _displayNameController.text,
                      _phoneNumberController.text,
                    );
                  }
                },
                label: 'Save Changes',
                fontSize: 13,
              ),
              const SizedBox(height: 16),
              // Text(
              //   'User ID: ${firebaseAuth.currentUser?.uid ?? "N/A"}',
              //   style: const TextStyle(fontSize: 16),
              // ),
              // _selectedImage != null
              //     ? Image.file(_selectedImage!)
              //     : const Text("pic"),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 100,
    );

    if (pickedFile == null) return;

    Uint8List bytes = await pickedFile.readAsBytes();
    // final storageRef2 =
    firebaseStorage.ref().putData(bytes);
    final storageRef = firebaseStorage
        .ref()
        .child('profile_images/${firebaseAuth.currentUser!.uid}');
    final uploadTask = storageRef.putData(bytes);

    await uploadTask.whenComplete(() {
      print("ok");
    });
    uploadTask.onError((error, stackTrace) {
      print("This here$error");
      throw Exception();
    });

    final downloadURL = await storageRef.getDownloadURL();
    print('Image uploaded. Download URL: $downloadURL');

    setState(() {
      _selectedImage = File(pickedFile.path);
    });

    // Update user's photoURL
    firebaseAuth.currentUser!.updatePhotoURL(downloadURL);
  }

  void updateProfileCustomer(String displayName, String phoneNumber) {
    firebaseAuth.currentUser!.updateDisplayName(displayName);

    firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("customer_info")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "customer_phone_number": phoneNumber,
    }, SetOptions(merge: true)).then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Number Updated'),
              content: const Text('The data has been updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    });
  }
}
