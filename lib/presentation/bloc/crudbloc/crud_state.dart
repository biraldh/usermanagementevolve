part of 'crud_bloc.dart';

@immutable
sealed class CrudState {}

final class CrudInitial extends CrudState {}

class CrudUpdateSuccess extends CrudState{}

class CrudDeleteSuccess extends CrudState{}

class CrudFailed extends CrudState{
  final String errMessage;
  CrudFailed({required this.errMessage});
}

class CrudLoading extends CrudState{}