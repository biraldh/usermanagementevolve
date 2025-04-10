part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUsers extends UserEvent{}

class SearchUser extends UserEvent{
  final String name;
  SearchUser({required this.name});
}
