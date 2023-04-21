import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/dependencies_injection.dart';
import 'package:signinator/features/features.dart';
import 'package:signinator/utils/helper/helper.dart';

class SigninatorApp extends StatelessWidget {
  const SigninatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
      ],
      child: Builder(
        builder: (context) {
          /// Pass context to appRoute
          AppRoute.setStream(context);

          return MaterialApp.router(
            routeInformationProvider: AppRoute.router.routeInformationProvider,
            routeInformationParser: AppRoute.router.routeInformationParser,
            routerDelegate: AppRoute.router.routerDelegate,
            localizationsDelegates: const [
              Strings.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);

              return MediaQuery(
                data: data.copyWith(
                  textScaleFactor: 1,
                  alwaysUse24HourFormat: true,
                ),
                child: child!,
              );
            },
            title: Constants.get.appName,
            theme: themeLight(context),
            darkTheme: themeDark(context),
            supportedLocales: L10n.all,
            themeMode: ThemeMode.light,
            // themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}
