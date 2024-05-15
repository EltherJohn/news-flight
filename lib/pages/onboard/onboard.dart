import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/intro/components/empty_appbar.dart';
import 'package:nf_og/pages/onboard/components/bottom_buttons.dart';
import 'package:nf_og/pages/onboard/components/center_tagline.dart';
import 'package:nf_og/pages/onboard/components/top_logo.dart';
import 'package:flutter/material.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kDarkColor,
      appBar: EmptyAppBar(),
      
      body: Column(
        children: [
          TopLogo(),
          CenterTagLine(),
          BottomButtons(),
        ],
      ),
    );
  }
}