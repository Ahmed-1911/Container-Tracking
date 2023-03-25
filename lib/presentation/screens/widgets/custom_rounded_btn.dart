import 'package:container_tracking/core/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoundedButton extends StatelessWidget {
  String text;
  Function pressed;
  Color backgroundColor;
  Color textColor;
  Color borderColor;
  Icon? icon;
  double width;
  double margin;
  double height;
  bool iconLeft;
  bool withShadow;
  double fontSize;
  double radius;
  FontWeight fontWeight;

  CustomRoundedButton({
    Key? key,
    required this.pressed,
    this.text = '',
    this.backgroundColor = ColorsUtils.kSecondaryColor,
    this.borderColor = ColorsUtils.transparentColor,
    this.icon,
    this.textColor = ColorsUtils.whiteColor,
    this.width = 300,
    this.margin = 21,
    this.iconLeft = false,
    this.height = 48,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w600,
    this.radius = 12,
    this.withShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pressed();
      },
      child: Container(
        width: width.w,
        height: height.h,
        margin: EdgeInsets.symmetric(horizontal: margin.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: withShadow
                  ? ColorsUtils.kPrimaryColor.withOpacity(0.53)
                  : ColorsUtils.transparentColor,
              blurRadius: 24,
              offset: const Offset(6, 9),
            )
          ],
        ),
        child: iconLeft
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                  ),
                  icon ?? const SizedBox(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
