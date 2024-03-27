part of 'auth_page_cubit.dart';

final class AuthPageState with EquatableMixin {
  const AuthPageState({
    required this.isSignInState,
    required this.isBusy,
  });

  final bool isSignInState;
  final bool isBusy;

  @override
  List<Object?> get props => [isSignInState, isBusy];

  AuthPageState copyWith({
    bool? isSignInState,
    bool? isBusy,
  }) {
    return AuthPageState(
      isSignInState: isSignInState ?? this.isSignInState,
      isBusy: isBusy ?? this.isBusy,
    );
  }
}
