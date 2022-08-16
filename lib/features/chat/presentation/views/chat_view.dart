import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/cards/chat_card.dart';

import '../../../../constants/colors/color_styles.dart';



class ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black,
        title: Text('Общение', style: TextStyles.title_app_bar,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h,),
            Text('Вы состоите в 2ух группах', style: TextStyles.black_15_w700,),
            SizedBox(height: 26.h,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, i){
                return Container(
                  margin: EdgeInsets.only(bottom: 9.h),
                  child: ChatCard()
                );
              }
            )
          ],
        ),
      ),
    );
  }
}