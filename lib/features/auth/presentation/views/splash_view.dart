import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/auth/presentation/views/register_view.dart';
import 'package:siignores/features/auth/presentation/views/sign_in_view.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../bloc/auth/auth_bloc.dart';


class SplashView extends StatefulWidget {

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<AuthBloc>().add(CheckUserLoggedEvent());
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if(state is RequiredGetUserInfoState || state is LoginWithPhoneSuccessState){
          context.read<AuthBloc>().add(GetUserInfoEvent());
        }
        if(state is RequiredCheckState){
          context.read<AuthBloc>().add(CheckUserLoggedEvent());
        }

        if(state is ErrorState){
          context.read<AuthBloc>().add(ServerErrorEvent());
        }

        if(state is InternetConnectionFailed){
          context.read<AuthBloc>().add(InternetErrorEvent());
        }

        if(state is LoginCodeErrorState){
          if(state.message.length < 200){
            showAlertToast(state.message);
          }
        }
        if(state is LoginCodeSendedSuccessState || state is RequiredRegisterState){
        }
      },
      
      builder: (context, state) {
        // if(state is InternetErrorState){
        //   return InternetConnectErrorView();
        // }
        // if(state is ServerErrorState){
        //   return ServerConnectErrorView();
        // }
        
        if(state is EnterCodeState){
          // return EnterCodeView(phone: state.phone!,);
        }
        if(state is CheckedState || state is BlankState || state is ErrorState){
          return Container();
        }
        if(state is RequiredRegisterState){
          // return RegisterView();
        }
        return RegisterView();
        return SplashWidget(isLoading: true);
      },
    );
  }

}


class SplashWidget extends StatelessWidget {
  final isLoading;
  SplashWidget({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primary,
      body: Center(
        child: Text('Loading', style: TextStyles.title_app_bar,),
      ),
    );
  }
}