import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/routes.dart';
import '../../core/singleton/settings_session.dart';
import '../../core/utils/colors_utils.dart';
import '../../presentation/viewModel/locale/localizationProvider.dart';
import 'home_screens/home_page.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          final locProvider = ref.read(localProvider.notifier);
          await locProvider.fetchLocale();
          SettingsSession.instance().loadLanguage();
        });
        Future.delayed(
          const Duration(seconds: 2),
          () async {
            if (context.mounted) {
              CustomNavigator.pushScreenReplacement(
                context: context,
                widget: HomePage(
                  key: const Key(''),
                ),
              );
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: ColorsUtils.kPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image(
                image: const AssetImage('assets/images/logo.png'),
                height: 119.h,
                width: 177.w,
                color: ColorsUtils.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
