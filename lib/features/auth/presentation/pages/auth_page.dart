import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth_page/auth_page_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/widgets/auth_gradient_button.dart';

part 'auth_page_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: _buildForm(),
        ),
      ),
    );
  }

  Form _buildForm() {
    final isSignInState = watchAuthPageBloc().state.isSignInState;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _authTitle(),
          const SizedBox(height: 30),
          if (!isSignInState) ...[
            _nameField(),
            const SizedBox(height: 15),
          ],
          _emailField(),
          const SizedBox(height: 15),
          _passwordField(),
          const SizedBox(height: 20),
          _authButton(),
          const SizedBox(height: 20),
          _haveAccountText(),
        ],
      ),
    );
  }

  Text _authTitle() {
    final isSignInState = watchAuthPageBloc().state.isSignInState;
    return Text(
      isSignInState
          ? LocalKeys.pagesAuthSignIn.local
          : LocalKeys.pagesAuthSignUp.local,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  AuthField _nameField() {
    final isBusy = watchAppBloc().state.isBusy;
    return AuthField(
      controller: nameController,
      hintText: LocalKeys.pagesAuthInputsNameLabel.local,
      validator: _nameValidator,
      isBusy: isBusy,
    );
  }

  AuthField _emailField() {
    final isBusy = watchAppBloc().state.isBusy;
    return AuthField(
      controller: emailController,
      hintText: LocalKeys.pagesAuthInputsEmailLabel.local,
      validator: _emailValidator,
      isBusy: isBusy,
    );
  }

  AuthField _passwordField() {
    final isBusy = watchAppBloc().state.isBusy;
    return AuthField(
      controller: passwordController,
      hintText: LocalKeys.pagesAuthInputsPasswordLabel.local,
      validator: _passwordValidator,
      isObscureText: true,
      isBusy: isBusy,
    );
  }

  AuthGradientButton _authButton() {
    final isSignInState = watchAuthPageBloc().state.isSignInState;
    final isBusy = watchAppBloc().state.isBusy;
    return AuthGradientButton(
      onPressed: _onAuthButton,
      text: isSignInState
          ? LocalKeys.pagesAuthSignIn.local
          : LocalKeys.pagesAuthSignUp.local,
      isBusy: isBusy,
    );
  }

  GestureDetector _haveAccountText() {
    final isSignInState = watchAuthPageBloc().state.isSignInState;
    final isBusy = watchAppBloc().state.isBusy;
    return GestureDetector(
      onTap: isBusy ? null : readAuthPageBloc().toggleAuthState,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: isSignInState
              ? ('${LocalKeys.pagesAuthHaveAccountDontText.local}\t')
              : ('${LocalKeys.pagesAuthHaveAccountAlreadyText.local}\t'),
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: isSignInState
                  ? LocalKeys.pagesAuthHaveAccountDontLink.local
                  : LocalKeys.pagesAuthHaveAccountAlreadyLink.local,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPallete.gradient2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
