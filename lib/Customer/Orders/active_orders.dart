import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/Common/searchbar.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({super.key});

  @override
  State<ActiveOrders> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> orders = []; // List to store orders

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore and update the 'orders' list
    fetchOrders();
  }

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
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ScrollController(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const MySearchBar(title: "Active Orders"),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Order order = orders[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IndividualPage(
                            receiverName: order.tName.toString(),
                          ),
                        ));
                      },
                      child: Card(
                        child: ListTile(
                          // isThreeLine: true,
                          leading: Icon(
                            Icons.check,
                            color: order.status == "pending"
                                ? Theme.of(context).primaryColorLight
                                : Colors.green,
                          ),
                          title: Text(
                              "${order.tailorShop.toString()} (B-${order.bookId})"),
                          subtitle: Text(order.cOrderList),
                          trailing: Text(
                            order.status,
                            style: TextStyle(
                                fontSize: 15,
                                color: order.status == "pending"
                                    ? Theme.of(context).primaryColorLight
                                    : Colors.green),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
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
