import 'package:flutter/cupertino.dart';

// Here we define our constants such as font styles, colors, sizes, etc..
// as a convention, put k as the first letter of the variable name

// This is used to convert Color to Material Color, like this MaterialColor(<YOUR COLOR>, color)
const Map<int, Color> color = {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};

const Color kPrimaryColor = Color(0xFF00bcd4);
const Color kLightColor = Color(0xAA62efff);
const Color kDarkColor = Color(0xFF008ba3);

const kTitleTextStyle = TextStyle(
  fontSize: 36.0,
  fontFamily: "Times New Roman",
  fontWeight: FontWeight.bold,
);

const kHeading1TextStyle = TextStyle(
  fontSize: 26.0,
  fontFamily: "Times New Roman",
  fontWeight: FontWeight.bold,
);

const kHeading2TextStyle = TextStyle(
  fontSize: 24.0,
  fontFamily: "Times New Roman",
);

const kCaptionTextStyle = TextStyle(fontSize: 18);
