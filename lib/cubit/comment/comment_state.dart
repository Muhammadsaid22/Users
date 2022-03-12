part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}
class CommentLoading extends CommentState {}
class CommentLoaded extends CommentState {
  final List<Comments> comments;
  CommentLoaded(this.comments);
}
class CommentError extends CommentState {}
