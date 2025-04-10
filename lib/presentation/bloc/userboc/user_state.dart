part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState{
  UserLoading();
}
class UserSuccess extends UserState{
  final List<UserModel> userData;
  UserSuccess({required this.userData});
}
class UserFailed extends UserState{
  final String errMessage;
  UserFailed({required this.errMessage});
}