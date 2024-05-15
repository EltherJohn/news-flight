import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final dynamic validator;
  final dynamic keyboardType, obscureText;
  final VoidCallback? isObscure;

  const DefaultTextField(
    {
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.obscureText = false,
    this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kShape)),
        color: kAccentColor,
        
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.orange),
          hintText: hintText,
          hintStyle: kSmallTextStyle,
          iconColor: kPrimaryColor,
          fillColor: kAccentColor,
          icon: Icon(
            icon,
          ),
          suffixIcon: (TextInputType.visiblePassword == keyboardType) ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: isObscure,
          ) : null,
        ),
        style: kSmallTextStyle,
        obscureText: obscureText,
      ),
    );
  }
}
