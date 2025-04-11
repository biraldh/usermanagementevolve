part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState{
  ProfileLoading();
}

class ProfileFailed extends ProfileState{
  final String errMessage;
  ProfileFailed({required this.errMessage});
}

class GetProfileSuccess extends ProfileState{
  final UserModel user;
  GetProfileSuccess({required this.user});
}