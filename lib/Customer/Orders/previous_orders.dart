
import 'package:flutter/material.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/Common/searchbar.dart';

class PreviousOrdersCustomer extends StatefulWidget {
  const PreviousOrdersCustomer({super.key});

  @override
  State<PreviousOrdersCustomer> createState() => _PreviousOrdersCustomerState();
}

class _PreviousOrdersCustomerState extends State<PreviousOrdersCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ScrollController(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:   Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const MySearchBar(title: "Previous Orders"),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: Text("Filter +"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, snapshot) {
                    return   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("202$snapshot"),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  const IndividualPage(receiverName: "TailorX",)));
                            },
                            child:  Card(
                              child: ListTile(
                                leading: Text("B-280$snapshot"),
                                title: const Text("Tailor Name"),
                                subtitle:  const Text("Tailor Shop"),
                                trailing:  Text("Tailor Id : T-101$snapshot\nTailor Location"),
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