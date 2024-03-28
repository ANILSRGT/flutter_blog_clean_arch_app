import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/loader/loader_widget.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast.dart';
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
    return LoaderWidget(
      isLoading: watchAuthPageBloc().state.isBusy,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    final isSignIn = watchAuthPageBloc().state.isSignInState;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _authTitle(),
          const SizedBox(height: 30),
          if (!isSignIn) ...[
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
    final isSignIn = watchAuthPageBloc().state.isSignInState;
    return Text(
      isSignIn ? 'Sign In' : 'Sign Up',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  AuthField _nameField() {
    final isBusy = context.watch<AuthPageCubit>().state.isBusy;
    return AuthField(
      controller: nameController,
      hintText: 'Name',
      isBusy: isBusy,
    );
  }

  AuthField _emailField() {
    final isBusy = context.watch<AuthPageCubit>().state.isBusy;
    return AuthField(
      controller: emailController,
      hintText: 'Email',
      validator: _emailValidator,
      isBusy: isBusy,
    );
  }

  AuthField _passwordField() {
    final isBusy = context.watch<AuthPageCubit>().state.isBusy;
    return AuthField(
      controller: passwordController,
      hintText: 'Password',
      validator: _passwordValidator,
      isObscureText: true,
      isBusy: isBusy,
    );
  }

  AuthGradientButton _authButton() {
    final authPageState = watchAuthPageBloc().state;
    return AuthGradientButton(
      onPressed: _onAuthButton,
      text: authPageState.isSignInState ? 'Sign In' : 'Sign Up',
      isBusy: authPageState.isBusy,
    );
  }

  GestureDetector _haveAccountText() {
    final authPageState = watchAuthPageBloc().state;
    return GestureDetector(
      onTap: authPageState.isBusy ? null : readAuthPageBloc().toggleAuthState,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: authPageState.isSignInState
              ? "Don't have an account?\t"
              : 'Already have an account?\t',
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: authPageState.isSignInState ? 'Sign Up' : 'Sign In',
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
