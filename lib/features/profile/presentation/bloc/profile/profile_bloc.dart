import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siignores/features/profile/domain/usecases/update_avatar.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../domain/usecases/update_user_info.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final UpdateUserInfo updateUserInfo; 
  final UpdateAvatar updateAvatar; 
  
  ProfileBloc(this.updateUserInfo, this.updateAvatar) : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    if(event is UpdateUserInfoEvent){
      yield ProfileBlankState();
      var success = await updateUserInfo(UpdateUserInfoParams(firstName: event.firstName, lastName: event.lastName));
      yield success.fold(
        (failure) => errorCheck(failure),
        (promos){
          return ChangedSuccessState();
        }
      );
    }



    if(event is UpdateAvatarEvent){
      yield ProfileBlankState();
      var success = await updateAvatar(UpdateAvatarParams(file: event.file));
      yield success.fold(
        (failure) => errorCheck(failure),
        (promos){
          return ChangedSuccessState();
        }
      );
    }

    
  }

}
ProfileState errorCheck(Failure failure){
  print('FAIL: ${failure}');
  if(failure == ConnectionFailure() || failure == NetworkFailure()){
    return InternetConnectionFailureProfileState();
  }else if(failure is ServerFailure){
    return ProfileErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
  }else{
    return ProfileErrorState(message: 'Повторите попытку');
  }
}