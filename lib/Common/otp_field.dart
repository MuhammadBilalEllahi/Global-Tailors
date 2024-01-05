import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class myOTPField extends StatelessWidget {
  const myOTPField({
    super.key,
    required TextEditingController textEditingController,
    required this.label,
    required this.obscureTextBool,
    required this.focus, required this.validator, this.readOnly =false, this.inputFormatters, this.inputBorder, required this.focusNode, this.nextFocusNode ,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String label;
  final bool focus;
  final bool obscureTextBool;
  final FormFieldValidator? validator;
  final bool readOnly ;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
    final FocusNode focusNode;
  final FocusNode? nextFocusNode;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: SizedBox(
       width: 45,
       height: 60,
        child: TextFormField(
          
          style: MaterialStateTextStyle.resolveWith((states) => const TextStyle(
            color: Colors.black,
            decorationColor: Colors.amber
          )),
          controller: _textEditingController,
          autofocus: focus,
          validator: validator,
          readOnly: readOnly ,
          
          // style: GoogleFonts.abel(),
          obscureText: obscureTextBool,
          // textInputAction: textInputType,
          inputFormatters: inputFormatters,
           onChanged: (value) {
               if (value.length == 1 && focusNode.hasFocus) {
              focusNode.unfocus();
              nextFocusNode?.requestFocus(); // Move focus to the next field
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.green,
            // error: ,
            errorStyle:  const TextStyle(
              color: Colors.redAccent,
              fontSize: 10
            ),
            // iconColor: Colors.blue,
            
            
            border:  inputBorder ?? const UnderlineInputBorder() ,
            label: Text(label , style: const TextStyle(fontSize: 16),),
            
            
            //  focusColor: Colors.amber
          ),
        ),
      ),
    );
  }
}
