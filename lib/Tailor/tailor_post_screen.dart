import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class TailorHome extends StatefulWidget {
  const TailorHome({super.key});

  @override
  State<TailorHome> createState() => _TailorHomeState();
}

class _TailorHomeState extends State<TailorHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).canvasColor.withAlpha(23),
        child: Column(
          children: [
            Flexible(
                child: FutureBuilder(
                    future: firestore.collection('tailor_posts').get(),

                    // .collection('posts')
                    // .doc()
                    // .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("Loading");
                      }
                      if (snapshot.hasError) {
                        return Text("Error : ${snapshot.error}");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      if (snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>>? querySnapshot =
                            snapshot.data;

                        // List<int> indices = List<int>.generate(
                        //     querySnapshot!.docs.length, (index) => index);

                        // indices.shuffle();

                        return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: querySnapshot!.docs.length,
                            itemBuilder: (context, index) {
                              // var uidForPost = querySnapshot
                              //     .docChanges[indices[index]].doc.id;
                              var uidForPost =
                                  querySnapshot.docChanges[index].doc.id;

                              return StreamBuilder(
                                  stream: firestore
                                      .collection('tailor_posts')
                                      .doc(uidForPost)
                                      .collection("posts")
                                      .orderBy('timestamp', descending: false)
                                      .snapshots(),
                                  builder: (context, postSnapshot) {
                                    if (postSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // return const Center(
                                      //   child: CircularProgressIndicator
                                      //       .adaptive(),
                                      // );
                                    }

                                    if (postSnapshot.hasError) {
                                      return Text(
                                          "Error : ${postSnapshot.error}");
                                    }

                                    if (!postSnapshot.hasData ||
                                        postSnapshot.data == null) {
                                      return const Text("");
                                    }

                                    QuerySnapshot<Map<String, dynamic>>
                                        postsSnapshot = postSnapshot.data!;

                                    return Column(
                                      children:
                                          postsSnapshot.docs.map((postDoc) {
                                        var post = postDoc.data();
                                        print("Post doc id ${postDoc.id}");
                                        return Post(
                                            context, uidForPost, postDoc.id,
                                            tid: post['T-ID'],
                                            title: post['title'],
                                            content: post['content'],
                                            img: post['img'],
                                            timestamp:
                                                timeConvert(post['timestamp']));
                                      }).toList(),
                                    );
                                  });
                            });
                      }
                      return const Text("");
                    }))
          ],
        ));
  }

  String timeConvert(timestamp) {
    final int seconds =
        int.parse(timestamp.toString().substring(18, 28)); // 1621176915
    final int nanoseconds = int.parse(timestamp
        .toString()
        .substring(42, timestamp.toString().lastIndexOf(')'))); // 276147000
    final Timestamp postConverted = Timestamp(seconds, nanoseconds);

    print("Time pC----------:$postConverted");
    print("Time pC----------:${postConverted.toDate()}");

    int hour = postConverted.toDate().hour;
    String amPm = hour >= 12 ? 'pm' : 'am';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    String formattedHour = hour.toString().padLeft(2, '0');

    String formatedDate =
        "$formattedHour:${postConverted.toDate().minute} ${postConverted.toDate().hour > 12 ? "pm" : "am"}  ${postConverted.toDate().day} /${postConverted.toDate().month}/ ${postConverted.toDate().year}";
    //  formatedDate = postConverted.toDate().toString().splitMapJoin(pattern);
    return formatedDate;
  }

  Padding Post(BuildContext context, String uidForPost, String id,
      {required tid,
      required title,
      required content,
      required img,
      required timestamp}) {
    String Tid = tid;
    String Title = title;
    String Content = content;
    String ImageUrl = img;
    String Timestamps = timestamp;

    bool hasImage = false;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).canvasColor.withAlpha(150),
        ),

        // height: 500,
        // height: MediaQuery.of(context).size.height / 1.9,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              child: ListTile(
                // contentPadding: EdgeInsets.all(10),
                leading: TextSized(
                  text: Tid,
                  fontSize: 20,
                ),
                subtitle: TextSized(
                  text: Timestamps.toString(),
                  fontSize: 13,
                ),
                minLeadingWidth: 20,
                trailing: CircleAvatar(
                  // backgroundImage: ,
                  // radius: 20,
                  child: hasImage
                      // ignore: dead_code
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "")), //img to be here from fututre builder
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/tailor.png")),
                          ),
                        ),
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextSized(
                  text: Title,
                  fontSize: 24,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextSized(
                  text: Content,
                  fontSize: 17,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            NewsFeeedPost(
                imageUrl: ImageUrl, uidForPost: uidForPost, uidForSubPost: id),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NewsFeeedPost extends StatefulWidget {
  NewsFeeedPost({
    super.key,
    required this.imageUrl,
    required this.uidForPost,
    required this.uidForSubPost,
  });
  String imageUrl;
  String uidForPost;
  String uidForSubPost;

  @override
  State<NewsFeeedPost> createState() => _NewsFeeedPostState();
}

class _NewsFeeedPostState extends State<NewsFeeedPost> {
  bool isLiked = false;
  final commentEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: Theme.of(context).primaryColorDark,
            width: MediaQuery.of(context).size.width - 40,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder(
                stream: firestore
                    .collection('tailor_posts')
                    .doc(widget.uidForPost)
                    .collection("posts")
                    .doc(widget.uidForSubPost)
                    .snapshots(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    // return const Center(
                    //   child: CircularProgressIndicator.adaptive(),
                    // );
                  }

                  if (postSnapshot.hasError) {
                    return Text("Error: ${postSnapshot.error}");
                  }

                  if (!postSnapshot.hasData || postSnapshot.data == null) {
                    return const Text("Loading..");
                  }

                  var postData = postSnapshot.data!;

                  int likes = postData['like'] ?? 0;

                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            DocumentReference<Map<String, dynamic>> postRef =
                                firestore
                                    .collection('tailor_posts')
                                    .doc(widget.uidForPost)
                                    .collection("posts")
                                    .doc(widget.uidForSubPost);

                            var increment = isLiked
                                ? FieldValue.increment(1)
                                : FieldValue.increment(-1);

                            postRef.update(
                              {
                                'like': increment,
                              },
                            );
                          });
                        },
                        icon: isLiked
                            ? const Icon(Icons.thumb_up_alt_rounded)
                            : const Icon(Icons.thumb_up_alt_outlined),
                      ),
                      Text(
                        likes.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              // color: Colors.grey.shade800,
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              child: TextField(
                  autofocus: false,
                  controller: commentEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // borderSide: BorderSide(strokeAlign: 2, style: BorderStyle.solid, color: Colors.white70)
                    ),
                    // label: Text("Comment")
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: isLiked
                      ? const Icon(Icons.share)
                      : const Icon(Icons.comment)),
            ),
          ],
        )
      ],
    );
  }
}




//                   Timestamp generateRandomTimestamp() {
//                     final now = Timestamp.now();
//                     const sevenWeeksInMillis =
//                         7 * 7 * 24 * 60 * 60 * 1000; // 7 weeks in milliseconds

//                     final random = Random();
//                     final randomMillis = random.nextInt(sevenWeeksInMillis);

//                     final randomTimestamp =
//                         now.toDate().add(Duration(milliseconds: randomMillis));

//                     return Timestamp.fromDate(randomTimestamp);
//                   }

// // Usage
//                   DocumentReference<Map<String, dynamic>> postRef = firestore
//                       .collection('tailor_posts')
//                       .doc(widget.uidForPost)
//                       .collection("posts")
//                       .doc(widget.uidForSubPost);
//                   var increment = isLiked
//                       ? FieldValue.increment(1)
//                       : FieldValue.increment(-1);
// // Add a random timestamp
//                   // postRef.update({
//                   //   'timestamp': generateRandomTimestamp(),
//                   // });
//                   // postRef.update(
//                   //   {
//                   //     'like': increment,
//                   //   },
//                   // );