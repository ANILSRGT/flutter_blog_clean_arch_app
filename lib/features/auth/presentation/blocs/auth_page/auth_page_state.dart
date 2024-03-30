part of 'auth_page_cubit.dart';

final class AuthPageState with EquatableMixin {
  const AuthPageState({
    required this.isSignInState,
  });

  final bool isSignInState;

  @override
  List<Object?> get props => [isSignInState];

  AuthPageState copyWith({
    bool? isSignInState,
    UserEntity? currentUser,
  }) {
    return AuthPageState(
      isSignInState: isSignInState ?? this.isSignInState,
    );
  }
}
