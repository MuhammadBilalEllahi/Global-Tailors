
import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    // border: Border(top: BorderSide(), bottom: BorderSide(), left: BorderSide(), right: BorderSide())
                    color: Colors.red),
                child: Image.network( 'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg', fit: BoxFit.fill,),
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}