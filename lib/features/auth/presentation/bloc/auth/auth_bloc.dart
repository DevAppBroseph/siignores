import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import 'package:siignores/features/auth/domain/usecases/activation_code.dart';
import 'package:siignores/features/auth/domain/usecases/auth_signin.dart';
import 'package:siignores/features/auth/domain/usecases/delete_account.dart';
import 'package:siignores/features/auth/domain/usecases/set_password.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/services/database/auth_params.dart';
import '../../../../../locator.dart';
import '../../../domain/usecases/get_token_local.dart';
import '../../../domain/usecases/get_user_info.dart';
import '../../../domain/usecases/logout.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthSignIn authSignIn;
  final GetUserInfo getUserInfo;
  final GetTokenLocal getTokenLocal;
  final Logout logout;
  final DeleteAccount deleteAccount;

  AuthBloc(this.authSignIn,  this.getUserInfo,  this.getTokenLocal, this.logout, this.deleteAccount) : super(InitialState());

  String email = '';
  bool isSendingCode = false; 
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is CheckUserLoggedEvent){
      yield InitialState();
      var token = await getTokenLocal(NoParams());
      yield token.fold(
        (failure) => errorCheck(failure),
        (token){
          if(token != null){
            sl<AuthConfig>().token = token;
            return RequiredGetUserInfoState();
          }else{
            sl<AuthConfig>().token = null;
            return CheckedState();
          }
        }
      );

    }



    if(event is GetUserInfoEvent){
      print('Get user info in bloc');
      var gotUserInfo = await getUserInfo(NoParams());
      yield gotUserInfo.fold(
        (failure) => errorCheck(failure),
        (userEntity) {
          if(userEntity.firstName == 'unauthorized'){
            print('Token error logout');
            logout(NoParams());
            sl<AuthConfig>().token = null;
            sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
            return CheckedState();

          }
          sl<AuthConfig>().userEntity = userEntity;
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.authenticated;
          return CheckedState();
        }
        
      );
      
    }




    if(event is SignInEvent){
      yield BlankState();
      print('SignInEvent in bloc');
      var authGetToken = await authSignIn(AuthSignParams(email: event.email, password: event.password));
      yield authGetToken.fold(
        (failure) => errorCheck(failure),
        (String token) {
          sl<AuthConfig>().token = token;
          return RequiredGetUserInfoState();
        }
        
      );
    }


    if(event is LogoutEvent){
      print('LogoutEvent in bloc');
      var logoutResult = await logout(NoParams());
      yield logoutResult.fold(
        (failure) => errorCheck(failure),
        (bool isExited) {
          sl<AuthConfig>().userEntity = null;
          sl<AuthConfig>().token = null;
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
          return RequiredCheckState();
        }
        
      );
      
    }


    if(event is DeleteAccountEvent){
      print('Delete account Event in bloc');
      var deleteResult = await deleteAccount(NoParams());
      yield deleteResult.fold(
        (failure) => errorCheck(failure),
        (bool isExited) {
          sl<AuthConfig>().userEntity = null;
          sl<AuthConfig>().token = null;
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
          return RequiredCheckState();
        }
        
      );
      
    }
   
   
    if(event is InternetErrorEvent){
      print("--- INTERNET CONNTECTION ERROR ---");
      yield InternetErrorState();
    } 
    if(event is ServerErrorEvent){
      print("--- SERVER CONNTECTION ERROR ---");
      yield ServerErrorState();
    }
  }




  AuthState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return InternetErrorState();
    }else if(failure is ServerFailure){
      return ErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return ErrorState(message: 'Повторите попытку');
    }
  }
}
