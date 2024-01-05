
import 'package:flutter/material.dart';


class Notifications extends StatelessWidget {
  const Notifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading: CircleAvatar(
                // backgroundImage: ,
                // radius: 20,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit
                          .cover, // Adjust this based on your needs
                      image: NetworkImage(
                          'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                    ),
                  ),
                ),
              ),
              title: Text("Josph ${snapshot.toString()} "),
              subtitle: const Text("has sent Measuremnts"),
              trailing: const Text("9:11 pm"),
            ),
          );
        },
      ),
    );
  }
}
