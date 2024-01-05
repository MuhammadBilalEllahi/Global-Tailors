import 'package:flutter/material.dart';

class FullDimensionContainer extends StatelessWidget {
  const FullDimensionContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}


class MySizedBox extends StatelessWidget {
  const MySizedBox({super.key, required this.val});
  final double val;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width/val,
    );
  }
}