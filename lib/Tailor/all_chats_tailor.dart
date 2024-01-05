
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';

class ChatListPage extends StatelessWidget {
 const  ChatListPage({super.key});

//  final String name = "Henry";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade200,
        child: _buildUserList(context)

      ),
    );
  }


Widget _buildUserList(context){
      // print( "Snap shot${firestore.collection('users').snapshots}");


  return StreamBuilder<QuerySnapshot>(stream: firestore.collection('users').snapshots(),
   builder: (context,snapshot){
    if(snapshot.hasError){
      return const Text("No data");
    }
    if(snapshot.connectionState == ConnectionState.waiting){
      return const CircularProgressIndicator();
    }
    return ListView(

        children: 
          snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc,context)).toList()
        
    );
  });
}

                       
                        
}
Widget _buildUserListItem(DocumentSnapshot documentSnapshot, context){
  Map<String,dynamic> data = documentSnapshot.data()! as Map<String,dynamic> ;

  if(firebaseAuth.currentUser!.email != data['email']){
    return Column(
      children: [
        ListTile(
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
          title: Text(data['email']),
          subtitle: const Text("Hi, how much is the cost?"),
          trailing: const Text("9:11 pm"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  IndividualPage(receiverName: data['email'] , receiverID : data['uid'])));
          },
        ),
        const Divider()
      ],
    );
  }
  else {
    // const Divider()
    return Container();
    }
}



      //    ListView.builder(
      //   itemCount: 50,
      //   itemBuilder: (context, snapshot) {
      //     return GestureDetector(
      //       onTap: (){

      //         print("HERe");
      //         // ignore: prefer_const_constructors
      //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>    IndividualPage(name: name,)));
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(2.0),
      //         child: Column(
      //           children: [
      //             ListTile(
      //               leading: CircleAvatar(
      //                 // backgroundImage: ,
      //                 // radius: 20,
      //                 child: Container(
      //                   decoration: const BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     image: DecorationImage(
      //                       fit: BoxFit
      //                           .cover, // Adjust this based on your needs
      //                       image: NetworkImage(
      //                           'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               // ignore: prefer_const_constructors
      //               title:  Text(name),
      //               subtitle: const Text("Hi, how much is the cost?"),
      //               trailing: const Text("9:11 pm"),
      //             ),
      //             // SizedBox(
      //             //   width: MediaQuery.of(context).size.width,
      //             //   child: ,
      //             // )
      //             const Divider()
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),