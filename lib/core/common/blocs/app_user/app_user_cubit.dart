import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/logged_change_state.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user_entity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserState());

  void updateUser(EntityWithId<UserEntity>? user) {
    emit(
      state.copyWith(
        authSession: LoggedChangeState(
          isLoggedIn: user != null,
          user: user,
        ),
      ),
    );
  }
}
