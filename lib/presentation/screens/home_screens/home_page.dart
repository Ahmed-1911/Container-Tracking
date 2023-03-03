import 'package:container_tracking/core/helpers/routes.dart';
import 'package:container_tracking/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:container_tracking/core/utils/colors_utils.dart';
import 'package:container_tracking/presentation/screens/home_screens/widgets/company_item.dart';
import 'package:container_tracking/presentation/screens/widgets/animated_list_view.dart';
import 'package:upgrader/upgrader.dart';

import '../../../generated/l10n.dart';
import 'add_reminder_page.dart';


class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorsUtils.kPrimaryColor,
      resizeToAvoidBottomInset: true,
      body: UpgradeAlert(
        upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    S.of(context).chooseCompany,
                    style: TextStyle(
                      color: ColorsUtils.whiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: Constants.companiesList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 70.h),
                        itemBuilder: (context, index) {
                          return AnimatedListView(
                            listItem: CompanyItem(
                              index: index,
                              company: Constants.companiesList[index],
                            ),
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: (){
                    CustomNavigator.pushScreen(context: context, widget: AddReminderPage());
                  },
                  child: Container(
                    height: 0.06.sh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorsUtils.blackColor.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm_add,color: ColorsUtils.whiteColor,size: 25.spMin,),
                        SizedBox(width: 10.w,),
                        Text(
                          S.of(context).reminder,
                          style: TextStyle(
                            color: ColorsUtils.whiteColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Icon(Icons.alarm_add,color: ColorsUtils.whiteColor,size: 25.spMin,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
