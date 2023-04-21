import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Center(
        child: ButtonText(
            title: Strings.of(context)!.signOut,
            onPressed: () {
              context.read<AuthStore>().logout();
              context.push(Routes.root.name);
            }),
      ),
    );
  }
}
