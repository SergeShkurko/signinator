import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signinator/core/core.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.root.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Parent(
      child: ColoredBox(
        color: Palette.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Palette.accent,
          ),
        ),
      ),
    );
  }
}
