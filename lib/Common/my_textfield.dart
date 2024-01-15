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
    this.height,
    this.width,
    this.padZero,
    this.keybordType,
    this.validatorForm,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final FormFieldValidator<String>? validatorForm;
  final String label;
  final bool focus;
  final bool obscureTextBool;
  final FormFieldValidator? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final double? height;
  final double? width;
  final double? padZero;
  final TextInputType? keybordType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 90,
      width: width ?? 400,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            padZero ?? 25, padZero ?? 10, padZero ?? 25, padZero ?? 20),
        child: TextFormField(
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          controller: _textEditingController,
          autofocus: focus,
          validator: validatorForm ?? validator,
          readOnly: readOnly,
          keyboardType: keybordType,

          // style: GoogleFonts.abel(),

          obscureText: obscureTextBool,
          // textInputAction: textInputType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColorLight,
            // error: ,

            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
            // iconColor: Colors.blue,

            border: inputBorder ?? const UnderlineInputBorder(),
            label: Text(
              label,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColorLight),
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
    super.key,
    required TextEditingController textEditingController,
    required this.label,
    required this.focus,
    required this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.inputBorder,
  }) : _textEditingController = textEditingController;

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
  String phoneCode = '+93';

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
              widget._textEditingController.text =
                  "$phoneCode${widget._textEditingController.text}";
              print(widget._textEditingController.text);
              print(value);
            }
          },
          onInputChanged: (PhoneNumber number) {
            phoneCode = number.dialCode!;
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
          selectorTextStyle:
              TextStyle(color: Theme.of(context).primaryColorLight),
          textStyle: TextStyle(color: Theme.of(context).primaryColorLight),
          inputDecoration: InputDecoration(
            fillColor: Colors.green,
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
            border: widget.inputBorder ?? const UnderlineInputBorder(),
            labelText: widget.label,
            labelStyle: TextStyle(
                fontSize: 16, color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }
}
