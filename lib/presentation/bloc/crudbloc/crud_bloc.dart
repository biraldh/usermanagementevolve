import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagementevolve/data/repo/userRepo.dart';

import '../../../data/model/usermodel.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final UserRepo _userRepo;
  CrudBloc(this._userRepo) : super(CrudInitial()) {
    on<DeleteUser>((event, emit) async {
      emit(CrudLoading());
      try{
        var response = await _userRepo.deleteUser(event.id);
        emit(CrudDeleteSuccess());
      }
      catch(e){
        emit(CrudFailed(errMessage: e.toString()));
      }
    });
    on<EditUser>((event, emit) async {
      emit(CrudLoading());
      try{
        var response = await _userRepo.deleteUser(event.modified);
        emit(CrudUpdateSuccess());
      }
      catch(e){
        emit(CrudFailed(errMessage: e.toString()));
      }
    });
  }
}
