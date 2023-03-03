import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:container_tracking/core/utils/colors_utils.dart';

class CustomTextField extends StatefulWidget {
  String? label;
  Widget? icon;
  Widget? suffixIcon;
  Color? filledColor;
  bool isMobile;
  bool isNumber;
  bool centerText;
  TextEditingController? controller;
  bool hasPassword;
  bool isEmail;
  bool isPhoneCode;
  bool isFinal;
  bool isEditable;
  bool isNotes;
  bool hasBorder;
  bool readOnly;
  TextStyle? style;
  Function? validator;
  Function? onChange;
  String? hintText;
  String? initialValue;
  TextStyle? hintStyle;
  int? maxLine = 1;
  double radius;
  double margin;
  BoxShadow? shadow;

  CustomTextField({
    Key? key,
    this.icon,
    this.label,
    this.filledColor,
    this.hasBorder = true,
    this.isEditable = true,
    this.isNotes = false,
    this.centerText = false,
    this.isFinal = false,
    this.isPhoneCode = false,
    this.isMobile = false,
    this.isNumber = false,
    this.isEmail = false,
    this.hasPassword = false,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.style,
    this.validator,
    this.onChange,
    this.hintText,
    this.initialValue,
    this.hintStyle,
    this.maxLine = 1,
    this.radius = 30,
    this.shadow,
    this.margin = 21,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  bool called = false;
  StateProvider codesProvider = StateProvider<List<String>>((ref) => []);
  StateProvider loadingProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    if (called == false && widget.isPhoneCode) {
      called = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {},
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin.w),
      alignment: Alignment.center,
      child: TextFormField(
        key: widget.key,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        onChanged: (String value) {
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        style: TextStyle(
          color: ColorsUtils.blackColor,
          fontSize: 14.spMin,
          fontWeight: FontWeight.w500,
        ),
        controller: widget.controller,
        enabled: widget.isEditable,
        textInputAction: TextInputAction.done,
        obscureText: (widget.hasPassword) ? showPassword : widget.hasPassword,
        minLines: widget.isNotes ? 5 : 1,
        maxLines: widget.hasPassword ? 1 : widget.maxLine,
        textAlign: (widget.centerText) ? TextAlign.center : TextAlign.start,
        keyboardType: (widget.isEmail)
            ? TextInputType.emailAddress
            : (widget.isMobile)
                ? TextInputType.phone
                : (widget.isNumber)
                    ? TextInputType.number
                    : TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          enabledBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  borderSide: const BorderSide(
                    color: ColorsUtils.kSecondaryColor,
                  ),
                ),
          disabledBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  borderSide: const BorderSide(
                    color: ColorsUtils.kSecondaryColor,
                  ),
                ),
          border: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  borderSide: const BorderSide(
                    color: ColorsUtils.kSecondaryColor,
                  ),
                ),
          focusedBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius.r),
                  borderSide: const BorderSide(
                    color: ColorsUtils.kSecondaryColor,
                    width: 2,
                  ),
                ),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: ColorsUtils.blackColor.withOpacity(0.7),
            fontSize: 14.spMin,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: (widget.hasPassword)
              ? InkWell(
                  onTap: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                  child: (!showPassword)
                      ? Icon(
                          Icons.visibility_outlined,
                          color: ColorsUtils.blackColor,
                          size: 18.w,
                        )
                      : Icon(
                          Icons.visibility_off_outlined,
                          color: ColorsUtils.blackColor,
                          size: 18.w,
                        ),
                )
              : widget.suffixIcon,
          fillColor: (widget.filledColor == null)
              ? Colors.transparent
              : widget.filledColor,
          filled: true,
          prefixIcon: widget.icon
        ),
      ),
    );
  }
}
