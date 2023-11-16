import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 屏幕适配
mixin class ScreenAdapter {
  /// 获取适配高度
  double getHeightPx(double height) => ScreenUtil().setHeight(height);

  /// 获取适配宽度
  double getWidthPx(double width) => ScreenUtil().setWidth(width);

  ///屏幕宽度
  double getScreenWidth() => ScreenUtil().screenWidth;
  //
  ///屏幕高度
  double getScreenHeight() => ScreenUtil().screenHeight;

  ///圆角半径根据高度计算
  double getRadiusFromHeight(double radius) => ScreenUtil().radius(radius);

  ///圆角半径根据宽度计算
  double getRadiusFromWidth(double radius) => ScreenUtil().radius(radius);

  ///字体大小
  double getSp(double fontSize) => ScreenUtil().setSp(fontSize);
}
