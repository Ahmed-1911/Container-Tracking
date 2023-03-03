import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/routes.dart';
import '../../../core/utils/colors_utils.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.popScreen(context: context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Icon(
          Icons.arrow_back_ios,
          color: ColorsUtils.blackColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
