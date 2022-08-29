import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/cards/chat_card.dart';
import 'package:siignores/features/chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import 'chat_view.dart';



class ChatTabsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ChatTabsBloc bloc = context.read<ChatTabsBloc>();
    if(bloc.state is ChatTabsInitialState){
      bloc.add(GetChatTabsEvent());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: Text('Общение'),
      ),
      body: BlocConsumer<ChatTabsBloc, ChatTabsState>(
        listener: (context, state){
          if(state is ChatTabsErrorState){
            Loader.hide();
            showAlertToast(state.message);
          }

          if(state is ChatTabsInternetErrorState){
            context.read<AuthBloc>().add(InternetErrorEvent());
          }
        },
        builder: (context, state){
          if(state is ChatTabsInitialState || state is ChatTabsLoadingState){
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoaderV1(),
                SizedBox(height: 75.h,)
              ],
            );
          }
          if(state is GotSuccessChatTabsState){
            if(bloc.chatTabs.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('У вас пока нет переписок', style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_15_w700
                    : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                  SizedBox(height: 75.h, width: MediaQuery.of(context).size.width,)
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h,),
                  Text('Вы состоите в ${bloc.chatTabs.length} ${bloc.chatTabs.length == 1 ? 'группе' : 'группах'}', style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_15_w700
                    : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                  SizedBox(height: 26.h,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bloc.chatTabs.length,
                    itemBuilder: (context, i){
                      return Container(
                        margin: EdgeInsets.only(bottom: 9.h),
                        child: ChatCard(
                          chatTabEntity: bloc.chatTabs[i],
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView(
                              chatTabEntity: bloc.chatTabs[i],
                            )));
                          },
                        )
                      );
                    }
                  ),
                  SizedBox(height: 30.h,),
                ],
              ),
            );
          }
          return Container();
        },
      )
    );
  }
}