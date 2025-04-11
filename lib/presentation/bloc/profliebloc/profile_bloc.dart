import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagementevolve/presentation/bloc/userboc/user_bloc.dart';

import '../../../data/model/usermodel.dart';
import '../../../data/repo/userRepo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepo _userRepo;
  ProfileBloc(this._userRepo) : super(ProfileInitial()) {
    on<GetSingleUser>((event, emit) async {
      emit(ProfileLoading());
      try {
        final response = await _userRepo.getUser(event.id);
        emit(GetProfileSuccess(user: response));
      } catch (e) {
        emit(ProfileFailed(errMessage: e.toString()));
      }
    });
  }
}
