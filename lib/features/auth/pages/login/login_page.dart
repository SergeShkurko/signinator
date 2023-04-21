import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final store = context.read<LoginStore>();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<AuthActionNotifier>().addListener(login),
    );
  }

  @override
  void dispose() {
    context.watch<AuthActionNotifier>().removeListener(login);
    super.dispose();
  }

  Future<void> login() async {
    final result = await store.login();
    if (result && mounted) {
      context.pushReplacementNamed(Routes.root.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      builder: (context) => reaction(
        (_) => store.notifications.value,
        (details) => showNotification(context, details!),
      ),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space24),
          child: AutofillGroup(
            child: Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(
                    builder: (context) => TextF(
                      autofillHints: const [AutofillHints.email],
                      key: const Key("email"),
                      curFocusNode: _fnEmail,
                      nextFocusNode: _fnPassword,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => store.email = value,
                      keyboardType: TextInputType.emailAddress,
                      hintText: Strings.of(context)!.username,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (context) => TextF(
                      margin: EdgeInsets.zero,
                      autofillHints: const [AutofillHints.password],
                      key: const Key("password"),
                      curFocusNode: _fnPassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => store.password = value,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      obscureText: store.isPasswordHide,
                      hintText: Strings.of(context)!.password,
                      maxLine: 1,
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space12),
                        constraints: const BoxConstraints(),
                        onPressed: () =>
                            store.isPasswordHide = !store.isPasswordHide,
                        icon: Icon(
                          store.isPasswordHide
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
