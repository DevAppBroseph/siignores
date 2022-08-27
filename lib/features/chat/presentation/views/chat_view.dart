import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/cards/chat_card.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/chat/presentation/widgets/chat_message_item_from_another_user.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/modals/group_users_modal.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../widgets/chat_message_item_from_current_user.dart';



class ChatView extends StatelessWidget {


  List<Widget> items = [
    ChatMessageItemFromAnotherUser(),
    ChatMessageItemFromCurrentUser(),
    ChatMessageItemFromAnotherUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: GestureDetector(
          onTap: (){
            showModalGroupUsers(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Text('Начальная', style: MainConfigApp.app.isSiignores 
                ? TextStyles.title_app_bar
                : TextStyles.title_app_bar2,),
              Text('5 участников', style: MainConfigApp.app.isSiignores
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 56.h,),
                    Text('30 июня 2022', style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_13_w400
                      : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                    SizedBox(height: 27.h,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, i){
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: items[i]
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),




          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 105.h,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 24.w, 0),
              decoration: BoxDecoration(
                color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.w),
                  topLeft: Radius.circular(15.w),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/chat_clip.svg',
                    color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                  ),
                  SizedBox(width: 15.w,),
                  Expanded(
                    child: TextFormField(
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
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: SvgPicture.asset(
                            MainConfigApp.app.isSiignores ? 'assets/svg/send_btn.svg' : 'assets/svg/send_btn2.svg',
                          ),
                        )
                      ),
                    ),
                  )
                ],
              )
            )
          )
        ],
      ),
    );
  }
}