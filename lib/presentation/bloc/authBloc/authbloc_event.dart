part of 'authbloc_bloc.dart';

@immutable
sealed class AuthblocEvent {}

class LoginUser extends AuthblocEvent{
  final AuthModel authModel;
  LoginUser({required this.authModel});
}