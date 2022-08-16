import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final SendSMS sendSMS;
  // final AuthSignIn authSignIn;
  // final GetUserInfo getUserInfo;
  // final GetTokenLocal getTokenLocal;
  // final Register register;
  // final Logout logout;
  //this.sendSMS, this.authSignIn,  this.getUserInfo,  this.getTokenLocal, this.logout, this.register
  AuthBloc() : super(InitialState());

  String email = '';
  bool isSendingCode = false; 
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    // if(event is CheckUserLoggedEvent){
    //   yield BlankState();
    //   var token = await getTokenLocal(NoParams());
    //   yield token.fold(
    //     (failure){
    //       if(failure == ConnectionFailure() || failure == NetworkFailure())
    //         return InternetConnectionFailed();
    //       else if(failure is ServerFailure)
    //         return ErrorState(message: failure.message);
    //       else
    //         return ErrorState(message: 'Повторите попытку');
    //     },
    //     (token){
    //       if(token != null){
    //         sl<AuthConfig>().token = token;
    //         return RequiredGetUserInfoState(showModalPromocode: false);
    //       }else{
    //         sl<AuthConfig>().token = null;
    //         return CheckedState();
    //       }
    //     }
    //   );

    // }

    // if(event is SendSMSEvent){
    //   phone = event.phone;
    //   var sendedSMSOrFail = await sendSMS(PhoneParams(phoneNumber: event.phone));
    //   yield sendedSMSOrFail.fold(
    //     (failure){
    //       print('FAIL: ${failure}');
    //       if(failure == ConnectionFailure() || failure == NetworkFailure())
    //         return InternetConnectionFailed();
    //       else if(failure is ServerFailure)
    //         return ErrorState(message: failure.message);
    //       else
    //         return ErrorState(message: 'Повторите попытку');
          
    //     },
    //     (isSuccess){
    //       print('SUCCESS: ${isSuccess}');
    //       return LoginCodeSendedSuccessState(phone: event.phone);
    //     }
    //   );

    // }

    // if(event is SignInEvent){

    //   if(!isSendingCode){
    //     yield EnterCodeBlankState(phone: phone);
    //     isSendingCode = true;
    //     print('SignInEvent in bloc');
    //     var authGetToken = await authSignIn(AuthSignParams(phoneNumber: event.phone, code: event.code));
    //     yield authGetToken.fold(
    //       (failure) {
    //         isSendingCode = false;
    //         if(failure == ConnectionFailure() || failure == NetworkFailure())
    //           return InternetConnectionFailed();
    //         else if(failure is ServerFailure)
    //           return LoginCodeErrorState(message: failure.message, phone: phone);
    //         else 
    //           return LoginCodeErrorState(message: 'Не смогли зайти', phone: phone);
    //       },
    //       (TokenEntity tokenEntity) {
    //         sl<AuthConfig>().phone = event.phone;
    //         sl<AuthConfig>().token = tokenEntity.token;
    //         isSendingCode = false;
    //         if(tokenEntity.registered){
    //           return LoginWithPhoneSuccessState();
    //         }else{
    //           return RequiredRegisterState();
    //         }
    //       }
          
    //     );
    //   }
      
      
    // }


    // if(event is GetUserInfoEvent){
    //   print('Get user info in bloc');
    //   var gotUserInfo = await getUserInfo(NoParams());
    //   yield gotUserInfo.fold(
    //     (failure) {
    //       print('FAILURE: ${failure}');
    //       if(failure == ConnectionFailure() || failure == NetworkFailure())
    //         return InternetConnectionFailed();
    //       else if(failure is ServerFailure)
    //         return ErrorState(message: failure.message);
    //       else
    //         return ErrorState(message: 'Повторите попытку');
    //     },
    //     (userEntity) {
    //       if(userEntity.firstName == 'unauthorized' && userEntity.city == null){
    //         print('Token error logout');
    //         logout(NoParams());
    //         sl<AuthConfig>().token = null;
    //         sl<AuthConfig>().userEntity = null;
    //         sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
    //         return CheckedState();

    //       }
    //       sl<AuthConfig>().phone = userEntity.phone;
    //       if(!userEntity.registered){
    //         print(userEntity.phone);
    //         return RequiredRegisterState();
    //       }
    //       sl<AuthConfig>().userEntity = userEntity;
    //       sl<AuthConfig>().authenticatedOption = AuthenticatedOption.authenticated;
    //       return CheckedState();
    //     }
        
    //   );
      
    // }


    // if(event is OpenAuthFormEvent){
    //   yield BlankState();
    //   yield OpenAuthFormState();
    // }

    // if(event is RegisterEvent){
    //   yield BlankState();
    //   await Future.delayed(Duration(seconds: 2));
    //   print('RegisterEvent in bloc');
    //   var registerResult = await register(RegisterParams(
    //     phoneNumber: event.phone, 
    //     lastName: event.lastName, 
    //     firstName: event.firstName,
    //     avatar: event.avatar,
    //     promocode: event.promocode
    //   ));
    //   yield registerResult.fold(
    //     (failure) {
    //       if(failure == ConnectionFailure() || failure == NetworkFailure())
    //         return InternetConnectionFailed();
    //       else if(failure is ServerFailure)
    //         return ErrorState(message: failure.message);
    //       else
    //         return ErrorState(message: 'Не смогли зарегестрировать');
    //     },
    //     (String? promo) {
    //       return RequiredGetUserInfoState(showModalPromocode: sl<MainConfigApp>().configApp != null ? sl<MainConfigApp>().configApp!.afterRegister : false, promocode: promo);
    //     }
        
    //   );
      
    // }








    // if(event is LogoutEvent){
    //   print('LogoutEvent in bloc');
    //   var logoutResult = await logout(NoParams());
    //   yield logoutResult.fold(
    //     (failure) {
    //       if(failure == ConnectionFailure() || failure == NetworkFailure())
    //         return InternetConnectionFailed();
    //       else
    //         return ErrorState(message: 'Не смогли выйти');
    //     },
    //     (bool isExited) {
          
    //       sl<AuthConfig>().phone = null;
    //       sl<AuthConfig>().userEntity = null;
    //       sl<AuthConfig>().token = null;
    //       sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
    //       setUserDataHelper(changeAddressOnProfileAddress: false);
    //       return RequiredCheckState();
          
    //     }
        
    //   );
      
    // }
   
   
   
   
    // if(event is InternetErrorEvent){
    //   print("--- INTERNET CONNTECTION ERROR ---");
    //   yield InternetErrorState();
    // } 
    // if(event is ServerErrorEvent){
    //   print("--- SERVER CONNTECTION ERROR ---");
    //   yield ServerErrorState();
    // }
  }
}
