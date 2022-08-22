import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/cards/chat_card.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/chat/presentation/widgets/chat_message_item_from_another_user.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/modals/group_users_modal.dart';
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
        shadowColor: ColorStyles.black,
        title: GestureDetector(
          onTap: (){
            showModalGroupUsers(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Text('Начальная', style: TextStyles.title_app_bar,),
              Text('5 участников', style: TextStyles.black_13_w400,),
            ],
          ),
        ),
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
                    Text('30 июня 2022', style: TextStyles.black_13_w400,),
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
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.w),
                  topLeft: Radius.circular(15.w),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/chat_clip.svg'),
                  SizedBox(width: 15.w,),
                  Expanded(
                    child: TextFormField(
                      style: TextStyles.black_14_w400,
                      decoration: InputDecoration(
                        hintText: 'Написать сообщение...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 17.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.w),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: ColorStyles.black.withOpacity(0.1)
                          )
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: SvgPicture.asset('assets/svg/send_btn.svg'),
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