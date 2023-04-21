import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

/// Light theme
ThemeData themeLight(BuildContext context) => ThemeData(
      useMaterial3: true,
      primaryColor: context.palette.primary,
      disabledColor: Palette.disable,
      hintColor: Palette.accent,
      cardColor: Palette.white,
      scaffoldBackgroundColor: context.palette.background,
      colorScheme: const ColorScheme.light().copyWith(
        primary: context.palette.primary,
        background: context.palette.background,
        surface: context.palette.background,
      ),
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: context.palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

/// Dark theme
ThemeData themeDark(BuildContext context) => ThemeData(
      useMaterial3: true,
      primaryColor: context.palette.primary,
      disabledColor: Palette.disable,
      hintColor: Palette.accent,
      cardColor: context.palette.background,
      scaffoldBackgroundColor: context.palette.background,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: context.palette.primary,
        background: context.palette.background,
        surface: context.palette.background,
      ),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: context.palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

class BoxDecorations {
  BoxDecorations._();

  static BoxDecoration button = const BoxDecoration(
    color: Palette.accent,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: [BoxShadows.button],
  );

  static BoxDecoration card = const BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: [BoxShadows.card],
  );

  static BoxDecoration dialogAlt = const BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: [BoxShadows.dialogAlt],
  );

  static BoxDecoration bottomSheet = const BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimens.cornerRadiusBottomSheet),
      topRight: Radius.circular(Dimens.cornerRadiusBottomSheet),
    ),
    boxShadow: [BoxShadows.dialog],
  );

  static BoxDecoration buttonMenu = const BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.cornerRadius),
    ),
    boxShadow: [BoxShadows.buttonMenu],
  );
}

class BoxShadows {
  BoxShadows._();

  static const BoxShadow button = BoxShadow(
    color: Palette.black20,
    blurRadius: 16.0,
    spreadRadius: 1.0,
  );

  static const BoxShadow card = BoxShadow(
    color: Palette.black15,
    blurRadius: 12.0,
    spreadRadius: 1.0,
  );

  static const BoxShadow dialog = BoxShadow(
    color: Palette.black10,
    offset: Offset(0, -4),
    blurRadius: 16.0,
  );

  static const BoxShadow dialogAlt = BoxShadow(
    color: Palette.black25,
    offset: Offset(0, 4),
    blurRadius: 16.0,
  );

  static const BoxShadow buttonMenu = BoxShadow(
    color: Palette.black25,
    blurRadius: 4.0,
  );
}
