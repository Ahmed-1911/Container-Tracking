import 'package:container_tracking/presentation/screens/splash.dart';
import 'package:container_tracking/presentation/viewModel/alarm/alarm_model.dart';
import 'package:container_tracking/presentation/viewModel/locale/localizationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/colors_utils.dart';
import 'core/utils/fonts_utils.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const ProviderScope(
      child: MyApp(
        key: Key('myApp'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) {
        var locProvider = ref.watch(localProvider);
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: ColorsUtils.kPrimaryColor,
              fontFamily: FontUtils.almarai,
            ),
            locale: locProvider.appLocal,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const Splash(
              key: Key(''),
            ),
          ),
        );
      },
    );
  }
}
