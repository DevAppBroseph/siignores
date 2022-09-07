import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../home/presentation/bloc/progress/progress_bloc.dart';



class ProgressSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProgressBloc progressBloc = context.read<ProgressBloc>();
    return BlocConsumer<ProgressBloc, ProgressState>(
      listener: (context, state){
        if(state is ProgressErrorState){
          showAlertToast(state.message);
        }
        if(state is ProgressInternetErrorState){
          context.read<AuthBloc>().add(InternetErrorEvent());
        }
      },
      builder: (context, state){
        if(state is ProgressInitialState || state is ProgressLoadingState){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.only(left: 23.w),
                child: Text(MainConfigApp.app.isSiignores ? 'Мой прогресс' : 'Мой прогресс'.toUpperCase(), style: MainConfigApp.app.isSiignores
                  ? TextStyles.black_24_w700
                  : TextStyles.black_24_w300.copyWith(color: ColorStyles.primary),),
              ),
              SizedBox(height: 13.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                margin: EdgeInsets.symmetric(horizontal: 23.w),
                height: 105.h,
                decoration: BoxDecoration(
                  color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.primary,
                  borderRadius: BorderRadius.circular(13.h)
                ),
              )
            ],
          );
        }
        if(state is GotSuccessProgressState){
          if(state.progress.isNotEmpty){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h,),
                Padding(
                  padding: EdgeInsets.only(left: 23.w),
                  child: Text(MainConfigApp.app.isSiignores ? 'Мой прогресс' : 'Мой прогресс'.toUpperCase(), style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_24_w700
                    : TextStyles.black_24_w300.copyWith(color: ColorStyles.primary),),
                ),
                SizedBox(height: 13.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  margin: EdgeInsets.symmetric(horizontal: 23.w),
                  height: 105.h,
                  decoration: BoxDecoration(
                    color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
                    borderRadius: BorderRadius.circular(13.h)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 66.w,
                            width: 66.w,
                            child: Transform.rotate(
                              angle: -135,
                              child: CircularProgressIndicator(
                                strokeWidth: 5.w,
                                value: progressBloc.progressList[0].verdict*0.01,
                                color: MainConfigApp.app.isSiignores ? ColorStyles.green_accent : ColorStyles.primary,
                                backgroundColor: ColorStyles.backgroundColor,
                              ),
                            ),
                          ),
                          Text('${progressBloc.progressList[0].verdict}%', style: MainConfigApp.app.isSiignores
                            ? TextStyles.cormorant_black_25_w700
                            : TextStyles.white_22_w300,)
                        ],
                      ),
                      SizedBox(width: 20.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Модуль ${progressBloc.progressList[0].completedModules}/${progressBloc.progressList[0].allModules}', style: MainConfigApp.app.isSiignores
                            ? TextStyles.black_14_w700
                            : TextStyles.black_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white),),
                          SizedBox(height: 6.h,),
                          Text('Урок ${progressBloc.progressList[0].completedLessons}/${progressBloc.progressList[0].allLessons}', style: MainConfigApp.app.isSiignores
                            ? TextStyles.black_19_w700
                            : TextStyles.black_19_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white),),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }
        }
        return SizedBox(height: 105.h+13.h+30.h+14.h,);
      },
    );
  }
}