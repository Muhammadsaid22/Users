part of 'user_cubit.dart';
@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoading extends UserState{}
class UserLoaded extends UserState{
  final List<User> userslist;
  UserLoaded(this.userslist);
}
class UserError extends UserState{}
