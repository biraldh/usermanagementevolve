import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagementevolve/data/model/authmodel.dart';
import 'package:usermanagementevolve/data/repo/authRepo.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthblocBloc extends Bloc<AuthblocEvent, AuthblocState> {
  final AuthRepo _authRepo;
  AuthblocBloc(this._authRepo) : super(AuthblocInitial()) {
    on<LoginUser> ((event, emit) async {
      emit(AuthLoading());
      try {
        var response = await _authRepo.loginUser(event.authModel);
        if (response.isNotEmpty) {
          emit(AuthSuccess(token: response));
        }
        else{
          emit(AuthFailed(errMessage: response));
        }
      }
      catch(e){
        emit(AuthFailed(errMessage: e.toString()));
      }
    });
  }
}
