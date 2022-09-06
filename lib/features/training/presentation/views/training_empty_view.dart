import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/helpers/url_launcher.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../locator.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../widgets/module_card.dart';

enum EmptyViewType { first, second, third }

class TrainingEmptyView extends StatelessWidget {
  final EmptyViewType emptyViewType;
  const TrainingEmptyView({Key? key, required this.emptyViewType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: const Text('Тренинг'),
      ),
      body: Center(
        child: !sl<MainConfigApp>().isTelegram
        ? _buildEmpty(context)
        : emptyViewType == EmptyViewType.first
          ? _buildFirstEmpty(context)
          : emptyViewType == EmptyViewType.second
          ? _buildSecondEmpty(context)
          : _buildThirdEmpty(context),
      )
    );
  }



  Widget _buildEmpty(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Пока нет курсов', style: MainConfigApp.app.isSiignores
          ? TextStyles.black_17_w400
          : TextStyles.white_18_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
        SizedBox(height: 80.h,),
      ],
    );
  }

  Widget _buildFirstEmpty(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Обратитесь в телеграм канал',
          style: MainConfigApp.app.isSiignores
              ? TextStyles.black_17_w400
              : TextStyles.white_18_w400
                  .copyWith(fontFamily: MainConfigApp.fontFamily4),
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(10.w)),
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
          child: GestureDetector(
            onTap: () {
              launchURL(MainConfigApp.telegram);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/svg/telegram_first.svg'),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                    MainConfigApp.app.isSiignores
                        ? '@siignores'
                        : '@burn_katrina',
                    style: TextStyles.black_17_w700.copyWith(
                        color: ColorStyles.telegram,
                        fontFamily: MainConfigApp.fontFamily1))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 80.h,
        ),
      ],
    );
  }

  Widget _buildSecondEmpty(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              launchURL(MainConfigApp.telegram);
            },
            child: SvgPicture.asset('assets/svg/telegram_second.svg')),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            launchURL(MainConfigApp.telegram);
          },
          child: Container(
              decoration: BoxDecoration(
                  color: ColorStyles.white,
                  borderRadius: BorderRadius.circular(10.w)),
              padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
              child: Text('@siignores',
                  style: TextStyles.black_17_w700
                      .copyWith(color: ColorStyles.telegram))),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'Обратитесь в телеграм канал',
          style: TextStyles.black_17_w400,
        ),
        SizedBox(
          height: 80.h,
        ),
      ],
    );
  }

  Widget _buildThirdEmpty(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              launchURL(MainConfigApp.telegram);
            },
            child: SvgPicture.asset('assets/svg/telegram_third.svg')),
        SizedBox(
          height: 47.h,
        ),
        Text(
          'Обратитесь в телеграм канал',
          style: TextStyles.black_17_w400,
        ),
        SizedBox(
          height: 23.h,
        ),
        GestureDetector(
          onTap: () {
            launchURL(MainConfigApp.telegram);
          },
          child: Container(
              decoration: BoxDecoration(
                  color: ColorStyles.white,
                  borderRadius: BorderRadius.circular(10.w)),
              padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
              child: Text('@siignores',
                  style: TextStyles.black_17_w700
                      .copyWith(color: ColorStyles.telegram))),
        ),
        SizedBox(
          height: 160.h,
        ),
      ],
    );
  }
}
