// import 'package:firebase_messaging/firebase_messaging.dart';

// void main() async {
  


//   // Inside the onMessageOpenedApp callback


// // Define the function to navigate to a specific page based on the notification
// void navigateToPageBasedOnNotification(RemoteMessage message) {
//   // Extract information from the message and navigate accordingly
//   // For example, you can use the Navigator to push a new page
//   // Use MaterialApp's navigatorKey if needed: Navigator.of(navigatorKey.currentContext, rootNavigator: true).push(...)
// }








// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// // import 'package:flutter/animation.dart';

// // void main(List<String> args) {
// //   runApp(MaterialApp(home: SplashStarterPage(showAuthPage: () {},)));
// // }

// // class SplashStarterPage extends StatefulWidget {
// //   const SplashStarterPage({super.key, required this.showAuthPage});
// //   final VoidCallback showAuthPage;

// //   @override
// //   State<SplashStarterPage> createState() => _SplashStarterPageState();
// // }

// // class _SplashStarterPageState extends State<SplashStarterPage> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Future.delayed(const Duration(seconds: 3)).then((value) {
// //     //   widget.showAuthPage();
// //     // });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(
// //       body: AnimatedScissorAnimation(),
// //     );
// //   }
// // }

// // class AnimatedScissorAnimation extends StatefulWidget {
// //   const AnimatedScissorAnimation({super.key});

// //   @override
// //   _AnimatedScissorAnimationState createState() =>
// //       _AnimatedScissorAnimationState();
// // }

// // class _AnimatedScissorAnimationState extends State<AnimatedScissorAnimation>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 10),
// //     );

// //     _animation = Tween<double>(
// //       begin: 1,
// //       end: -1,
// //     ).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: Curves.linear,
// //       ),
// //     );

// //     _controller.repeat(reverse: false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _animation,
// //       builder: (context, child) {
// //         return Transform.translate(
// //           offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
// //           child: Center(
// //             child: Stack(
// //               children: [
// //                 const ScissorAnimation(direction: 0.5),
// //                 const ScissorAnimation(direction: -0.5),
// //                 Container(
// //                   width: 10,
// //                   height: 10,
// //                   decoration: const BoxDecoration(
// //                       color: Color.fromARGB(255, 228, 226, 226),
// //                       borderRadius: BorderRadius.all(Radius.circular(10))),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// // }

// // class ScissorAnimation extends StatefulWidget {
// //   final double direction;

// //   const ScissorAnimation({super.key, required this.direction});

// //   @override
// //   _ScissorAnimationState createState() => _ScissorAnimationState();
// // }

// // class _ScissorAnimationState extends State<ScissorAnimation>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 1),
// //     );

// //     _animation = Tween<double>(
// //       begin: double.parse(widget.direction.toString()),
// //       end: widget.direction == 0.5 ? .1 : -.1,
// //     ).animate(
// //       CurvedAnimation(
// //         parent: _controller,
// //         curve: ScissorCurve(),
// //       ),
// //     );

// //     _controller.repeat(reverse: true);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _animation,
// //       builder: (context, child) {
// //         return Stack(
// //           children: [
// //             Transform.rotate(
// //               angle: _animation.value,
// //               child: Container(
// //                 width: 200,
// //                 height: 20,
// //                 decoration: BoxDecoration(
// //                   color: const Color.fromARGB(255, 78, 77, 77),
// //                   borderRadius: BorderRadius.only(
// //                     topLeft: widget.direction == 0.5
// //                         ? const Radius.circular(100)
// //                         : Radius.zero,
// //                     bottomLeft: widget.direction == -0.5
// //                         ? const Radius.circular(100)
// //                         : Radius.zero,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// // }

// // class ScissorCurve extends Curve {
// //   @override
// //   double transformInternal(double t) {
// //     // Use a sine function for a scissor-like effect
// //     return math.sin(t * math.pi * 1.5);
// //   }
// // }
