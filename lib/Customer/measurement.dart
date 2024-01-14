import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_intro_complete_info.dart';

class MeasurementCustomer extends StatefulWidget {
  const MeasurementCustomer({super.key});

  @override
  State<MeasurementCustomer> createState() => _MeasurementCustomerState();
}

class _MeasurementCustomerState extends State<MeasurementCustomer> {
  final TextEditingController neckEditingController = TextEditingController();
  final TextEditingController chestEditingController = TextEditingController();
  final TextEditingController waistEditingController = TextEditingController();
  final TextEditingController hipsEditingController = TextEditingController();
  final TextEditingController shoulderWidthEditingController =
      TextEditingController();
  final TextEditingController sleeveLengthEditingController =
      TextEditingController();
  final TextEditingController bicepEditingController = TextEditingController();
  final TextEditingController wristEditingController = TextEditingController();
  final TextEditingController shirtLengthEditingController =
      TextEditingController();
  final TextEditingController inseamEditingController = TextEditingController();
  final TextEditingController outseamEditingController =
      TextEditingController();
  final TextEditingController thighEditingController = TextEditingController();
  final TextEditingController kneeEditingController = TextEditingController();
  final TextEditingController calfEditingController = TextEditingController();
  final TextEditingController ankleEditingController = TextEditingController();
  final TextEditingController jacketLengthEditingController =
      TextEditingController();
  final TextEditingController crotchDepthEditingController =
      TextEditingController();
  final TextEditingController riseEditingController = TextEditingController();
  @override
  void dispose() {
    // Dispose of all TextEditingController instances
    neckEditingController.dispose();
    chestEditingController.dispose();
    waistEditingController.dispose();
    hipsEditingController.dispose();
    shoulderWidthEditingController.dispose();
    sleeveLengthEditingController.dispose();
    bicepEditingController.dispose();
    wristEditingController.dispose();
    shirtLengthEditingController.dispose();
    inseamEditingController.dispose();
    outseamEditingController.dispose();
    thighEditingController.dispose();
    kneeEditingController.dispose();
    calfEditingController.dispose();
    ankleEditingController.dispose();
    jacketLengthEditingController.dispose();
    crotchDepthEditingController.dispose();
    riseEditingController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getAllMeasurements();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: const Color.fromARGB(255, 149, 145, 145),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextSized(
                text: "Get Your Measurements Done To enjoy Leisure",
                fontSize: 20,
              ),
            ),
            MeasurementCard(
              title: "Neck Size",
              inchEditingController: neckEditingController,
            ),
            MeasurementCard(
              title: "Chest",
              inchEditingController: chestEditingController,
            ),
            MeasurementCard(
              title: "Waist",
              inchEditingController: waistEditingController,
            ),
            MeasurementCard(
              title: "Hips",
              inchEditingController: hipsEditingController,
            ),
            MeasurementCard(
              title: "Shoulder Width",
              inchEditingController: shoulderWidthEditingController,
            ),
            MeasurementCard(
              title: "Sleeve Length",
              inchEditingController: sleeveLengthEditingController,
            ),
            MeasurementCard(
              title: "Bicep",
              inchEditingController: bicepEditingController,
            ),
            MeasurementCard(
              title: "Wrist",
              inchEditingController: wristEditingController,
            ),
            MeasurementCard(
              title: "Shirt Length",
              inchEditingController: shirtLengthEditingController,
            ),
            MeasurementCard(
              title: "Inseam",
              inchEditingController: inseamEditingController,
            ),
            MeasurementCard(
              title: "Outseam",
              inchEditingController: outseamEditingController,
            ),
            MeasurementCard(
              title: "Thigh",
              inchEditingController: thighEditingController,
            ),
            MeasurementCard(
              title: "Knee",
              inchEditingController: kneeEditingController,
            ),
            MeasurementCard(
              title: "Calf",
              inchEditingController: calfEditingController,
            ),
            MeasurementCard(
              title: "Ankle",
              inchEditingController: ankleEditingController,
            ),
            MeasurementCard(
              title: "Jacket Length",
              inchEditingController: jacketLengthEditingController,
            ),
            MeasurementCard(
              title: "Crotch Depth",
              inchEditingController: crotchDepthEditingController,
            ),
            MeasurementCard(
              title: "Rise",
              inchEditingController: riseEditingController,
            ),
            const SizedBox(
              height: 20,
            ),
            MyElevatedButtom(
              onPressed: () {
                if (isNotEmpty()) {
                  Map<String, dynamic> measurements = {
                    "Neck Size": neckEditingController.text,
                    "Chest": chestEditingController.text,
                    "Waist": waistEditingController.text,
                    "Hips": hipsEditingController.text,
                    "Shoulder Width": shoulderWidthEditingController.text,
                    "Sleeve Length": sleeveLengthEditingController.text,
                    "Bicep": bicepEditingController.text,
                    "Wrist": wristEditingController.text,
                    "Shirt Length": shirtLengthEditingController.text,
                    "Inseam": inseamEditingController.text,
                    "Outseam": outseamEditingController.text,
                    "Thigh": thighEditingController.text,
                    "Knee": kneeEditingController.text,
                    "Calf": calfEditingController.text,
                    "Ankle": ankleEditingController.text,
                    "Jacket Length": jacketLengthEditingController.text,
                    "Crotch Depth": crotchDepthEditingController.text,
                    "Rise": riseEditingController.text,
                  };

                  firestore
                      .collection("users")
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("measurements")
                      .doc(firebaseAuth.currentUser!.uid)
                      .set(measurements, SetOptions(merge: true));
                }
              },
              label: "Save All",
              fontSize: 18,
              size: Size(MediaQuery.of(context).size.width / 1.5, 60),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void getAllMeasurements() async {
    try {
      var snapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("measurements")
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (mounted) {
        if (snapshot.exists) {
          Map<String, dynamic> res = snapshot.data() as Map<String, dynamic>;

          neckEditingController.text = res["Neck Size"] ?? "";
          chestEditingController.text = res["Chest"] ?? "";
          waistEditingController.text = res["Waist"] ?? "";
          hipsEditingController.text = res["Hips"];
          shoulderWidthEditingController.text = res["Shoulder Width"] ?? "";
          sleeveLengthEditingController.text = res["Sleeve Length"] ?? "";
          bicepEditingController.text = res["Bicep"] ?? "";
          wristEditingController.text = res["Wrist"] ?? "";
          shirtLengthEditingController.text = res["Shirt Length"] ?? "";
          inseamEditingController.text = res["Inseam"] ?? "";
          outseamEditingController.text = res["Outseam"] ?? "";
          thighEditingController.text = res["Thigh"] ?? "";
          kneeEditingController.text = res["Knee"] ?? "";
          calfEditingController.text = res["Calf"] ?? "";
          ankleEditingController.text = res["Ankle"] ?? "";
          jacketLengthEditingController.text = res["Jacket Length"] ?? "";
          crotchDepthEditingController.text = res["Crotch Depth"] ?? "";
          riseEditingController.text = res["Rise"] ?? "";

          // Notify the framework that the state of the widget has changed
          setState(() {});
        }
      }
    } catch (e) {
      print("Error fetching measurements: $e");
    }
  }

// void getAllMeasurements() async {
//   try {
//     var snapshot = await firestore
//         .collection('users')
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection("measurements")
//         .doc(firebaseAuth.currentUser!.uid)
//         .get();

//     if (snapshot.exists) {
//       Map<String, dynamic> res = snapshot.data() as Map<String, dynamic>;

//       neckEditingController.text = res["Neck Size"] ?? "";
//       chestEditingController.text = res["Chest"] ?? "";
//       waistEditingController.text = res["Waist"] ?? "";
//       hipsEditingController.text = res["Hips"] ?? "";
//       shoulderWidthEditingController.text = res["Shoulder Width"] ?? "";
//       sleeveLengthEditingController.text = res["Sleeve Length"] ?? "";
//       bicepEditingController.text = res["Bicep"] ?? "";
//       wristEditingController.text = res["Wrist"] ?? "";
//       shirtLengthEditingController.text = res["Shirt Length"] ?? "";
//       inseamEditingController.text = res["Inseam"] ?? "";
//       outseamEditingController.text = res["Outseam"] ?? "";
//       thighEditingController.text = res["Thigh"] ?? "";
//       kneeEditingController.text = res["Knee"] ?? "";
//       calfEditingController.text = res["Calf"] ?? "";
//       ankleEditingController.text = res["Ankle"] ?? "";
//       jacketLengthEditingController.text = res["Jacket Length"] ?? "";
//       crotchDepthEditingController.text = res["Crotch Depth"] ?? "";
//       riseEditingController.text = res["Rise"] ?? "";

//       // Notify the framework that the state of the widget has changed
//       setState(() {});
//     }
//   } catch (e) {
//     print("Error fetching measurements: $e");
//   }
// }

  bool isNotEmpty() {
    return neckEditingController.text.isNotEmpty &&
        chestEditingController.text.isNotEmpty &&
        waistEditingController.text.isNotEmpty &&
        hipsEditingController.text.isNotEmpty &&
        shoulderWidthEditingController.text.isNotEmpty &&
        sleeveLengthEditingController.text.isNotEmpty &&
        bicepEditingController.text.isNotEmpty &&
        wristEditingController.text.isNotEmpty &&
        shirtLengthEditingController.text.isNotEmpty &&
        inseamEditingController.text.isNotEmpty &&
        outseamEditingController.text.isNotEmpty &&
        thighEditingController.text.isNotEmpty &&
        kneeEditingController.text.isNotEmpty &&
        calfEditingController.text.isNotEmpty &&
        ankleEditingController.text.isNotEmpty &&
        jacketLengthEditingController.text.isNotEmpty &&
        crotchDepthEditingController.text.isNotEmpty &&
        riseEditingController.text.isNotEmpty;
  }
}

class MeasurementCard extends StatelessWidget {
  const MeasurementCard({
    super.key,
    required this.title,
    required this.inchEditingController,
  });
  final String title;
  final TextEditingController inchEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(50),
          //   // color: const Color.fromARGB(255, 250, 243, 224),
          // ),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image.asset(
              //   filepath,
              //   width: 100,
              //   height: 100,
              // ),
              // const SizedBox(width: 100),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: TextSized(
                    text: title,
                    fontSize: 20,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                child: SizedBox(
                  width: 70,
                  child: TextFormField(
                    controller: inchEditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Inches"),
                  ),
                ),
              ),
              // MyLogoButton(icon: Icons.edit_note_outlined, iconSize: 23, onPressed: () {
              //   String inch = inchEditingController.text ;
              // },)

              IconButton(
                  onPressed: () {
                    print(inchEditingController.text);
                    if (inchEditingController.text.isNotEmpty) {
                      firestore
                          .collection("users")
                          .doc(firebaseAuth.currentUser!.uid)
                          .collection("measurements")
                          .doc(firebaseAuth.currentUser!.uid)
                          .set({
                        title: inchEditingController.text.toString(),
                      }, SetOptions(merge: true));
                    }
                  },
                  icon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark,
                      ),
                      Text("save")
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
