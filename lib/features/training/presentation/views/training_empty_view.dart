import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../widgets/module_card.dart';


enum EmptyViewType{
  first,
  second,
  third
}
class TrainingEmptyView extends StatelessWidget {
  final EmptyViewType emptyViewType;
  TrainingEmptyView({required this.emptyViewType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black,
        title: Text('Тренинг', style: TextStyles.title_app_bar,),
      ),
      body: Center(
        child: emptyViewType == EmptyViewType.first
          ? _buildFirstEmpty(context)
          : emptyViewType == EmptyViewType.second
          ? _buildSecondEmpty(context)
          : _buildThirdEmpty(context),
      )
    );
  }





  Widget _buildFirstEmpty(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Обратитесь в телеграм канал', style: TextStyles.black_17_w400,),
        SizedBox(height: 30.h,),
        Container(
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(10.w)
          ),
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/telegram_first.svg'),
              SizedBox(width: 8.w,),
              Text('@siignores', style: TextStyles.black_17_w700.copyWith(color: ColorStyles.telegram))
            ],
          ),
        ),
        SizedBox(height: 80.h,),
      ],
    );
  }




  Widget _buildSecondEmpty(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svg/telegram_second.svg'),
        SizedBox(height: 20.h,),
        Container(
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(10.w)
          ),
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
          child: Text('@siignores', style: TextStyles.black_17_w700.copyWith(color: ColorStyles.telegram))
        ),
        SizedBox(height: 15.h,),
        Text('Обратитесь в телеграм канал', style: TextStyles.black_17_w400,),
        SizedBox(height: 80.h,),
      ],
    );
  }





  Widget _buildThirdEmpty(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svg/telegram_third.svg'),
        SizedBox(height: 47.h,),
        Text('Обратитесь в телеграм канал', style: TextStyles.black_17_w400,),
        SizedBox(height: 23.h,),
        Container(
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(10.w)
          ),
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
          child: Text('@siignores', style: TextStyles.black_17_w700.copyWith(color: ColorStyles.telegram))
        ),
        SizedBox(height: 160.h,),
      ],
    );
  }
}