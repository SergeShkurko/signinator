import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final store = context.read<RegisterStore>();
  late final authActionNotifier = context.read<AuthActionNotifier>();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnUsername = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key form
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        store.setupValidations();
        authActionNotifier.addListener(register);
      },
    );
  }

  @override
  void dispose() {
    authActionNotifier.removeListener(register);
    super.dispose();
  }

  Future<void> register() async {
    final result = await store.register();
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
          child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(
                  builder: (context) => TextF(
                    key: const Key("email"),
                    curFocusNode: _fnEmail,
                    nextFocusNode: _fnUsername,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => store.email = value,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.email,
                    errorText: store.error.email,
                  ),
                ),
                Observer(
                  builder: (context) => TextF(
                    key: const Key("username"),
                    curFocusNode: _fnUsername,
                    nextFocusNode: _fnPassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => store.name = value,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.username,
                    errorText: store.error.username,
                  ),
                ),
                Observer(
                  builder: (context) => TextF(
                    key: const Key("password"),
                    margin: EdgeInsets.zero,
                    curFocusNode: _fnPassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => store.password = value,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    obscureText: store.isPasswordHide,
                    hintText: Strings.of(context)!.password,
                    errorText: store.error.password,
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
    );
  }
}
