import 'package:flutter/material.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class TailorHome extends StatefulWidget {
  const TailorHome({super.key});

  @override
  State<TailorHome> createState() => _TailorHomeState();
}

class _TailorHomeState extends State<TailorHome> {
  bool isLiked = false;
  final commentEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(),
          ),
          const SizedBox(
            height: 20,
          ),
          Post(context),
          Post(context),
          Post(context),
          Post(context),
          Post(context),
        ],
      ),
    );
  }

  Padding Post(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Theme.of(context).canvasColor.withAlpha(150),
        // height: 500,
        height: MediaQuery.of(context).size.height / 1.9,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: FutureBuilder<String?>(
                future: getTailorIDSnap(),
                builder: (content, snapshot) {
                  //other people tid
                  print(
                      "Tailor ID (lib/Tailor/tailor_bottm_navigation.dart) :  ${snapshot.data}");
                  return TextSized(
                    text: "T-${snapshot.data.toString()}",
                    fontSize: 20,
                    textAlign: TextAlign.left,
                    textColor: Theme.of(context).primaryColorLight,
                  );
                },
              ),
              trailing: CircleAvatar(
                // backgroundImage: ,
                // radius: 20,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover, // Adjust this based on your needs
                      image: NetworkImage(
                          'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            const NewsFeeedPost(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      icon: isLiked
                          ? const Icon(Icons.thumb_up_alt_rounded)
                          : const Icon(Icons.thumb_up_alt_outlined)),
                ),
                SizedBox(
                  // color: Colors.grey.shade800,
                  width: MediaQuery.of(context).size.width - 170,
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
                          ? const Icon(Icons.abc_outlined)
                          : const Icon(Icons.share)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewsFeeedPost extends StatelessWidget {
  const NewsFeeedPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width - 40,
        child: Image.network(
          'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
