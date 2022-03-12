import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:users/models/users_models.dart';
import 'package:users/repositories/user_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Future<void> userinfo()async {
    emit(UserLoading());
    List<User>?  per = await UserRepository().getUser();
    if(per != null){
      emit(UserLoaded(per));
    }
    else{
      emit(UserError());
    }
  }
}

