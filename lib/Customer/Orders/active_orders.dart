
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/Common/searchbar.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({super.key});

  @override
  State<ActiveOrders> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  bool checkStatus =true;
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
                  itemCount: 20,
                  itemBuilder: (context, snapshot) {
                    return   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  const IndividualPage(receiverName: "TailorX",)));
                        },
                        child:  Card(
                          child: ListTile(
                            leading: !checkStatus ? const Icon(Icons.check) : const Icon(Icons.wifi_protected_setup_sharp),
                            title: const Text("Tailor Shop"),
                            subtitle: const Text("Cloth with 2 pent coat"),
                            trailing: const Text("Complete Status"),
                          ),
                        ),
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