import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomButtonBG {
  customButtonLoginGreenButtonStyle,
}

class CustomButton extends StatefulWidget {
  TextStyle? style;
  CustomButtonBG? bgStyle;
  String titleStr;
  Function()? onTap;
  Color? textColor = Colors.black;
  double? height;
  double? width;


  CustomButton(
      {required this.titleStr,
      this.style,
      this.bgStyle,
      this.onTap,
      this.height,
      this.width,
      this.textColor = Colors.black,
      Key? key})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double width = 0;
  double height = 0;
  bool isClicked = false;

  final BoxDecoration greenDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(25.w),
      gradient: const LinearGradient(
          colors: [Color(0xFF6BDCB0), Color(0xFF6BDCB0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
      )
  );

  final BoxDecoration whiteDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25.w),
    color: const Color(0xFFD5DDE2).withOpacity(0.4)
  );

  @override
  Widget build(BuildContext context) {
    width = widget.width??0;
    height = widget.height??0;

    Color? textColor = widget.textColor;
    BoxDecoration btnDecoration = greenDecoration;
    if (widget.bgStyle == CustomButtonBG.customButtonLoginGreenButtonStyle) {
      width = 128.w;
      height = 40.w;
    }

    if(widget.onTap == null) {
      btnDecoration = greenDecoration;
      textColor = Colors.black.withOpacity(0.2);
    }

    height = widget.height??height;

    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onTap == null ? null : () {
            if(isClicked) {
              print("点击过于频繁，跳过该点击");
              return;
            }
            isClicked = true;
            widget.onTap?.call();
            Future.delayed(const Duration(seconds: 1)).then((value) => isClicked = false);
          },
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: btnDecoration,
            child: Text(
              widget.titleStr,
              style: widget.style ??
                  TextStyle(
                    fontSize: 16.sp,
                    fontWeight: btnDecoration == greenDecoration ? FontWeight.w600 : FontWeight.w500,
                    color: textColor??widget.textColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
