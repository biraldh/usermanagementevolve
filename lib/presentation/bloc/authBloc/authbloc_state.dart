part of 'authbloc_bloc.dart';

@immutable
sealed class AuthblocState {}

final class AuthblocInitial extends AuthblocState {}

class AuthSuccess extends AuthblocState{
  final String token;
  AuthSuccess({required this.token});
}
class AuthFailed extends AuthblocState{
  final String errMessage;
  AuthFailed({required this.errMessage});
}
class AuthLoading extends AuthblocState{
  AuthLoading();
}