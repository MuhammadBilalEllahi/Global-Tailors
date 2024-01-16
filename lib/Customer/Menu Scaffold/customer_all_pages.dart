import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tailor_flutter/Customer/Orders/active_orders.dart';
import 'package:tailor_flutter/Customer/Orders/previous_orders.dart';
import 'package:tailor_flutter/Customer/customer_search_tailors.dart';
import 'package:tailor_flutter/Customer/measurement.dart';
import 'package:tailor_flutter/Common/profile_settings.dart';

class CustomerStartPage extends StatefulWidget {
  const CustomerStartPage({super.key});

  @override
  State<CustomerStartPage> createState() => _CustomerStartPageState();
}

class _CustomerStartPageState extends State<CustomerStartPage> {
  int activeStep = 0;
  int _selectedIndex = 3;

  final List<Widget> _pages = [
    const PreviousOrdersCustomer(),
    const ActiveOrders(),
    const TailorListFromCustomer(),
    const MeasurementCustomer(),
    const ProfileSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: isKeyboardOpen
          ? Container()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GNav(
                rippleColor: Colors.red.shade200,
                hoverColor: Colors.grey.shade100,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 700),
                tabBackgroundColor: Colors.grey.shade800,
                color: Colors.white,
                backgroundColor: Colors.black87,
                tabs: const [
                  GButton(
                    icon: LineIcons.history,
                    text: 'History',
                    gap: 0,
                  ),
                  GButton(
                    icon: LineIcons.addToShoppingCart,
                    text: 'Orders',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    // gap: 1,
                    leading: CircleAvatar(
                        // minRadius: 0,
                        maxRadius: 12,
                        backgroundColor: Colors.transparent,
                        child: ImageIcon(
                          AssetImage(
                            "assets/measure_icon.png",
                          ),
                          color: Colors.white,
                          size: 50,
                        )),
                    icon: LineIcons.accessibleIcon,
                    text: 'Mesaure',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
    );
  }
}


//only andriod
//shaered preference
//startup
// cms 
// api endpoints (can also be with firebase)
// custom theme 
// Backend(),
// backend controls 
// ads atleast 10
// Notifications(),
// Unique 
// firebase/ 




 /**? */
            // SafeArea(
            //   child: MyEasyStepper(),
            // ),
//  EasyStepper MyEasyStepper() {
//     return EasyStepper(
//                   activeStep: activeStep,
                  
//                   stepShape: StepShape.circle,
//                   stepBorderRadius: 10,
//                   borderThickness: 2,
                  
//                   stepRadius: 28,
//                   finishedStepBorderColor: const Color.fromARGB(255, 26, 74, 35),
//                   finishedStepTextColor: Colors.deepOrange,
//                   finishedStepBackgroundColor: Colors.deepOrange,
//                   activeStepIconColor: Colors.deepOrange,
//                   showLoadingAnimation: true,
//                   steps: [
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 0 ? 1 : 0.3,
//                           // child: Image.asset('assets/1.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 1',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 1 ? 1 : 0.3,
//                           // child: Image.asset('assets/2.png'),
//                           child: const Text("1"),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 2',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 2 ? 1 : 0.3,
//                           // child: Image.asset('assets/3.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 3',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 3 ? 1 : 0.3,
//                           // child: Image.asset('assets/4.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 4',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 4 ? 1 : 0.3,
//                           // child: Image.asset('assets/5.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 5',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                   onStepReached: (index) => setState(() => activeStep = index),
//                 );
//   }
