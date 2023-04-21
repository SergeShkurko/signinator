import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Parent(
      child: SingleChildScrollView(
        child: Text('add here button for logout'),
      ),
    );
  }
}
