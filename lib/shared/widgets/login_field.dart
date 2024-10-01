import 'package:flutter/material.dart';

import 'input_field.dart';

typedef VoidString = Function(String);
typedef StringVoidString = String? Function(String?);

class LoginField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidString onChanged;
  final TextInputType inputType;
  final StringVoidString validator;
  final bool isObscure;
  const LoginField({super.key,
    required this.title,
    required this.controller,
    required this.onChanged,
    required this.validator,
    required this.isObscure,
    required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 7,
          bottom: 7
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16,
                right: 16
            ),
            child: Text(title, style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 15,
                fontFamily: 'Inter')
            ),
          ),
          const SizedBox(height: 14,),
          InputField(
            align: TextAlign.left,
            controller: controller,
            enabled: true,
            onChanged: onChanged,
            validator: validator,
            obscureText: isObscure,
            inputType: inputType, borderEnabled: true,
          )
        ],
      ),
    );
  }
}
