import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/features/chat/domain/entities/chat_tab_entity.dart';
import '../../../constants/texts/text_styles.dart';
import '../cards/chat_card.dart';




class GroupSection extends StatelessWidget {
  const GroupSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 23.w),
          child: Text(MainConfigApp.app.isSiignores ? 'Группа' : 'Группа'.toUpperCase(), style: MainConfigApp.app.isSiignores
            ? TextStyles.black_24_w700
            : TextStyles.black_24_w300.copyWith(color: ColorStyles.primary),),
        ),
        SizedBox(height: 13.h,),
        ChatCard(
          centerButton: MainConfigApp.app.isSiignores,
          chatTabEntity: ChatTabEntity(
            chatName: 'Начальная группа',
            usersCount: 560,
            id: 0
          ),
          onTap: (){

          },
        )
      ],
    );
  }
}