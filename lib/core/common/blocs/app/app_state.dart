part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.isBusy = false,
  });
  final bool isBusy;

  @override
  List<Object> get props => [isBusy];

  AppState copyWith({
    bool? isBusy,
  }) {
    return AppState(
      isBusy: isBusy ?? this.isBusy,
    );
  }
}
