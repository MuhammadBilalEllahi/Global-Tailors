// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/Common/my_textfield.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();
  File? _selectedImage;
  bool updated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // changeHeight(context);
              },
              child: myTextField(
                validator: null,
                focus: false,
                obscureTextBool: false,
                // keybordType: TextInputType.name,
                textEditingController: _titleEditingController,
                readOnly: false,
                height: 90,

                // padZero: 0,

                width: MediaQuery.of(context).size.width,

                label: 'Title',

                // Add other decoration properties as needed
              ),
            ),
            GestureDetector(
              onTap: () {
                // changeHeight(context);
              },
              child: myTextField(
                validator: null,
                focus: false,
                obscureTextBool: false,
                // keybordType: TextInputType.name,
                textEditingController: _contentEditingController,
                readOnly: false,
                height: 90,

                // padZero: 0,

                width: MediaQuery.of(context).size.width,

                label: 'Description',

                // Add other decoration properties as needed
              ),
            ),
            MyElevatedButtom(
              label: "Upload",
              fontSize: 13,
              onPressed: () async {
                // print(Provider.of<UserProvider>(context, listen: false)
                //     .pickedFiles);
                if (_titleEditingController.text.isNotEmpty &&
                    _contentEditingController.text.isNotEmpty &&
                    Provider.of<UserProvider>(context, listen: false)
                            .pickedFiles !=
                        null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text(
                              "Please Wait While we upload. Continue your Work"),
                        );
                      });
                  // if (Provider.of<UserProvider>(context, listen: false)
                  //         .pickedFiles !=
                  //     null) {
                  await uploadImageToFireStorage(
                          Provider.of<UserProvider>(context, listen: false)
                              .pickedFiles!)
                      .then((value) {
                    firestore
                        .collection("tailor_posts")
                        .doc(firebaseAuth.currentUser!.uid)
                        .collection('posts')
                        .doc()
                        .set({
                      "title": _titleEditingController.text,
                      "content": _contentEditingController.text,
                      "img": Provider.of<UserProvider>(context, listen: false)
                          .downloadUrls
                          .toString(),
                      "T-ID": Provider.of<UserProvider>(context, listen: false)
                          .tailorIDs,
                      "uid": firebaseAuth.currentUser!.uid,
                      "like": 0,
                      'timestamp': Timestamp.now()
                    });
                    firestore
                        .collection("tailor_posts")
                        .doc(firebaseAuth.currentUser!.uid)
                        .set({"uid_posts": firebaseAuth.currentUser!.uid});
                  }).whenComplete(() {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("Uploaded"),
                          );
                        });
                  }).onError((error, stackTrace) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("Failed Upload"),
                          );
                        });
                  });
                  // }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Please Fill All Fields"),
                        );
                      });
                }
                // Provider.of<UserProvider>(context, listen: false).pickedFile;

                // await uploadImageToFireStorage(file);
                // if (Provider.of<UserProvider>(context, listen: false)
                //         .pickedFiles !=
                //     null) {
                //   await uploadImageToFireStorage(
                //       Provider.of<UserProvider>(context, listen: false)
                //           .pickedFiles!);
                // }
              },
            ),
            IconButton(
                onPressed: () {
                  _pickImage(ImageSource.camera)
                      .then((value) => updated = true);
                },
                icon: const Icon(Icons.camera)),
            updated
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: MediaQuery.of(context).size.width - 30,
                        width: MediaQuery.of(context).size.width - 30,
                        decoration: const BoxDecoration(
                            // border: Border(top: BorderSide(), bottom: BorderSide(), left: BorderSide(), right: BorderSide())
                            color: Colors.black12),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                height: MediaQuery.of(context).size.width - 30,
                              )
                            : Container()),
                  )
                : Container(),
            // _selectedImage != null
            //     ? Image.file(_selectedImage!)
            //     : const Text("pic"),
          ],
        )
      ]),
    );
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 100,
    );

    if (pickedFile == null) return;

    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).imgPath(pickedFile);

    setState(() {
      print(Provider.of<UserProvider>(context, listen: false).pickedFiles);

      _selectedImage = File(pickedFile.path);
    });
  }

  Future<void> uploadImageToFireStorage(XFile pickedFile) async {
    Uint8List bytes = await pickedFile.readAsBytes();
    final storageRef = firebaseStorage.ref().child(
        'post_images/${firebaseAuth.currentUser!.uid}/${pickedFile.path}');
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

    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false)
        .downloadUrlString(downloadURL.toString());
    print(
        // ignore: use_build_context_synchronously
        "Download Link Provider ${Provider.of<UserProvider>(context, listen: false).downloadUrls}");
  }
  // void changeHeight(BuildContext context) {
  //   widget.onTap.call();
  //   widget.onTap();

  //   setState(() {
  //     height = MediaQuery.of(context).size.height * 1.5;
  //   });
  //   print("height $height");
  // }
}
