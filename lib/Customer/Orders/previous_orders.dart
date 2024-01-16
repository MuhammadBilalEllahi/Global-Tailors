import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/Common/searchbar.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class PreviousOrdersCustomer extends StatefulWidget {
  const PreviousOrdersCustomer({super.key});

  @override
  State<PreviousOrdersCustomer> createState() => _PreviousOrdersCustomerState();
}

class _PreviousOrdersCustomerState extends State<PreviousOrdersCustomer> {
  List<Order> orders = []; // List to store orders

  void fetchOrders() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('customer_order')
        .get();
    print("Query : ${querySnapshot.docs}");
    List<Order> orderList = [];

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Order order = Order(
        cUid: document["c_uid"],
        tUid: document["t_uid"],
        tName: document["t_name"],
        cOrderList: document["c_order_list"],
        status: document["status"],
        bookId: document["book_id"],
        tailorShop: document["tailor_shop"],
        tailorLocation: document["tailor_location"],
        tId: document["t_id"],
        timestamp: document["timestamp"],
      );

      orderList.add(order);
    }

    setState(() {
      orders = orderList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ScrollController(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const MySearchBar(title: "Previous Orders"),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: Text("Filter +"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Order order = orders[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text(timeConvert(order.timestamp.toString())),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => IndividualPage(
                                        receiverName: order.tName,
                                        receiverID: order.tUid,
                                        tId: order.cUid,
                                        shopName: order.tailorShop,
                                        location: order.tailorLocation,
                                      )));
                            },
                            child: Card(
                              child: ListTile(
                                leading: TextSized(
                                  text: order.bookId.toString(),
                                  fontSize: 15,
                                ),
                                title: TextSized(
                                  text:
                                      "${order.tName.toString()} Shop:${order.tailorShop.toString()}",
                                  fontSize: 17,
                                ),
                                subtitle: TextSized(
                                  text: order.cOrderList.toString(),
                                  fontSize: 13,
                                ),
                                trailing: TextSized(
                                    text:
                                        "${order.tId.toString()} \n ${order.tailorLocation.toString()}",
                                    fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
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

  String formatedDate = "${postConverted.toDate().year}";
  //  formatedDate = postConverted.toDate().toString().splitMapJoin(pattern);
  return formatedDate;
}

class Order {
  final String cUid;
  final String tUid;
  final String tName;
  final String cOrderList;
  final String status;
  final String bookId;
  final String tailorShop;
  final String tailorLocation;
  final String tId;
  final Timestamp timestamp;

  Order({
    required this.cUid,
    required this.tUid,
    required this.tName,
    required this.cOrderList,
    required this.status,
    required this.bookId,
    required this.tailorShop,
    required this.tailorLocation,
    required this.tId,
    required this.timestamp,
  });
}
