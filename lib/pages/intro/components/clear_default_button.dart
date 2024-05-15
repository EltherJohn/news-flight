import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class ClearDefaultButton extends StatelessWidget {
  //* Method for clicking a button
  final VoidCallback press;
  //* Button text
  final String name;

  const ClearDefaultButton({
    super.key,
    required this.name,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: press,
        child: Text(
          name.toUpperCase(),
          style: const TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
