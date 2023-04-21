import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

class TextF extends StatefulWidget {
  const TextF({
    super.key,
    this.margin = const EdgeInsets.only(bottom: Dimens.space12),
    this.curFocusNode,
    this.nextFocusNode,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.textAlign,
    this.enable,
    this.inputFormatter,
    this.minLine,
    this.maxLine,
    required this.prefixIcon,
    this.prefixText,
    this.hintText,
    this.errorText,
    this.autofillHints,
  });

  final EdgeInsets margin;
  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? validator;
  final Function(String)? onChanged;
  final Function? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;
  final Widget prefixIcon;
  final String? prefixText;
  final String? hintText;
  final String? errorText;
  final Iterable<String>? autofillHints;

  @override
  State<TextF> createState() => _TextFState();
}

class _TextFState extends State<TextF> {
  bool isFocus = false;
  String currentVal = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        key: widget.key,
        autofillHints: widget.autofillHints,
        enabled: widget.enable,
        obscureText: widget.obscureText ?? false,
        focusNode: widget.curFocusNode,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign ?? TextAlign.start,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLine ?? 10,
        inputFormatters: widget.inputFormatter,
        textAlignVertical: TextAlignVertical.center,
        style: Typographies.body1,
        cursorColor: context.palette.foreground,
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          alignLabelWithHint: true,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: context.palette.foreground),
          errorText: widget.errorText,
          suffixIcon: widget.suffixIcon,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: Dimens.space36,
            maxHeight: Dimens.space36,
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: Dimens.space36,
            maxHeight: Dimens.space36,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.space12,
            horizontal: Dimens.space16,
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(Dimens.space24),
            borderSide: BorderSide(color: context.palette.primary),
          ),
          disabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(Dimens.space24),
            borderSide: const BorderSide(color: Palette.disable),
          ),
          errorStyle: Typographies.body2
              .copyWith(height: 1, color: context.palette.error),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(Dimens.space24),
            borderSide: BorderSide(color: context.palette.error),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(Dimens.space24),
            borderSide: BorderSide(color: context.palette.error),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(Dimens.space24),
            borderSide: const BorderSide(color: Palette.accent),
          ),
        ),
        validator: widget.validator as String? Function(String?)?,
        onChanged: widget.onChanged,
        onTap: widget.onTap as void Function()?,
        onFieldSubmitted: (value) {
          setState(() {
            fieldFocusChange(
              context,
              widget.curFocusNode ?? FocusNode(),
              widget.nextFocusNode,
            );
          });
        },
      ),
    );
  }

  void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
