import 'package:container_tracking/core/helpers/routes.dart';
import 'package:container_tracking/core/utils/colors_utils.dart';
import 'package:container_tracking/presentation/viewModel/alarm/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/view_functions.dart';
import '../../../core/utils/constants.dart';
import '../../../generated/l10n.dart';
import '../widgets/custom_rounded_btn.dart';
import '../widgets/custom_textfield.dart';

class AddReminderPage extends ConsumerWidget {
  AddReminderPage({Key? key}) : super(key: key);
  TextEditingController companyNameCnt = TextEditingController();
  TextEditingController containerNumberCnt = TextEditingController();
  TextEditingController portAccessCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();

  StateProvider<DateTime> alarmDateProvider =
      StateProvider((ref) => DateTime.now());
  final NotificationService notificationService = NotificationService();
  bool called = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime alarm = ref.watch(alarmDateProvider);
    if (called == false) {
      called = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          var prefs = await SharedPreferences.getInstance();

          ///check if alarm found
          if (prefs.getString(Constants.alarmDate) != null) {
            /// check that alarm time not come yet
            if (DateTime.parse(prefs.getString(Constants.alarmDate) ?? '')
                .isAfter(DateTime.now())) {
              ref.read(alarmDateProvider.notifier).state =
                  DateTime.parse(prefs.getString(Constants.alarmDate) ?? '');
              companyNameCnt.text =
                  prefs.getString(Constants.companyName).toString();
              portAccessCnt.text =
                  prefs.getString(Constants.portAccess).toString();
              containerNumberCnt.text =
                  prefs.getString(Constants.containerNumber).toString();
              descriptionCnt.text =
                  prefs.getString(Constants.alarmDescription).toString();
            }
          }
        },
      );
    }
    return Scaffold(
      backgroundColor: ColorsUtils.kPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm_add,
                    color: ColorsUtils.whiteColor,
                    size: 25.spMin,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    S.of(context).reminder,
                    style: TextStyle(
                      color: ColorsUtils.whiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomTextField(
                controller: portAccessCnt,
                hintText: 'ميناء الوصول',
                filledColor: ColorsUtils.whiteColor,
                hintStyle: TextStyle(
                  color: ColorsUtils.kPrimaryColor.withOpacity(0.5),
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w500,
                ),
                centerText: true,
                margin: 40,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: companyNameCnt,
                hintText: 'اسم شركة الشحن',
                filledColor: ColorsUtils.whiteColor,
                hintStyle: TextStyle(
                  color: ColorsUtils.kPrimaryColor.withOpacity(0.5),
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w500,
                ),
                centerText: true,
                margin: 40,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: containerNumberCnt,
                hintText: 'رقم الحاوية او بوليصة الشحن',
                filledColor: ColorsUtils.whiteColor,
                hintStyle: TextStyle(
                  color: ColorsUtils.kPrimaryColor.withOpacity(0.5),
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w500,
                ),
                centerText: true,
                margin: 40,
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (selected != null && context.mounted) {
                    ref.read(alarmDateProvider.notifier).state = selected;
                  }
                },
                child: Container(
                  width: 1.sw,
                  height: 45.h,
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorsUtils.whiteColor,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: ColorsUtils.kSecondaryColor,
                    ),
                  ),
                  child: Text(
                    alarm.isBefore(DateTime.now())
                        ? 'يوم /  شهر  /  سنه'
                        : alarm.toString().substring(0, 10),
                    style: TextStyle(
                      color: alarm.isBefore(DateTime.now())
                          ? ColorsUtils.kPrimaryColor.withOpacity(0.5)
                          : ColorsUtils.blackColor,
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: descriptionCnt,
                hintText: 'وصف البضاعة',
                filledColor: ColorsUtils.whiteColor,
                isNotes: true,
                maxLine: 5,
                hintStyle: TextStyle(
                  color: ColorsUtils.kPrimaryColor.withOpacity(0.5),
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w500,
                ),
                centerText: true,
                margin: 40,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomRoundedButton(
                backgroundColor: ColorsUtils.kSecondaryColor,
                text: ' اضافه تذكير',
                fontSize: 11.spMin,
                textColor: ColorsUtils.whiteColor,
                height: 40.h,
                radius: 60,
                margin: 0,
                withShadow: false,
                fontWeight: FontWeight.w600,
                pressed: () async {
                  if (companyNameCnt.text.isEmpty ||
                      containerNumberCnt.text.isEmpty ||
                      portAccessCnt.text.isEmpty ||
                      alarm.isBefore(DateTime.now())) {
                    ViewFunctions.showCustomSnackBar(
                      context: context,
                      text: 'قم باضافه جميع البيانات اولا',
                    );
                  } else {
                    await notificationService.scheduleNotifications(
                      context: context,
                      id: 1,
                      companyName: companyNameCnt.text.toString(),
                      containerNumber: containerNumberCnt.text.toString(),
                      portAccess: portAccessCnt.text.toString(),
                      desc: descriptionCnt.text.toString(),
                      time: alarm,
                    );
                    if (context.mounted) {
                      CustomNavigator.popScreen(context: context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
