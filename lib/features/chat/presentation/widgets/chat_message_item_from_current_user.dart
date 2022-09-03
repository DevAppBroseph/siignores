import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';
import '../../domain/entities/chat_message_entity.dart';


class ChatMessageItemFromCurrentUser extends StatelessWidget {
  final ChatMessageEntity chatMessage;
  const ChatMessageItemFromCurrentUser({Key? key, required this.chatMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 50.w, maxWidth: 248.w),
                decoration: BoxDecoration(
                  color: MainConfigApp.app.isSiignores ? ColorStyles.primary : ColorStyles.lilac2,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Text(chatMessage.message, style: MainConfigApp.app.isSiignores
                  ? TextStyles.black_14_w700
                  : TextStyles.black_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
              ),
              SizedBox(width: 16.w,),
              SizedBox(
                width: 34.w,
                child: CachedImage(
                  height: 34.w,
                  borderRadius: BorderRadius.circular(34.w),
                  urlImage: chatMessage.from.avatar == null ? null : Config.url.url+chatMessage.from.avatar!,
                  isProfilePhoto: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat('H:mm').format(chatMessage.time), style: MainConfigApp.app.isSiignores
                ? TextStyles.black_11_w400
                .copyWith(color: ColorStyles.black.withOpacity(0.7))
                : TextStyles.black_11_w400
                .copyWith(color: ColorStyles.white.withOpacity(0.7), fontFamily: MainConfigApp.fontFamily4),),
              SizedBox(width: 50.w,),
            ],
          )
        ],
      ),
    );
  }
}