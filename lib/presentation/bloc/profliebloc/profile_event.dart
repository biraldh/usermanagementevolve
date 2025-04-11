part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetSingleUser extends ProfileEvent{
  final String id;
  GetSingleUser({required this.id});
}
