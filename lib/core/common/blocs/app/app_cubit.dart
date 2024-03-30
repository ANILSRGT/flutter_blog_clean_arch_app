import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void setBusy(bool isBusy) {
    emit(state.copyWith(isBusy: isBusy));
  }
}
