import 'package:eResidensi/providers/guard_patrol_providers.dart';
import 'package:eResidensi/providers/guard_schedule_providers.dart';
import 'package:eResidensi/providers/qrcode_providers.dart';
import 'package:eResidensi/screen/home.dart';
import 'package:eResidensi/screen/qr_code.dart';
import 'package:eResidensi/screen/schedule.dart';
import 'package:eResidensi/screen_child/schedule_info_daily.dart';

import 'providers/guard_info_providers.dart';
import 'providers/auth_providers.dart';
import 'providers/news_provider.dart';
import 'screen/loading.dart';
import 'screen/login.dart';
import 'screen/news.dart';
import 'screen/splash.dart';
import 'screen/self_info.dart';
import 'widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProviders(),
        ),
        ChangeNotifierProvider.value(
          value: NewsProviders(),
        ),
        ChangeNotifierProxyProvider<AuthProviders, GuardInfoProviders>(
          builder: (ctx, auth, previousData) => GuardInfoProviders(
            auth.token,
            previousData == null ? [] : previousData.guardData,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProviders, QrCodeProviders>(
          builder: (ctx, auth, previousScan) => QrCodeProviders(
            auth.token,
            previousScan == null ? [] : previousScan.qrInfo,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProviders, GuardScheduleProviders>(
          builder: (ctx, auth, scheduleData) => GuardScheduleProviders(
            auth.token,
            scheduleData == null ? [] : scheduleData.schedule,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProviders, GuardPatrolProviders>(
          builder: (ctx, auth, patrolData) => GuardPatrolProviders(
            auth.token,
            patrolData == null ? [] : patrolData.items,
          ),
        ),
      ],
      child: Consumer<AuthProviders>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'eResidensi',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Ubuntu',
          ),
          home: auth.isAuth
              ? NavigationBar()
              : FutureBuilder(
                  future: auth.tryAutoSignin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.active
                          ? Loading()
                          : Login(),
                ),
          routes: {
            News.routeName: (context) => News(),
            Splash.routeName: (context) => Splash(),
            SelfInfo.routeName: (context) => SelfInfo(),
            Home.routeName: (context) => Home(),
            QrCode.routeName: (context) => QrCode(),
            Schedule.routeName: (context) => Schedule(),
            ScheduleInfoDaily.routeName: (context) => ScheduleInfoDaily(),
          },
        ),
      ),
    );
  }
}
