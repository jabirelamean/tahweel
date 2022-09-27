import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, this.label, this.controller, this.type, this.validate, this.maxLength})
      : super(key: key);
  final String? label;
  final TextEditingController? controller;
  final TextInputType? type;
  //final Function(String value)? validate;
  final String? Function(String?)? validate;
  final int? maxLength;


  //final String? validateMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      controller: controller,
      keyboardType: type,
      validator: validate,
      maxLines: 1,
      maxLength: maxLength,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return '$validateMessage';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        label: Text(label!),
        // prefix: Icon(
        //   Icons.title,
        //   color: Colors.grey,
        // ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}
