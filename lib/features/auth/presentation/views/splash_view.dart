import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/services/database/auth_params.dart';
import 'package:siignores/features/auth/presentation/views/sign_in_view.dart';
import 'package:siignores/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:siignores/features/main/presentation/views/main_view.dart';
import 'package:siignores/features/training/presentation/bloc/course/course_bloc.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/modals/dialogs/top_message_dialog.dart';
import '../../../../locator.dart';
import '../../../chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import '../../../home/presentation/bloc/notifications/notifications_bloc.dart';
import '../../../home/presentation/bloc/progress/progress_bloc.dart';
import '../../../home/presentation/views/calendar_view.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
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
    context.read<AuthBloc>().add(CheckUserLoggedEvent());
  }


  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width > 550){
      setState(() {
        ScreenUtil.init(context, designSize: Size(495, 812));
      });
    }
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if(state is RequiredGetUserInfoState){
          Loader.hide();
          context.read<AuthBloc>().add(GetUserInfoEvent());
        }
        if(state is RequiredCheckState){
          context.read<AuthBloc>().add(CheckUserLoggedEvent());
        }

        if(state is ErrorState){
          Loader.hide();
          showAlertToast(state.message);
          // context.read<AuthBloc>().add(ServerErrorEvent());
        }

        if(state is InternetErrorState){
          showAlertToast('Проверьте соединение с интернетом!');
          // context.read<AuthBloc>().add(InternetErrorEvent());
        }
        if(state is CheckedState){
          if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
            context.read<ProgressBloc>().add(GetProgressEvent());
            context.read<ChatTabsBloc>().add(GetChatTabsEvent());
            context.read<CourseBloc>().add(ToInitalStateCoursesEvent());
            context.read<NotificationsBloc>().add(GetNotificationsEvent());
            context.read<ChatBloc>().add(StartSocketEvent());
          }
        }
      },
      
      builder: (context, state) {
        //Error screens
        // if(state is InternetErrorState){
        //   return InternetConnectErrorView();
        // }
        // if(state is ServerErrorState){
        //   return ServerConnectErrorView();
        // }
        
        if(state is CheckedState || state is BlankState || state is ErrorState){
          if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
            return BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state){
                if(state is NewNotificationState){
                  if(state.isNotification){
                    setState(() {
                      context.read<NotificationsBloc>().notifications.add(state.notificationEntity);
                    });
                  }else if(!context.read<ChatBloc>().isOpened){
                    TopMessageDialog().showDialog(
                      context, 
                      message: state.notificationEntity.message, 
                      onTap: (){
                        if(state.chatId == null){
                          context.read<MainScreenBloc>().add(ChangeViewEvent(widget: CalendarView()));
                        }else{
                          Navigator.pushNamed(
                            context,
                            'chat',
                            arguments: {'chat_tab': context.read<ChatTabsBloc>().chatTabs.where((element) => element.id == state.chatId).first},
                          );
                        }
                      }
                    );
                  }
                }
              },
              builder: (context, state) {
                return BlocBuilder<ChatTabsBloc, ChatTabsState>(
                  builder: (ctx, state){
                    if(state is ChatTabsLoadingState){
                      return SplashWidget(isLoading: true,);
                    }
                    return MainView();
                  }
                );
              }
            );
          }else{
            return SignInView();
          }
        }

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