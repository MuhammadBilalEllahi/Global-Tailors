import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailor_flutter/Chat%20Page/Firebase%20Chat/chat_service.dart';
import 'package:tailor_flutter/Chat%20Page/MessageCards/own_message_card.dart';
import 'package:tailor_flutter/Chat%20Page/MessageCards/reply_card.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/provider.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key,
      required this.receiverName,
      this.receiverID,
      this.tId,
      this.shopName,
      this.location});
  final String receiverName;

  final String? receiverID;
  final String? tId;
  final String? shopName;
  final String? location;

  // final ChatModel chatModelInd;
  // final ChatModel sourcePerson;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  TextEditingController controller = TextEditingController();
  bool showEmojiKeyboard = false;
  FocusNode focusNodeKeyBoard = FocusNode();
  bool sendButton = true;

  final ChatService chatService = ChatService();
  // String userType = Provider.of<UserProvider>().userType!;

  bool isCustomer = false;
  // widget.tId!.isNotEmpty;

  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      await chatService
          .sendMessage(widget.receiverID.toString(), controller.text, true)
          .then((value) {
        controller.clear();
      });
    }
  }

  @override
  void initState() {
    // Access userType in initState
    String? userType =
        Provider.of<UserProvider>(context, listen: false).userType;
    // Set isCustomer based on userType
    isCustomer = (userType == 'Customer');

    super.initState();
    focusNodeKeyBoard.addListener(() {
      if (focusNodeKeyBoard.hasFocus) {
        setState(() {
          showEmojiKeyboard = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/bg.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            bottom: isCustomer
                ? PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(widget.shopName!),
                          subtitle: Text(widget.location!),
                          trailing: Text(widget.tId!),
                        ),
                      ),
                    ),
                  )
                : PreferredSize(
                    preferredSize: const Size(0, 0),
                    child: Container(),
                  ),
            leadingWidth: 70,
            titleSpacing: 0,
            backgroundColor: Theme.of(context).canvasColor.withAlpha(215),
            leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        // widget.chatModelInd.isGroup
                        // ? 'assets/groups.svg'
                        // :
                        'assets/person.svg',
                        height: 36,
                        width: 36,
                      ))
                ])),
            title: clickOnChatName(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              popUpMenuInChat()
            ],
          ),
          body: ChatBody(context),
        ),
      ],
    );
  }

  SizedBox ChatBody(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 1.15;
    print("Height >>>>>>>>>>>>> $height");
    print(
        "Height >>>>>>>>>>>>> ${height + height - MediaQuery.of(context).size.height}");
    final heightInvert =
        height + (height - MediaQuery.of(context).size.height) - 20;
    return SizedBox(
        height: height + 1,
        width: MediaQuery.of(context).size.width,
        // color: Colors.amber,
        child: WillPopScope(
            child: Stack(
              // fit: StackFit.expand,
              children: [
                SizedBox(height: heightInvert, child: _buildMessgeList()

                    // ListView(
                    //   shrinkWrap: true,
                    //   children: const [
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //     OwnMessageCard(),
                    //     ReplyMessageCard(),
                    //   ],
                    // ),
                    ),
                messageBoxRow(context),
              ],
            ),
            onWillPop: () {
              if (showEmojiKeyboard) {
                setState(() {
                  showEmojiKeyboard = false;
                });
              } else {
                Navigator.of(context).pop();
              }
              return Future.value(false);
            }));
  }

  Widget _buildMessgeList() {
    return StreamBuilder(
        stream: chatService.getMessage(
          widget.receiverID.toString(),
          firebaseAuth.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          print("hi ${snapshot.data}");
          print("Sup1 ${firebaseAuth.currentUser!.uid}");
          print("Sup2 ${widget.receiverName.toString()}");

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                print(document);
                return _buildMessgeItem(document);
              }).toList(),
            );
          }
        });
  }

  Widget _buildMessgeItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    // var alignment = ((data['senderID'] == firebaseAuth.currentUser!.uid)
    //     ? Alignment.centerRight
    //     : Alignment.centerLeft) ;
    print("fgfgfgfg${data['senderEmail']}");
    print("${data['message']}");
    bool isOwnMessage = (data['senderID'] == firebaseAuth.currentUser!.uid);
    print("${data['senderEmail']}");
    print("${data['message']}");

    return isOwnMessage
        ? OwnMessageCard(
            name: data['senderEmail'],
            text: data['message'],
            timestamp: data['timestamp'],
          )
        : ReplyMessageCard(
            name: data['senderEmail'],
            text: data['message'],
            timestamp: data['timestamp'],
            isNormal: data['isNormal'] ?? true,
            uid: widget.receiverID,
          );
  }

  Align messageBoxRow(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Card(
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            sendButton = true;
                          });
                        } else {
                          setState(() {
                            sendButton = false;
                          });
                        }
                      },
                      onTap: () => focusNodeKeyBoard.requestFocus(),
                      focusNode: focusNodeKeyBoard,
                      controller: controller,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      keyboardAppearance: Brightness.dark,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter a message",
                          contentPadding: const EdgeInsets.all(20),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.emoji_emotions),
                            onPressed: () {
                              setState(() {
                                if (!showEmojiKeyboard) {
                                  focusNodeKeyBoard.requestFocus();
                                  focusNodeKeyBoard.canRequestFocus = false;
                                }
                                setState(() {
                                  showEmojiKeyboard = !showEmojiKeyboard;
                                });
                              });
                            },
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isCustomer
                                  ? IconButton(
                                      icon:
                                          const Icon(Icons.navigation_outlined),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyDialog(
                                              chatService: chatService,
                                              receiverID: widget.receiverID!,
                                            );
                                          },
                                        );

                                        // showModalBottomSheet(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return  MyBottomSheet();
                                        //   },
                                        // );
                                      },
                                    )
                                  : Container(),
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (builder) => bottomSheet(context),
                                  );
                                },
                              ),
                              IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: () {
                                    // const Camera();
                                  })
                            ],
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    right: 5,
                    left: 2,
                  ),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color.fromARGB(255, 126, 126, 126),
                      child: IconButton(
                        icon: Icon(sendButton ? Icons.send_sharp : Icons.mic),
                        onPressed: () {
                          sendMessage(); /////////////////////////////////////////////////////////////////////////////////////////////////
                        },
                      )),
                ),
              ],
            ),
            showEmojiKeyboard
                ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: EmojiKeyboard(
                        emotionController: controller,
                        emojiKeyboardHeight:
                            (MediaQuery.sizeOf(context).height / 3) + 60,
                        showEmojiKeyboard: true,
                        darkMode: true,
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  InkWell clickOnChatName() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.receiverName,
              style:
                  const TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
            ),
            // widget.receiverName,
            const Text(
              "Last seen today at 2:30",
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuButton<String> popUpMenuInChat() {
    return PopupMenuButton<String>(
        onSelected: (value) => print(value),
        // padding: EdgeInsets.fromLTRB(8, 8, 15, 8),
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem(
              value: "View Contact",
              child: Text("View Contact"),
            ),
            PopupMenuItem(
              value: "Media, Links, and Docs",
              child: Text("Media, Links, and Docs"),
            ),
            PopupMenuItem(
              value: "Whatsapp Web",
              child: Text("Whatsapp Web"),
            ),
            PopupMenuItem(
              value: "Search",
              child: Text("Search"),
            ),
            PopupMenuItem(
              value: "Mute Notifications",
              child: Text("Mute Notifications"),
            ),
            PopupMenuItem(
              value: "Wallpaper",
              child: Text("Wallpaper"),
            ),
          ];
        });
  }
}

Widget bottomSheet(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.width / 1.35,
    width: MediaQuery.of(context).size.width - 50,
    child: Card(
      color: Colors.white,
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                    Icons.insert_drive_file, "document", Colors.indigo),
                const SizedBox(
                  width: 40,
                ),
                IconButton(
                    onPressed: () {
                      // const Camera()
                    },
                    icon:
                        iconCreation(Icons.camera_alt, "camera", Colors.pink)),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.insert_photo, "document", Colors.purple)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, "Audio", Colors.orange),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.location_pin, "Location", Colors.teal),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.person, "Person", Colors.blue)
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget iconCreation(IconData icon, String text, Color color) {
  return InkWell(
      onTap: () {},
      child: Column(children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ]));
}

class MeasurementItem {
  final String key;
  final dynamic value;

  MeasurementItem({required this.key, required this.value});
  @override
  String toString() {
    return '$key: $value';
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog(
      {super.key, required this.chatService, required this.receiverID});
  final ChatService chatService;
  final String receiverID;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  // Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // List to store Firestore items
  List<MeasurementItem> firestoreItems = [];

  // List to keep track of selected items
  List<MeasurementItem> selectedItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch items from Firestore when the dialog is created
    fetchFirestoreItems();
  }

  Future<void> fetchFirestoreItems() async {
    // Replace 'your_collection' with the actual collection name in your Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("measurements")
        .get();

    setState(() {
      // Map Firestore items to a List of MeasurementItem
      firestoreItems = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
            List<MeasurementItem> items = [];
            doc.data().forEach((key, value) {
              items.add(MeasurementItem(key: key, value: value));
            });
            return items;
          })
          .expand((items) => items)
          .toList();
    });
  }

  void sendMessage() async {
    if (selectedItems.isNotEmpty) {
      await widget.chatService
          .sendMessage(
              widget.receiverID.toString(), selectedItems.toString(), false)
          .then((value) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Measurements to Send'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (MeasurementItem item in firestoreItems)
                CheckboxListTile(
                  title: Text('${item.key}: ${item.value}'),
                  value: selectedItems.contains(item),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        if (value) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      }
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle sending selected items
            print('Selected Items: $selectedItems');
            sendMessage();
            Navigator.pop(context);
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
