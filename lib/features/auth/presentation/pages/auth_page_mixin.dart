part of 'auth_page.dart';

mixin AuthPageMixin on State<AuthPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthPageCubit readAuthPageBloc() => context.read<AuthPageCubit>();
  AuthPageCubit watchAuthPageBloc() => context.watch<AuthPageCubit>();
  AppCubit watchAppBloc() => context.watch<AppCubit>();

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  String? _nameValidator(String? value) {
    if (value.isEmptyOrNull) {
      return LocalKeys.pagesAuthInputsNameValidatesRequired.local;
    }

    if (!value.minCharacters(2)) {
      return LocalKeys.pagesAuthInputsNameValidatesMinLengthMultipleArgs1
          .localWithArgs(['2']);
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value.isEmptyOrNull) {
      return LocalKeys.pagesAuthInputsEmailValidatesRequired.local;
    }

    if (!value.emailValid) {
      return LocalKeys.pagesAuthInputsEmailValidatesInvalid.local;
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value.isEmptyOrNull) {
      return LocalKeys.pagesAuthInputsPasswordValidatesRequired.local;
    }

    final errors = <String>[];
    if (!value.minCharacters(8)) {
      errors.add(LocalKeys
          .pagesAuthInputsPasswordValidatesMinLengthMultipleArgs1
          .localWithArgs(['8']));
    }

    if (!value.upperCaseLetterValid) {
      errors.add(LocalKeys.pagesAuthInputsPasswordValidatesUppercaseNeed.local);
    }

    if (!value.lowerCaseLetterValid) {
      errors.add(LocalKeys.pagesAuthInputsPasswordValidatesLowercaseNeed.local);
    }

    if (!value.numberValid) {
      errors.add(LocalKeys.pagesAuthInputsPasswordValidatesNumberNeed.local);
    }

    return errors.isNotEmpty ? errors.map((e) => '• $e').join('\n') : null;
  }

  Future<void> _onAuthButton() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValidate = formKey.currentState?.validate() ?? false;
    if (!isValidate) return;

    final isSignIn = readAuthPageBloc().state.isSignInState;

    final res = await (isSignIn
        ? readAuthPageBloc().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
        : readAuthPageBloc().signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ));

    if (res.isFail && mounted) {
      CustomToast.show(
        context: context,
        type: CustomToastType.error,
        title: res.asFail.code,
        message: res.asFail.message,
      );
      return;
    }
  }
}
