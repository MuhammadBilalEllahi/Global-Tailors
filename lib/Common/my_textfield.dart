import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class myTextField extends StatelessWidget {
  const myTextField({
    super.key,
    required TextEditingController textEditingController,
    required this.label,
    required this.obscureTextBool,
    required this.focus,
    required this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.inputBorder,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String label;
  final bool focus;
  final bool obscureTextBool;
  final FormFieldValidator? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
        child: TextFormField(
          style: MaterialStateTextStyle.resolveWith((states) => const TextStyle(
              color: Colors.black, decorationColor: Colors.amber)),
          controller: _textEditingController,
          autofocus: focus,
          validator: validator,
          readOnly: readOnly,

          // style: GoogleFonts.abel(),
          obscureText: obscureTextBool,
          // textInputAction: textInputType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: Colors.green,
            // error: ,
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
            // iconColor: Colors.blue,

            border: inputBorder ?? const UnderlineInputBorder(),
            label: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),

            //  focusColor: Colors.amber
          ),
        ),
      ),
    );
  }
}
class MyPhoneTextField extends StatefulWidget {
  const MyPhoneTextField({
    Key? key,
    required TextEditingController textEditingController,
    required this.label,
    required this.focus,
    required this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.inputBorder,
  }) : _textEditingController = textEditingController, super(key: key);

  final TextEditingController _textEditingController;
  final String label;
  final bool focus;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;

  @override
  State<MyPhoneTextField> createState() => _MyPhoneTextFieldState();
}

class _MyPhoneTextFieldState extends State<MyPhoneTextField> {
   String phoneCode='+93';

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 100,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
        child: InternationalPhoneNumberInput(
          textFieldController: widget._textEditingController,
          onInputValidated: (bool value) {
            if (value) {
              var number = PhoneNumber().phoneNumber;
              print("$number");
              // The input is considered valid, update the textEditingController
              widget._textEditingController.text = "$phoneCode${widget._textEditingController.text}";
              print(widget._textEditingController.text);
              print(value);
            }
          },
          onInputChanged: (PhoneNumber number) {
            phoneCode= number.dialCode!;
            print(phoneCode);
            // Access the entered phone number
            String phoneNumber = number.phoneNumber ?? "";
            print("$phoneNumber and ${widget._textEditingController.text}");


            // Handle phone number changes if needed
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
            useBottomSheetSafeArea: true,
          ),
          keyboardType: TextInputType.phone,
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          textStyle: const TextStyle(color: Colors.black),
          inputDecoration: InputDecoration(
            fillColor: Colors.green,
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
            border: widget.inputBorder ?? const UnderlineInputBorder(),
            labelText: widget.label,
            labelStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
