import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:users/models/comments_modul.dart';
import 'package:users/repositories/user_repository.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  Future<void> commentinfo(int id) async {
    emit(CommentLoading());
    List<Comments>? com = await UserRepository().getComments(id);
    if(com != null){
      emit(CommentLoaded(com));
    }
    else{
      emit(CommentError());
    }
  }
}
