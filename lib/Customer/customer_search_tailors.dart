import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
import 'package:tailor_flutter/Common/searchbar.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';

class TailorListFromCustomer extends StatefulWidget {
  const TailorListFromCustomer({super.key});

  @override
  State<TailorListFromCustomer> createState() => _TailorListFromCustomerState();
}

class _TailorListFromCustomerState extends State<TailorListFromCustomer> {
  List<Map<String, dynamic>> tailorData = [];
  TextEditingController textEditingController = TextEditingController();
  List<Map<String, dynamic>> filteredTailorList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTailorData("India");
  }

  Future<void> fetchTailorData(String area) async {
    List<Map<String, dynamic>> result = await getTailorInArea2(area);
    setState(() {
      tailorData = result;
      isLoading = false;
    });
  }

  void filterTailorList(String searchQuery) {
    setState(() {
      filteredTailorList = tailorData
          .where((tailor) =>
              tailor['name']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              tailor['shop_name']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              tailor['location']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
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
            MySearchBar(
              textEditingController: textEditingController,
              title: "Search Tailors Near You",
              voidCallback: () {
                filterTailorList(textEditingController.text);
              },
            ),
            Expanded(
              child: isLoading
                  ? _buildLoadingShimmer()
                  : _buildTailorListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTailorListView() {
    return ListView.builder(
      itemCount: filteredTailorList.isNotEmpty
          ? filteredTailorList.length
          : tailorData.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> tailorInfo = filteredTailorList.isNotEmpty
            ? filteredTailorList[index]
            : tailorData[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IndividualPage(
                  receiverName: tailorInfo['name'],
                  receiverID: tailorInfo['uid'],
                  shopName: tailorInfo['shop_name'],
                  location: tailorInfo['location'],
                  tId: "T-00${tailorInfo['t_id']}",
                ),
              ));
            },
            child: Card(
              child: ListTile(
                title: Text(tailorInfo['name'] ?? 'TailorName'),
                subtitle: Text(tailorInfo['shop_name'] ?? 'Tailor Shop'),
                trailing: Text(tailorInfo['location'] ?? 'Tailor Location'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // You can adjust the number of shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Container(
                  width: 100.0,
                  height: 16.0,
                  color: Colors.white,
                ),
                subtitle: Container(
                  width: 150.0,
                  height: 12.0,
                  color: Colors.white,
                ),
                trailing: Container(
                  width: 80.0,
                  height: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tailor_flutter/Chat%20Page/chatpage.dart';
// import 'package:tailor_flutter/FireBase/firebase.dart';

// class TailorListFromCustomer extends StatefulWidget {
//   const TailorListFromCustomer({super.key});

//   @override
//   State<TailorListFromCustomer> createState() => _TailorListFromCustomerState();
// }

// class _TailorListFromCustomerState extends State<TailorListFromCustomer> {
//   List<Map<String, dynamic>> tailorData = [];
//   TextEditingController textEditingController = TextEditingController();
//   List<Map<String, dynamic>> filteredTailorList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTailorData("India");
//   }

//   Future<void> fetchTailorData(String area) async {
//     List<Map<String, dynamic>> result = await getTailorInArea2(area);
//     setState(() {
//       tailorData = result;
//     });
//   }

//   void filterTailorList(String searchQuery) {
//     setState(() {
//       filteredTailorList = tailorData
//           .where((tailor) =>
//               tailor['name']!
//                   .toLowerCase()
//                   .contains(searchQuery.toLowerCase()) ||
//               tailor['shop_name']!
//                   .toLowerCase()
//                   .contains(searchQuery.toLowerCase()) ||
//               tailor['location']!
//                   .toLowerCase()
//                   .contains(searchQuery.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       controller: ScrollController(),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             MySearchBar(
//               textEditingController: textEditingController,
//               title: "Search Tailors Near You",
//               voidCallback: () {
//                 // No need to fetchTailorData here, just filter the existing data
//                 filterTailorList(textEditingController.text);
//               },
//             ),
//              SizedBox(
//               height: 1000,
//               width: 600,
//               child: _buildLoadingShimmer()) 

              
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredTailorList.isNotEmpty
//                     ? filteredTailorList.length
//                     : tailorData.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> tailorInfo =
//                       filteredTailorList.isNotEmpty
//                           ? filteredTailorList[index]
//                           : tailorData[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => IndividualPage(
//                             receiverName: tailorInfo['name'],
//                             receiverID: tailorInfo['uid'],
//                             shopName: tailorInfo['shop_name'],
//                             location: tailorInfo['location'],
//                             tId: "T-00${tailorInfo['t_id']}",
//                           ),
//                         ));
//                       },
//                       child: Card(
//                         child: ListTile(
//                           title: Text(tailorInfo['name'] ?? 'TailorName'),
//                           subtitle:
//                               Text(tailorInfo['shop_name'] ?? 'Tailor Shop'),
//                           trailing:
//                               Text(tailorInfo['location'] ?? 'Tailor Location'),
//                         ),
//                       ),
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
//    Widget _buildLoadingShimmer() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: ListView.builder(
//         itemCount: 5, // You can adjust the number of shimmer items
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: ListTile(
//                 title: Container(
//                   width: 100.0,
//                   height: 16.0,
//                   color: Colors.white,
//                 ),
//                 subtitle: Container(
//                   width: 150.0,
//                   height: 12.0,
//                   color: Colors.white,
//                 ),
//                 trailing: Container(
//                   width: 80.0,
//                   height: 12.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MySearchBar extends StatelessWidget {
//   const MySearchBar(
//       {super.key,
//       required this.title,
//       this.voidCallback,
//       this.textEditingController});
//   final String title;
//   final VoidCallback? voidCallback;
//   final TextEditingController? textEditingController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 30, top: 10, left: 30, bottom: 10),
//       child: SearchBar(
//         controller: textEditingController,
//         onChanged: (value) {
//           // Trigger search as you type
//           voidCallback?.call();
//         },
//         hintText: title,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: IconButton(
//               onPressed: voidCallback, icon: const Icon(Icons.search)),
//         ),
//       ),
//     );
//   }
// }
