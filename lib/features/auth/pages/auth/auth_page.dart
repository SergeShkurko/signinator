import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/auth/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authAction = AuthActionNotifier();

  void onSegmentTapped(AuthSegmentType prev, AuthSegmentType next) {
    if (prev != next) {
      context.pushNamed(() {
        switch (next) {
          case AuthSegmentType.signIn:
            return Routes.login.name;
          case AuthSegmentType.signUp:
            return Routes.register.name;
        }
      }());
      return;
    }

    authAction.auth();
  }

  @override
  void dispose() {
    authAction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thirdOfTheScreen = (MediaQuery.of(context).size.height * 0.66);
    final router = GoRouter.of(context);

    final isLoginRoute = router.location.contains(Routes.login.name);

    return Parent(
      child: Stack(
        children: [
          Positioned.fill(
            bottom: thirdOfTheScreen,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFBFDBFE)),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 100,
                  bottom: -10,
                  child: Waves.ascendingRight(),
                ),
                Positioned(
                  top: 24,
                  left: 24,
                  child: SafeArea(
                    child: SvgPicture.asset(Images.logo),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 192,
                  child: ChangeNotifierProvider.value(
                    value: authAction,
                    child: widget.child,
                  ),
                ),
                const SpacerV(value: Dimens.space32),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.space24),
                  child: SlidingSegmentedControl<AuthSegmentType>(
                    initialValue: isLoginRoute
                        ? AuthSegmentType.signIn
                        : AuthSegmentType.signUp,
                    children: {
                      AuthSegmentType.signIn: Text(Strings.of(context)!.login),
                      AuthSegmentType.signUp:
                          Text(Strings.of(context)!.register),
                    },
                    onValueChanged: onSegmentTapped,
                  ),
                ),
                const SpacerV(value: Dimens.space42),
                ButtonText(
                  title: Strings.of(context)!.forgotPassword,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AuthSegmentType { signIn, signUp }
