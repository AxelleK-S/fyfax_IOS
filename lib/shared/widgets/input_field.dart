import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef VoidString = Function(String);
typedef StringVoidString = String? Function(String?);

class InputField extends StatelessWidget {
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign align;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool enabled;
  final bool borderEnabled;
  final VoidString onChanged;
  final StringVoidString validator;
  final bool obscureText;
  const InputField(
      {super.key,
      this.label,
      this.suffix,
      this.prefix,
      required this.align,
      required this.controller,
      required this.enabled,
      required this.onChanged,
      required this.validator,
      required this.obscureText,
      required this.inputType,
      required this.borderEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 7, left: 16, right: 16),
      child: TextFormField(
        keyboardType: inputType,
        enabled: enabled,
        textAlign: align,
        style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        obscureText: obscureText,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            enabled: borderEnabled,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            prefixIcon: prefix,
            suffixIcon: suffix,
            labelStyle: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
                fontSize: 12)),
      ),
    );
  }
}
