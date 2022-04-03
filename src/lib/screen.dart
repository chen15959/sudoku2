
import 'package:flutter/cupertino.dart';

/// 屏幕适配
///
class ScreenFit {
//  MediaQueryData _mediaQueryData = null;

  double screenWidth = 0;
  double screenHeight = 0;

  double rpx = 0;
  double rpy = 0;

  ScreenFit(BuildContext context, {double standardPieces = 750}) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    this.screenWidth = mediaQueryData.size.width;
    this.screenHeight = mediaQueryData.size.height;

    this.rpx = this.screenWidth / standardPieces;
    this.rpy = this.screenHeight / standardPieces;
  }



}