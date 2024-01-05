import 'package:flutter/material.dart';


class MyElevatedButtom extends StatelessWidget {
   const MyElevatedButtom({super.key, required this.label, required this.fontSize, this.onPressed, this.focusNode, this.size, });

  final double fontSize;
  final String label;
  final FocusNode? focusNode;
  // final Widget val; , required this.val
  final Function()? onPressed;
  final Size? size;


  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
      focusNode: focusNode,
                      onPressed: onPressed,
                      style:   ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(size ?? const Size(150, 30))  ,
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black)),
                      child:  Text(label,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                          )),
                    );
  }
}


// class MyLogoButton extends StatelessWidget {
//    const MyLogoButton({super.key, required this.icon, required this.iconSize, this.onPressed, this.focusNode, });

//   final double iconSize;
//   final IconData icon;
//   final FocusNode? focusNode;
//   // final Widget val; , required this.val
//   final Function()? onPressed;


//   @override
//   Widget build(BuildContext context) {
//     return   ElevatedButton(
//       focusNode: focusNode,
//                       onPressed: onPressed,
//                       style:  const ButtonStyle(
//                           fixedSize: MaterialStatePropertyAll(Size(5,5)),
//                           backgroundColor:
//                               MaterialStatePropertyAll(Color.fromARGB(255, 249, 245, 245))),
//                       child: Icon(icon, size: iconSize ,)
//                     );
//   }
// }