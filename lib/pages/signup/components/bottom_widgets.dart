import 'package:nf_og/pages/signup/components/clear_full_button.dart';
import 'package:nf_og/pages/signup/components/default_button.dart';
import 'package:flutter/material.dart';

class BottomWidgets extends StatelessWidget {
  final String cfbText1, cfbText2;
  final String btnText;
  final VoidCallback onPressed1, onPressed2;
  const BottomWidgets({
    super.key,
    required this.cfbText1,
    required this.cfbText2,
    required this.btnText,
    required this.onPressed1,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClearFullButton(
            colorText: cfbText1,
            onPressed: onPressed1,
            whiteText: cfbText2,
          ),
          DefaultButton(
            btnText: btnText,
            onPressed: onPressed2,
          ),
        ],
      ),
    );
  }
}
