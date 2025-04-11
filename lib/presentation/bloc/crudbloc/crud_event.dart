part of 'crud_bloc.dart';

@immutable
sealed class CrudEvent {}

class DeleteUser extends CrudEvent{
  final String id;
  DeleteUser({required this.id});
}

class EditUser extends CrudEvent{
  final UserModel modified;
  EditUser({required this.modified});
}
