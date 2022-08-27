import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/cards/chat_card.dart';
import '../../../../constants/colors/color_styles.dart';
import 'chat_view.dart';



class ChatTabsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: Text('Общение'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h,),
            Text('Вы состоите в 2ух группах', style: MainConfigApp.app.isSiignores
              ? TextStyles.black_15_w700
              : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
            SizedBox(height: 26.h,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, i){
                return Container(
                  margin: EdgeInsets.only(bottom: 9.h),
                  child: ChatCard(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView()));
                    },
                  )
                );
              }
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }
}