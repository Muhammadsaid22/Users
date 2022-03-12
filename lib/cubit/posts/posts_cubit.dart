import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:users/models/posts_model.dart';
import 'package:users/models/users_models.dart';
import 'package:users/repositories/user_repository.dart';
import 'package:users/cubit/user/user_cubit.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  Future<void> postsInfo(int id ) async {
    emit(PostsLoading());
    List<Posts>? pos = await UserRepository().getPosts(id);
    if(pos != null){
      emit(PostsLoaded(pos,));
    }
    else{
      emit(PostsError());
    }
  }
}
