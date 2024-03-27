part of 'auth_page.dart';

mixin AuthPageMixin on State<AuthPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthPageCubit readAuthPageBloc() => context.read<AuthPageCubit>();
  AuthPageCubit watchAuthPageBloc() => context.watch<AuthPageCubit>();

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

  String? _emailValidator(String? value) {
    if (value.isEmptyOrNull) {
      return "Email is missing!";
    }

    if (!value.emailValid) {
      return "Email is invalid!";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value.isEmptyOrNull) {
      return "Password is missing!";
    }

    final List<String> errors = [];
    if (!value.minCharacters(8)) {
      errors.add("Min 8 characters");
    }

    if (!value.upperCaseLetterValid) {
      errors.add("Uppercase letter");
    }

    if (!value.lowerCaseLetterValid) {
      errors.add("Lowercase letter");
    }

    if (!value.numberValid) {
      errors.add("Number");
    }

    return errors.isNotEmpty ? errors.map((e) => "• $e").join("\n") : null;
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
        message: res.asFail.message,
      );
      return;
    }
  }
}
