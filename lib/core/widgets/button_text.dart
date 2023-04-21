import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;

  const ButtonText({
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
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: Dimens.space8),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: context.palette.buttonAccent,
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.space10,
              horizontal: Dimens.space16,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
