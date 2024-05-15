import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class ClearFullButton extends StatelessWidget {
  final String whiteText;
  final String colorText;
  final VoidCallback onPressed;
  
  const ClearFullButton({
    super.key,
    required this.whiteText,
    required this.colorText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: whiteText,
              style: kSubTextStyle,
            ),
            TextSpan(
              text: colorText,
              style: kLightTextStyle
            ),
          ],
        ),
      ),
    );
  }
}
