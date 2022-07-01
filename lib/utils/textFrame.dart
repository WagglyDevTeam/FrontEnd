import 'package:flutter/material.dart';
import './colors.dart';

class CommonText {
  final Colors ? color;
  final int ? height;

  CommonText({required this.color , required this.height});

  static TextStyle TitleL = TextStyle(
    fontSize: 24.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
    
  );
  static TextStyle TitleLargeWhite = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle TitleLargeMain = TextStyle(
    fontSize: 24.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Bold',
  );

  static TextStyle TitleM = TextStyle(
    fontSize: 20.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle TitleMediumWhite = TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle TitleMediumMain = TextStyle(
    fontSize: 20.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Bold',
  );

  static TextStyle TitleS = TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      fontFamily: 'NotoSansKR_Bold',
      height: 1);
  static TextStyle TitleSmallWhite = TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle TitleSmallMain = TextStyle(
    fontSize: 16.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle TitleSmallGray = TextStyle(
      fontSize: 16.0,
      color: Palette.mdGray,
      fontFamily: 'NotoSansKR_Bold',
      height: 1);

  static TextStyle BodyL = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle BodyLargeWhite = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle BodyLargeMain = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
  );

  static TextStyle BodyB = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle BodyBoldWhite = TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle BodyBoldMain = TextStyle(
    fontSize: 12.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Bold',
  );
  static TextStyle BodyBMosaic = TextStyle(
    fontSize: 12.0,
    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
    fontFamily: 'NotoSansKR_Bold',
  );

  static TextStyle BodyM = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle BodyMediumWhite = TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle BodyMediumMain = TextStyle(
    fontSize: 12.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle BodyMediumGray = TextStyle(
    fontSize: 12.0,
    color: Palette.mdGray,
    fontFamily: 'NotoSansKR_Md',
  );

  static TextStyle BodyMediumPurple = TextStyle(
    fontSize: 12.0,
    color: Palette.purple,
    fontFamily: 'NotoSansKR_Md',
  );

  static TextStyle BodyS = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodySmallWhite = TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodySmallMain = TextStyle(
    fontSize: 12.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodySmosaic = TextStyle(
    fontSize: 12.0,
    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
    fontFamily: 'NotoSansKR_Rg',
  );

  static TextStyle BodyXS = TextStyle(
    fontSize: 10.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodyXSmallWhite = TextStyle(
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodyXSmallMain = TextStyle(
    fontSize: 10.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Rg',
  );
  static TextStyle BodyXSmallGray = TextStyle(
    fontSize: 10.0,
    color: Palette.mdGray,
    fontFamily: 'NotoSansKR_Rg',
  );

  static TextStyle BodyEng = TextStyle(
    fontSize: 10.0,
    color: Colors.black,
    fontFamily: 'Roboto_Rg',
  );
  
  static TextStyle BodyEngWhite = TextStyle(
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'Roboto_Rg',
  );

  static TextStyle BodyEngMain = TextStyle(
      fontSize: 10.0,
      color: Palette.violet,
      fontFamily: 'Roboto_Rg',
      height: 1
  );

  static TextStyle BodyEngGray = TextStyle(
      fontSize: 10.0,
      color: Palette.mdGray,
      fontFamily: 'Roboto_Rg',
      height: 1
  );

  static TextStyle BodyEngMain11 = TextStyle(
      fontSize: 11.0,
      color: Palette.violet,
      fontFamily: 'Roboto_Rg',
      height: 1);

  static TextStyle Label = TextStyle(
    fontSize: 10.0,
    color: Colors.black,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle LabelWhite = TextStyle(
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle LabelMain = TextStyle(
    fontSize: 10.0,
    color: Palette.main,
    fontFamily: 'NotoSansKR_Md',
  );
  static TextStyle LabelGray = TextStyle(
      fontSize: 10.0,
      color: Palette.mdGray,
      fontFamily: 'NotoSansKR_Md',
      height: 1);

  static TextStyle Number = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
    fontFamily: 'Roboto_Md',
  );
  static TextStyle NumberWhite = TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'Roboto_Md',
  );
  static TextStyle NumberMain = TextStyle(
    fontSize: 12.0,
    color: Palette.main,
    fontFamily: 'Roboto_Md',
  );

  static TextStyle Chip = TextStyle(
    fontSize: 8.0,
    color: Colors.black,
    fontFamily: 'Roboto_Rg',
  );
  static TextStyle ChipWhite = TextStyle(
    fontSize: 8.0,
    color: Colors.white,
    fontFamily: 'Roboto_Rg',
  );
  static TextStyle ChipMain = TextStyle(
    fontSize: 8.0,
    color: Palette.main,
    fontFamily: 'Roboto_Rg',
  );
}
