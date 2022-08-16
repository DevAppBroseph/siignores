import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors/color_styles.dart';
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
          child: Text('Группа', style: TextStyles.black_24_w700,),
        ),
        SizedBox(height: 13.h,),
        ChatCard(
          centerButton: true,
        )
      ],
    );
  }
}