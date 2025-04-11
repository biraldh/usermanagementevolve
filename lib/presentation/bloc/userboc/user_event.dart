part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUsers extends UserEvent{}

class CreateUser extends UserEvent{
  final CreateJobModel user;
  CreateUser({required this.user});
}
