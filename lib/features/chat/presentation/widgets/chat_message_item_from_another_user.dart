import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/features/auth/domain/entities/user_entity.dart';
import 'package:siignores/features/chat/domain/entities/chat_message_entity.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';



class ChatMessageItemFromAnotherUser extends StatelessWidget {
  final ChatMessageEntity chatMessage;
  final List<UserEntity> users;
  final bool showName;
  const ChatMessageItemFromAnotherUser({Key? key, required this.showName, required this.chatMessage, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = users.any((element) => element.id == chatMessage.from.id)
                      ? users.where((element) => element.id == chatMessage.from.id).first.color
                      : Colors.red;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 34.w,
                child: CachedImage(
                  height: 34.w,
                  borderRadius: BorderRadius.circular(34.w),
                  urlImage: chatMessage.from.avatar == null ? null : Config.url.url+chatMessage.from.avatar!,
                  isProfilePhoto: true,
                ),
              ),
              SizedBox(width: 16.w,),
              Container(
                constraints: BoxConstraints(minWidth: 50.w, maxWidth: 248.w),
                decoration: BoxDecoration(
                  color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(showName)
                    ...[Text('${chatMessage.from.firstName} ${chatMessage.from.lastName}', style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_14_w700.copyWith(color: color)
                      : TextStyles.white_14_w700.copyWith(color: color, fontFamily: MainConfigApp.fontFamily4),),
                    SizedBox(height: 4.h,)],
                    Text(chatMessage.message, style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_14_w400
                      : TextStyles.white_14_w400.copyWith(color: ColorStyles.white, fontFamily: MainConfigApp.fontFamily4),),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            children: [
              SizedBox(width: 50.w,),
              Text(DateFormat('H:mm').format(chatMessage.time), style: MainConfigApp.app.isSiignores
                ? TextStyles.black_11_w400
                .copyWith(color: ColorStyles.black.withOpacity(0.7))
                : TextStyles.black_11_w400
                .copyWith(color: ColorStyles.white.withOpacity(0.7), fontFamily: MainConfigApp.fontFamily4),),
              // Text('2:37', style: MainConfigApp.app.isSiignores
              //   ? TextStyles.black_11_w400
              //   .copyWith(color: ColorStyles.black.withOpacity(0.7))
              //   : TextStyles.black_11_w400
              //   .copyWith(color: ColorStyles.white.withOpacity(0.7), fontFamily: MainConfigApp.fontFamily4),),
            ],
          )
        ],
      ),
    );
  }
}