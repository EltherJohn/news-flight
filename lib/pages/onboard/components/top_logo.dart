import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(logo),
            height: 190.0,
          ),
          Text(
            'News Flight',
            style: kHeadTextStyle,
          ),
        ],
      ),
    );
  }
}
