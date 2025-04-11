import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagementevolve/data/model/usermodel.dart';
import 'package:usermanagementevolve/data/repo/userRepo.dart';
import 'package:usermanagementevolve/presentation/bloc/authBloc/authbloc_bloc.dart';

import '../../../data/model/createmodel.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  UserBloc(this._userRepo) : super(UserInitial()) {
    on<GetUsers>((event, emit) async {
      emit(UserLoading());
      try{
        var response = await _userRepo.getUserList();
        emit(UserSuccess(userData: response));
      }catch(e){
        emit(UserFailed(errMessage: e.toString()));
      }
    });
    on<CreateUser>((event, emit) async {
      emit(UserLoading());
      try{
        var response = await _userRepo.createUser(event.user);
        if(response == 'success'){
          emit(UserCreatedSuccess());
          add(GetUsers());
        }
      }catch(e){
        emit(UserFailed(errMessage: e.toString()));
      }
    });


  }
}
