import 'package:flutter/material.dart';
import 'package:nf_og/model/article.dart';

String countryCode = 'ph';
Map<String, dynamic> userGlbData = {};

//* user articles that has been bookmark
Map<String, dynamic> bmArticles = {};
Map<String, dynamic> allArticles = {};

List<ArticleModel> bm = [];
List<ArticleModel> glbArticles = [];

//* Color constants
const kPrimaryColor = Color(0xFF003366); // Dark blue for header text
const kLightColor = Color(0xFF0277BD); // Slightly lighter blue for content text
const kDarkColor = Color(0xFF242333); // Keep the same dark color
const kAccentColor = Color(0xFF005B96); // Keep the same accent color
const kTransparent = Colors.transparent; // Keep the same transparent color

//* Default appbar height
const kAppBarHeight = 56.0;

//* Default round button radius
const kRadius = 0.0;
const kDefaultRadius = 20.0;

//* Default padding
const kCatPadding = 45.0;
const kBigPadding = 30.0;
const kDefaultPadding = 20.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;

const kShape = 30.0;

//* images path
const String pieChart = 'assets/images/pieChart.png';
const String trophy = 'assets/images/trophy.png';
const String chat = 'assets/images/chat.png';
const String whiteShape = 'assets/images/whitebg.svg';
const String logo = 'assets/images/logo_nf.png';
const String newspaper = 'assets/images/pieChart.png';

//* Head text style
const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

//* Text style constants
const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kPrimaryColor,
);
//below content
const kSmallTextStyle = TextStyle(
  fontSize: 16.0,
  color: kPrimaryColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 22.0,
  color: kPrimaryColor,
);

const kCategoryTextStyle = TextStyle(
  fontSize: 32.0,
  color: kPrimaryColor,
  fontWeight: FontWeight.w500
);

const kLightTextStyle = TextStyle(
  fontSize: 20.0,
  color: kLightColor,
);

bool introShowOnce = false;

//* Intro data map
const List<Map<String, String>> introData = [
  {
    'image': newspaper,
    'headText': 'Your daily newspaper',
    'descText':
        "Read reliable news everyday.",
  },
  {
    'image': trophy,
    'headText': 'Are you informed?',
    'descText': "A lot of things are happening. Read now!",
  },
  {
    'image': chat,
    'headText': 'Be nice to each other.',
    'descText': "Interact with different people and consider their thoughts",
  },
];

//* Validators
String? emailValidator(String? value) {
  if (value!.isEmpty) {
    return 'Must be filled';
  }
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return null;
  }
  return 'Enter correct email';
}

String? passwordValidator(String? value) {
  if (!(value!.length > 5) && value.isNotEmpty) {
    return "Should contain more than 5 characters";
  }

  if (value.isEmpty) {
    return "Should not be empty";
  }
  return null;
}
