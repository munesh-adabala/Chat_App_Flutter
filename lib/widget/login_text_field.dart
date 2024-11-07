import 'package:flutter/material.dart';

import '../utils/textfield_styles.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final FormFieldValidator<String>? formFieldValidator;
  final bool hideText;

  const LoginTextField(
      {super.key,
        required this.textEditingController,
      required this.hintText,
       this.formFieldValidator,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(formFieldValidator!=null){
          return formFieldValidator!(value);
        }
      },
      controller: textEditingController,
      obscureText: hideText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: ThemeTextStyle.loginHintTextStyle,
          border: const OutlineInputBorder()),
    );
  }
}
