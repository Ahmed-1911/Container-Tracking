import 'package:container_tracking/core/helpers/routes.dart';
import 'package:container_tracking/core/utils/colors_utils.dart';
import 'package:container_tracking/data/entity/company.dart';
import 'package:container_tracking/presentation/screens/home_screens/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyItem extends StatelessWidget {
  CompanyItem({
    Key? key,
    required this.index,
    required this.company,
  }) : super(key: key);

  int index;
  Company company;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.pushScreen(
          context: context,
          widget: WebViewPage(url: company.url),
        );
      },
      child: Container(
        height: 47.h,
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 5.h,
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 0.18.sw,
        ),
        decoration: BoxDecoration(
          color: ColorsUtils.whiteColor,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Image(
          image: AssetImage(company.image),
        ),
      ),
    );
  }
}
