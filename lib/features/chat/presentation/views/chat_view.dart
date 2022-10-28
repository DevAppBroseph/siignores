import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/services/database/auth_params.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import 'package:siignores/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:siignores/features/chat/presentation/widgets/chat_message_item_from_another_user.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../../core/widgets/modals/group_users_modal.dart';
import '../../../../locator.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../widgets/chat_message_item_from_current_user.dart';



class ChatView extends StatefulWidget {
  // final ChatTabEntity chatTabEntity;

  // ChatView({required this.chatTabEntity});

  @override
  State<ChatView> createState() => _ChatViewState();
}


class _ChatViewState extends State<ChatView> {

  TextEditingController messageController = TextEditingController();
  bool isLoading = true;
  ScrollController scrollController = ScrollController();
  late StreamSubscription<bool> keyboardSub;

  ChatTabEntity? chatTabEntity;
  bool inited = false;

  @override
  void initState() {
    context.read<ChatBloc>().isOpened = true;
    // TODO: implement initState
    super.initState();
    // context.read<ChatBloc>().add(GetChatEvent(id: widget.chatTabEntity.id));
    keyboardSub = KeyboardVisibilityController().onChange.listen((event) async{
      print('event: $event');
      if (event == true) {
        Future.delayed(Duration(milliseconds: 150), scrollToBottom);
      }
    });

  }

  void getChat(){
    if(!inited){
      context.read<ChatBloc>().add(GetChatEvent(id: chatTabEntity!.id));
    }
    inited = true;

  }
  void sendMessage() async{
    if(messageController.text.trim().length > 0){
      setState(() {
        isLoading = true;
      });
      context.read<ChatBloc>().add(SendMessageEvent(chatId: chatTabEntity!.id, message: messageController.text.trim()));
      messageController.clear();
    }
  }

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  void dispose() {
    keyboardSub.cancel();
    super.dispose();
  }
  
  @override
  void deactivate() {
    context.read<ChatBloc>().isOpened = false;
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    chatTabEntity = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['chat_tab'];
    getChat();
    ChatBloc bloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: GestureDetector(
          onTap: (){
            if(bloc.chatRoom.users.isNotEmpty && bloc.currentChatId == chatTabEntity!.id){
              showModalGroupUsers(context, bloc.chatRoom.users);
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Text(chatTabEntity!.chatName, style: MainConfigApp.app.isSiignores 
                ? TextStyles.title_app_bar
                : TextStyles.title_app_bar2,),
              Text('${chatTabEntity!.usersCount} участников', style: MainConfigApp.app.isSiignores
                ? TextStyles.black_13_w400
                : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
            ],
          ),
        ),
        leading: BackAppbarBtn(
          onTap: () => Navigator.pop(context),
        )
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state){
                if(state is ChatErrorState){
                  Loader.hide();
                  showAlertToast(state.message);
                }

                if(state is ChatInternetErrorState){
                  context.read<AuthBloc>().add(InternetErrorEvent());
                }
                if(state is GotSuccessChatState){
                  setState(() {
                    isLoading = false;
                  });
                  Future.delayed(Duration(milliseconds: 50), (){
                    if(bloc.chatRoom.messages.isNotEmpty){
                      scrollToBottom();
                    }
                  });
                }
                if(state is ChatSetStateState){
                  setState(() {
                    isLoading = false;
                  });
                  Future.delayed(Duration(milliseconds: 150), scrollToBottom);
                }
              },
              builder: (context, state){
                if(state is ChatInitialState || state is ChatLoadingState){
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoaderV1(),
                      SizedBox(height: 75.h,)
                    ],
                  );
                }

                if(bloc.chatRoom.messages.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Напишите что нибудь', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_15_w700
                        : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                      SizedBox(height: 75.h, width: MediaQuery.of(context).size.width,)
                    ],
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 56.h-7.h,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bloc.chatRoom.messages.length,
                        itemBuilder: (context, i){
                          return i == 0 
                            || bloc.chatRoom.messages[i].time.year != bloc.chatRoom.messages[i-1].time.year
                            || bloc.chatRoom.messages[i].time.month != bloc.chatRoom.messages[i-1].time.month
                            || bloc.chatRoom.messages[i].time.day != bloc.chatRoom.messages[i-1].time.day
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 7.h,),
                              Text(DateFormat('dd MMMM yyyy', 'ru').format(bloc.chatRoom.messages[i == 0 ? 0 : i].time), style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_13_w400
                                : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                              SizedBox(height: 27.h,),
                              _buildMessage(
                                context, 
                                bloc.chatRoom.messages[i], 
                                bloc.chatRoom.users,
                                i == 0 || bloc.chatRoom.messages[i-1].from.id != bloc.chatRoom.messages[i].from.id
                              )
                            ],
                          )
                          : _buildMessage(
                            context, 
                            bloc.chatRoom.messages[i], 
                            bloc.chatRoom.users,
                            i == 0 || bloc.chatRoom.messages[i-1].from.id != bloc.chatRoom.messages[i].from.id
                          );
                        }
                      ),
                      SizedBox(height: 105.h)
                    ],
                  ),
                ),
              );
              },
            )
          ),




          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details){
                if(details.delta.dy > 20){
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: Container(
                // height: 105.h,
                constraints: BoxConstraints(minHeight: 105.h),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 24.w, 30.h),
                decoration: BoxDecoration(
                  color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.w),
                    topLeft: Radius.circular(15.w),
                  ),
                ),
                child: Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/svg/chat_clip.svg',
                    //   color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                    // ),
                    // SizedBox(width: 15.w,),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        textCapitalization: TextCapitalization.sentences,
                        controller: messageController,
                        style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400
                          : TextStyles.white_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                        decoration: InputDecoration(
                          hintStyle: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400.copyWith(color: ColorStyles.black.withOpacity(0.4))
                          : TextStyles.white_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white.withOpacity(0.4)),
                          hintText: 'Написать сообщение...',
                          contentPadding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 17.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.w),
                            borderSide: BorderSide(
                              width: 1.w,
                              color: MainConfigApp.app.isSiignores ? ColorStyles.black.withOpacity(0.1) : ColorStyles.white.withOpacity(0.1)
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.w),
                            borderSide: BorderSide(
                              width: 1.w,
                              color: MainConfigApp.app.isSiignores ? ColorStyles.black.withOpacity(0.1) : ColorStyles.white.withOpacity(0.1)
                            )
                          ),
                          suffixIcon: GestureDetector(
                            onTap: sendMessage,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              child: SvgPicture.asset(
                                MainConfigApp.app.isSiignores ? 'assets/svg/send_btn.svg' : 'assets/svg/send_btn2.svg',
                              ),
                            ),
                          )
                        ),
                      ),
                    )
                  ],
                )
              ),
            )
          ),

          if(isLoading)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 105.h,
              decoration: BoxDecoration(
                color: MainConfigApp.app.isSiignores ? ColorStyles.white.withOpacity(0.5) : ColorStyles.black2.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.w),
                  topLeft: Radius.circular(15.w),
                ),
              ),
            )
          )
        ],
      ),
    );
  }



  Widget _buildMessage(BuildContext context, ChatMessageEntity chatMessageEntity, List<UserEntity> users, bool showName){
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: chatMessageEntity.from.id == sl<AuthConfig>().userEntity!.id
        ? ChatMessageItemFromCurrentUser(
          chatMessage: chatMessageEntity,
        )
        : ChatMessageItemFromAnotherUser(
          chatMessage: chatMessageEntity,
          users: users,
          showName: showName,
        )
    );
  }
}