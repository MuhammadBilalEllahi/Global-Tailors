
import 'package:flutter/material.dart';
import 'dart:math' as math;



class ScissorAnimation extends StatefulWidget {
  final int direction;
  // final  VoidCallback showSplashPage;

  const ScissorAnimation({super.key, required this.direction});

  @override
  _ScissorAnimationState createState() => _ScissorAnimationState();
}

class _ScissorAnimationState extends State<ScissorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    

    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds:1),
    );

    _animation = Tween<double>(
      begin: double.parse(widget.direction.toString()), 
      end: widget.direction == 1 ? .1 : -.1, 
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // curve: Curves.fastEaseInToSlowEaseOut,
        curve: ScissorCurve()
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
             
            Transform.rotate(
              angle: _animation.value,
              child: Container(
                width: 200,
                height: 20,
                decoration:  BoxDecoration(
                  color: const Color.fromARGB(255, 78, 77, 77),
                  borderRadius:  BorderRadius.only(
                    // bottomLeft: widget.direction == 1 ? const Radius.elliptical(20, -20) : const Radius.elliptical(-20, 20), // Adjust the radius as needed
                    topLeft: widget.direction == 1 ? const Radius.circular(100) : Radius.zero, 
                    bottomLeft: widget.direction == -1 ? const Radius.circular(100) : Radius.zero, // Adjust the radius as needed
                  ),
                ),
              ),
            ),
            
            
            // Positioned(
            //   right: 80,
            //   left: 80,
            //   child: Container(
            //     color: Colors.amber,
            //     width: 10,
            //     height: 10,
            //   ),
            // ),
           
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class ScissorCurve extends Curve {
  @override
  double transformInternal(double t) {
    return math.sin(t * math.pi );
  }
}
