// import 'package:flutter/material.dart';
// import 'package:tailor_flutter/Tailor/tailor_init.dart';

// class PreviousOrders extends StatelessWidget {
//   const PreviousOrders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         color: Colors.grey.shade200,
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextSized(fontSize: 25, text: 'Orders'),
//             ),
//             // Expanded(
//             //   child:

//             // ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 50,
//                 itemBuilder: (context, snapshot) {
//                   return Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           leading: CircleAvatar(
//                             // backgroundImage: ,
//                             // radius: 20,
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   fit: BoxFit
//                                       .cover, // Adjust this based on your needs
//                                   image: NetworkImage(
//                                       'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           title: Text("Goku ${snapshot.toString()} "),
//                           subtitle: const Text("Hi, yeehow much is the cost?"),
//                           trailing: const Text("9:11 pm"),
//                         ),
//                         // SizedBox(
//                         //   width: MediaQuery.of(context).size.width,
//                         //   child: ,
//                         // )
//                         const Divider()
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class PreviousOrders extends StatelessWidget {
  const PreviousOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).canvasColor,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Orders',
                style: TextStyle(fontSize: 25),
              ),
            ),
            FutureBuilder(
              future: fetchOrders(),
              builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const TextSized(
                    text: 'No orders found.',
                    fontSize: 30,
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Order order = snapshot.data![index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .splashColor
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                                      ),
                                      title: FutureBuilder(
                                        future: fetchCustomerEmail(
                                            order.customerUid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text('Loading...');
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else if (!snapshot.hasData) {
                                            return const Text(
                                                'Unknown Customer');
                                          } else {
                                            return Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextSized(
                                                  text:
                                                      "${snapshot.data.toString()} ",
                                                  fontSize: 17,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                      trailing: TextSized(
                                          text: "Book ID : ${order.bookId}",
                                          fontSize: 18),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 10, 2, 10),
                                        child: TextSized(
                                          text: "Orders \n${order.data}",
                                          fontSize: 13,
                                        ),
                                      ),
                                      // trailing: Text(order.timestamp),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const TextSized(
                                              fontSize: 15, text: "Status: "),
                                          MyElevatedButtom(
                                            fontSize: 15,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Container(
                                                        height: 100,
                                                        color: Theme.of(context)
                                                            .splashColor,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            TextSized(
                                                                textColor: Theme.of(
                                                                        context)
                                                                    .canvasColor,
                                                                fontSize: 18,
                                                                text:
                                                                    "Press Accept To Complete Order"),
                                                            MyElevatedButtom(
                                                                fontSize: 15,
                                                                label: "Accept",
                                                                onPressed:
                                                                    () async {
                                                                  firestore
                                                                      .collection(
                                                                          "users")
                                                                      .doc(firebaseAuth
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          "tailor_orders")
                                                                      .doc(order
                                                                          .customerUid)
                                                                      .update({
                                                                    "status":
                                                                        "completed",
                                                                    "time_complete":
                                                                        Timestamp
                                                                            .now()
                                                                  }).whenComplete(
                                                                          () {
                                                                    print(
                                                                        "okdone");
                                                                  });

                                                                  var query = await firestore
                                                                      .collection(
                                                                          "orders")
                                                                      .doc(order
                                                                          .customerUid)
                                                                      .collection(
                                                                          "customer_order")
                                                                      .where(
                                                                          "data",
                                                                          isEqualTo: order
                                                                              .data)
                                                                      .where(
                                                                          "c_uid",
                                                                          isEqualTo:
                                                                              order.customerUid)
                                                                      .get();

                                                                  for (var doc
                                                                      in query
                                                                          .docs) {
                                                                    await firestore
                                                                        .collection(
                                                                            "orders")
                                                                        .doc(order
                                                                            .customerUid)
                                                                        .collection(
                                                                            "customer_order")
                                                                        .doc(doc
                                                                            .id)
                                                                        .update({
                                                                      "status":
                                                                          "complete",
                                                                      "time_complete":
                                                                          Timestamp
                                                                              .now()
                                                                    });
                                                                  }
                                                                })
                                                          ],
                                                        ),
                                                      ),
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .primaryColorLight,
                                                      title: TextSized(
                                                          textColor:
                                                              Theme.of(context)
                                                                  .canvasColor,
                                                          fontSize: 18,
                                                          text:
                                                              "Do You Want To Complete The Status"),
                                                    );
                                                  });
                                            },
                                            label: order.status,
                                            size: const Size(110, 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Order>> fetchOrders() async {
    try {
      // Fetch orders based on user ID
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("tailor_orders")
          .get();

      List<Order> orders = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String bookId = doc.get("book_id").toString();
        String data = doc.get("data")!.toString();
        String customerUid = doc.get("customer_uid").toString();
        String status = doc.get("status").toString();

        orders.add(Order(
          bookId: bookId,
          data: data,
          status: status,
          customerUid: customerUid,
        ));
      }

      return orders;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> fetchCustomerEmail(String customerUid) async {
    try {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(customerUid)
          .get();

      return customerSnapshot.get("email").toString();
    } catch (error) {
      return "Unknown";
    }
  }
}

class Order {
  final String bookId;
  final String data;
  final String customerUid;
  final String status;

  Order({
    required this.bookId,
    required this.data,
    required this.customerUid,
    required this.status,
  });
}
