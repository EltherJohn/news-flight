import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroData extends StatelessWidget {
  //* fields or data of the intro pages
  final String introImage, headText, descText;

  const IntroData({
    super.key,
    required this.introImage,
    required this.headText,
    required this.descText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Stack(
            children: [
              //* Sets svgpicture white background
              SvgPicture.asset(
                whiteShape,
                fit: BoxFit.cover,
              ),
              //* Positioned the picture of the intro page
              Positioned(
                right: 0,
                left: 0,
                top: 175.0,
                child: Image(
                  image: AssetImage(introImage),
                  height: 150,
                ),
              ),
            ],
          ),
        ),
        //* Head text
        Text(
          headText,
          style: kHeadTextStyle,
          textAlign: TextAlign.center,
        ),
        //* Description
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            descText,
            textAlign: TextAlign.center,
            style: kSubTextStyle,
          ),
        )
      ],
    );
  }
}
