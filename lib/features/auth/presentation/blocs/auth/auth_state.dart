part of 'auth_cubit.dart';

final class AuthState with EquatableMixin {
  const AuthState({
    required this.isSignInState,
  });

  final bool isSignInState;

  @override
  List<Object?> get props => [isSignInState];

  AuthState copyWith({
    bool? isSignInState,
  }) {
    return AuthState(
      isSignInState: isSignInState ?? this.isSignInState,
    );
  }
}
