import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final lightTheme = AppTheme.lightTheme;
          final darkTheme = AppTheme.darkTheme;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeState.themeMode,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: appRouter.generateRoute,
            onUnknownRoute: (settings) =>
                appRouter.generateRoute(
                  RouteSettings(name: Routes.splashScreen),
                ) ??
                MaterialPageRoute(builder: (_) => const SizedBox()),
            initialRoute: Routes.splash,
          );
        },
      ),
    );
  }
}
