import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class OutlinedDefaultButton extends StatelessWidget {
  final VoidCallback press;
  final String btnText;

  const OutlinedDefaultButton({
    super.key,
    required this.press,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: kLessPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kShape),
          ),
          side: const BorderSide(
            color: kLightColor,
            style: BorderStyle.solid,
          ),
          foregroundColor: kPrimaryColor,
        ),
        child: Text(btnText.toUpperCase()),
      ),
    );
  }
}
