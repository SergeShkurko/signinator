import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.color,
    this.titleColor,
    this.fontSize,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minWidth: width ?? context.widthInPercent(100)),
      margin: const EdgeInsets.symmetric(vertical: Dimens.space8),
      height: Dimens.buttonH,
      decoration: BoxDecorations.button
          .copyWith(color: color ?? context.palette.primary),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color ?? context.palette.primary,
          foregroundColor: context.palette.foreground,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space24),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.cornerRadius),
            ),
          ),
        ),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Palette.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
