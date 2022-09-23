import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/widgets/btns/close_modal_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import '../../../constants/texts/text_styles.dart';

class TestCompleteModal {
  BuildContext context;
  int allQuestions;
  int correctQuestions;

  TestCompleteModal({required this.context, required this.allQuestions, required this.correctQuestions});
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.h),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              Container(
                width: 343.w,
                padding: EdgeInsets.fromLTRB(32.w, 58.h, 32.w, 47.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 28.h),
                    Text(
                      MainConfigApp.app.isSiignores 
                      ? ((allQuestions-correctQuestions) > 3 ? 'Вы не сдали тест' : 'Вы успешно сдали тест') 
                      : ((allQuestions-correctQuestions) > 3 ? 'Вы не сдали тест' : 'Вы успешно сдали тест').toUpperCase(),
                      style: MainConfigApp.app.isSiignores 
                        ? TextStyles.black_26_w700
                        : TextStyles.black_26_w300,
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 23.h),
                    Text(
                      'Вы ответили правильно на $correctQuestions ${correctQuestions == 1 ? 'вопрос' : 'вопросов'} из $allQuestions',
                      style: MainConfigApp.app.isSiignores 
                        ? TextStyles.black_16_w400
                        : TextStyles.black_16_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.black2.withOpacity(0.6)),
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 23.h),
                    PrimaryBtn(
                      title: 'Хорошо',
                      width: MediaQuery.of(context).size.width, 
                      onTap: (){
                        Navigator.pop(context);
                      }
                    )
                  ],
                ),
              ),
              Positioned(
                top: 16.h,
                right: 16.h,
                child: CloseModalBtn(
                  onTap: (){
                    Navigator.pop(context);
                  }
                )
              )
            ],
          ),
        );
      },
    );
  }
}
