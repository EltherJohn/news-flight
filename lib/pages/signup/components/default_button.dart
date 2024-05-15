import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  const DefaultButton({
    super.key,
    required this.btnText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: kLessPadding),
          backgroundColor: kLightColor,
          foregroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kShape),
          ),
          // shape: Roun
        ),
        child: Text(btnText.toUpperCase()),
      ),
    );
  }
}
