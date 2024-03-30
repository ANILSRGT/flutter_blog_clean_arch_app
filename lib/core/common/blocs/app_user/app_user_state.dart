part of 'app_user_cubit.dart';

final class AppUserState extends Equatable {
  const AppUserState({
    this.authSession = const LoggedChangeState(isLoggedIn: false, user: null),
  });
  final LoggedChangeState authSession;

  @override
  List<Object?> get props => [authSession];

  AppUserState copyWith({
    LoggedChangeState? authSession,
  }) {
    return AppUserState(
      authSession: authSession ?? this.authSession,
    );
  }
}
