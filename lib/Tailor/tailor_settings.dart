import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_init.dart';
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

  @override
  void initState() {
    // Access userType in initState
    String? userType =
        Provider.of<UserProvider>(context, listen: false).userType;
    // Set isCustomer based on userType
    isTailor = (userType == 'Tailor');
    print("Is it tailor or not > $isTailor");
    getBookIDSnap().then((value) {
      print("This is data ? $value");
      _bookNumberController.text = value.toString();
    },);
    firebaseAuth.currentUser?.photoURL;

    // Initialize controllers with current values
    _displayNameController.text = firebaseAuth.currentUser?.displayName ?? '';
    _phoneNumberController.text = firebaseAuth.currentUser?.phoneNumber ?? '09924043422';
    _emailController.text = firebaseAuth.currentUser!.email!;

        super.initState();

  }

  // Add a function to update the user profile
  void updateProfile(String displayName, String phoneNumber) {
    firebaseAuth.currentUser!.updateDisplayName(displayName);
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
  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 100,
    );

    if (pickedFile == null) return;

    Uint8List bytes = await pickedFile.readAsBytes();
    final storageRef2 = firebaseStorage.ref().putData(bytes);
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 218, 218, 218),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // firebaseAuth.currentUser!.updatePhotoURL("photoURL");
                _pickImage(ImageSource.gallery).then((value) => updated = true);
              },
              child: updated
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(firebaseAuth
                              .currentUser?.photoURL ??
                          'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                    )
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
                          textColor: Colors.black,
                        );
                      },
                    ),
                  )
                : Container(),
            isTailor
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<String?>(
                      future: getBookIDSnap(),
                      builder: (content, snapshot) {
                        print(
                            "Tailor ID (lib/Tailor/tailor_settings.dart) : > ${snapshot.data}");
                        return TextSized(
                          text: "Book Id : B-${snapshot.data.toString()}",
                          fontSize: 25,
                          textAlign: TextAlign.left,
                          textColor: Colors.black,
                        );
                      },
                    ),
                  )
                : Container(),
            TextFormField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                // Add other decoration properties as needed
              ),
            ),
            TextFormField(
              controller: _emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Email',

                // Add other decoration properties as needed
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                // Add other decoration properties as needed
              ),
            ),
            isTailor
                ? SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 80,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _bookNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Book Number',
                              // Add other decoration properties as needed
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            firestore
                                .collection("users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("tailor_book_number")
                                .doc(firebaseAuth.currentUser!.uid)
                                .update({
                              "book_id": _bookNumberController.text
                            }).then((value) {
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
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the "Edit Profile" button click
                // Save the updated values to Firebase or your backend
                updateProfile(
                  _displayNameController.text,
                  _phoneNumberController.text,
                );
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 16),
            Text(
              'User ID: ${firebaseAuth.currentUser?.uid ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : const Text("pic"),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:tailor_flutter/FireBase/firebase.dart';

// class ProfileSettings extends StatelessWidget {
//   const ProfileSettings({super.key});

  

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         color: Colors.lightGreen.shade50,
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//              CircleAvatar(
//               radius: 60,
//               backgroundImage: NetworkImage(firebaseAuth.currentUser?.photoURL ??   'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
//             ),
//              const SizedBox(height: 16),
//              Text( firebaseAuth.currentUser?.displayName ?? "John Doe",
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//              Text( firebaseAuth.currentUser?.phoneNumber ?? "32", 
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle the "Edit Profile" button click
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
//               },
//               child: const Text('Edit Profile'),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               firebaseAuth.currentUser!.uid,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// // import 'package:flutter/material.dart';
// // import 'package:tailor_flutter/FireBase/firebase.dart';


// // class ProfileSettings extends StatelessWidget {
// //   const ProfileSettings({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Container(
// //           color: Colors.lightGreen.shade50,
// //           height: MediaQuery.of(context).size.height,
// //           width: MediaQuery.of(context).size.width,
// //           child:  Column(
// //             children: [
// //                 Text(firebaseAuth.currentUser!.uid) 
// //             ],
// //           )
// //           )
// //     );
// //   }
// // }
