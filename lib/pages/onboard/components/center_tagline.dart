import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class CenterTagLine extends StatelessWidget {
  const CenterTagLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 96.0),
            child: const Divider(
              color: kPrimaryColor,
              thickness: 1.5,
            ),
          ),
          const Text(
            'Presents Factual, and Reliable News Online.',
            style: kSubTextStyle,
          ),
        ],
      ),
    );
  }
}