import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/back_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/text_fields/default_text_form_field.dart';



class LessonDetailView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.black,
      body: Stack(
        children: [
          CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                collapsedHeight: 100.h,
                expandedHeight: 375.h,
                leading: SizedBox.shrink(),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedImage(
                    height: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.zero,
                    isProfilePhoto: false,
                    urlImage: 'https://aikidojo.lv/wp-content/uploads/2019/08/nophoto.jpg',
                  ),
                  expandedTitleScale: 1,
                  centerTitle: true,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MainConfigApp.app.isSiignores ? ColorStyles.white.withOpacity(0.5) : ColorStyles.primary,
                          borderRadius: BorderRadius.circular(MainConfigApp.app.isSiignores ? 40.h : 8.h)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 38.h,
                              height: 38.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.h),
                                color: ColorStyles.white
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: SvgPicture.asset('assets/svg/play.svg',),
                            ),
                            SizedBox(width: 7.w,),
                            Text(MainConfigApp.app.isSiignores ? 'Смотреть урок' : 'Смотреть урок'.toUpperCase(), style: MainConfigApp.app.isSiignores
                              ? TextStyles.black_16_w700
                              : TextStyles.black_14_w300,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(30.h),
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.white2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.h),
                        topRight: Radius.circular(28.h),
                      ),
                    ),
                  ),
                ),

              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.white2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Урок 2', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_16_w700
                        : TextStyles.black_16_w300,),
                      SizedBox(height: 6.h,),
                      Text('3 основных блока для\nформирования личного\nбренда', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_24_w700
                        : TextStyles.black_24_w300,),
                      SizedBox(height: 16.h,),
                      Text('Личный брендинг — это практика создания бренда вокруг человека, а не бизнеса. Построение личного бренда не происходит внезапно. Для того, чтобы начать видеть первые результаты, необходимо долгосрочное планирование и месяцы напряженной работы', 
                        style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400.copyWith(height: 1.75.h)
                          : TextStyles.black_14_w300.copyWith(height: 1.75.h, fontFamily: MainConfigApp.fontFamily4),),
                      SizedBox(height: 3.h,),
                      Text('Еще', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_14_w700
                        .copyWith(decorationStyle: TextDecorationStyle.dashed, decoration: TextDecoration.underline)
                        : TextStyles.black_14_w300
                        .copyWith(decorationStyle: TextDecorationStyle.dashed, decoration: TextDecoration.underline, fontFamily: MainConfigApp.fontFamily4),),
                      SizedBox(height: 30.h,),

                      if(MainConfigApp.app.isSiignores)
                      ...[
                      Text('Тайминг', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_18_w700
                        : TextStyles.black_18_w300,),
                      SizedBox(height: 15.h,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: BorderRadius.circular(13.h)
                        ),
                        padding: EdgeInsets.only(left: 16.w, top: 15.h, bottom: 22.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text.rich(
                                TextSpan(
                                  text: '00:02 ',
                                  style: TextStyles.black_14_w700,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '- почему продажи валятся и экперт не продаёт',
                                      style: TextStyles.black_14_w400,
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    )
                                  ]
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              color: ColorStyles.black.withOpacity(0.1),
                            ),
                            SizedBox(height: 15.h,),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text.rich(
                                TextSpan(
                                  text: '00:02 ',
                                  style: TextStyles.black_14_w700,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '- почему продажи валятся и экперт не продаёт',
                                      style: TextStyles.black_14_w400,
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    )
                                  ]
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              color: ColorStyles.black.withOpacity(0.1),
                            ),
                            SizedBox(height: 15.h,),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text.rich(
                                TextSpan(
                                  text: '00:02 ',
                                  style: TextStyles.black_14_w700,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '- почему продажи валятся и экперт не продаёт',
                                      style: TextStyles.black_14_w400,
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    )
                                  ]
                                ),
                              ),
                            ),

                            SizedBox(height: 18.h,),
                            Bounce(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26.h),
                                  color: ColorStyles.backgroundColor
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                                child: Text('Развернуть', style: TextStyles.black_15_w700,),
                              ), 
                              duration: const Duration(milliseconds: 110), 
                              onPressed: (){}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h,),
                      ],
                      Text('Задание', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_18_w700
                        : TextStyles.black_18_w300,),
                      SizedBox(height: 15.h,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: BorderRadius.circular(13.h)
                        ),
                        padding: EdgeInsets.all(20.h),
                        child: Text('Пожалуй, составить список своих компетенций и обнародовать их – это самое сложное задание в формировании персонального бренда.', 
                          style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400.copyWith(height: 1.75.h)
                          : TextStyles.black_14_w300.copyWith(height: 1.75.h, fontFamily: MainConfigApp.fontFamily4),)
                      ),
                      SizedBox(height: 35.h,),
                      Text('Дополнительные материалы', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_18_w700
                        : TextStyles.black_18_w300,),
                      SizedBox(height: 13.h,),
                      _buildFileLink(context, 'Описание задачи.doc', FileType.doc),
                      SizedBox(height: 13.h,),
                      _buildFileLink(context, 'Картинка.jpg', FileType.image),
                      SizedBox(height: 13.h,),
                      _buildFileLink(context, 'Документация.pdf', FileType.pdf),
                      SizedBox(height: 35.h,),
                      Text('Написать ответ', style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_18_w700
                        : TextStyles.black_18_w300,),
                      SizedBox(height: 13.h,),
                      DefaultTextFormField(
                        hint: 'Написать ответ',
                        white: true,
                      ),
                      SizedBox(height: 22.h,),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorStyles.black,
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/svg/link_file.svg'),
                            SizedBox(width: 13.w,),
                            Text('Прикрепить файлы', style: MainConfigApp.app.isSiignores
                              ? TextStyles.white_12_w700
                              : TextStyles.white_12_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),)
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h,),
                      PrimaryBtn(
                        width: MediaQuery.of(context).size.width,
                        title: 'Отправить задание', 
                        onTap: (){}
                      ),
                      SizedBox(height: 155.h,),
                    ],
                  )
                ),
              )
            ],
          ),

          Positioned(
            top: 58 .h,
            left: 22.w,
            child: BackBtn(
              onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView()))
            ),
          )
        ],
      )
    );
  }







  Widget _buildFileLink(BuildContext context, String text, FileType fileType){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        fileType.iconFile,
        SizedBox(width: 12.w,),
        Text(text, style: MainConfigApp.app.isSiignores
          ? TextStyles.black_13_w400.copyWith(decoration: TextDecoration.underline)
          : TextStyles.black_13_w400.copyWith(decoration: TextDecoration.underline, fontFamily: MainConfigApp.fontFamily4))
      ],
    );
  }
}

enum FileType {
  doc,
  image,
  pdf
}

extension FileTypeExtension on FileType{
  Widget get iconFile{
    switch (this) {
      case FileType.doc:
        return SvgPicture.asset(
          'assets/svg/doc.svg',
        );
      case FileType.image:
        return SvgPicture.asset(
          'assets/svg/jpg.svg',
        );
      default:
        return SvgPicture.asset(
          MainConfigApp.app.isSiignores ? 'assets/svg/pdf.svg' : 'assets/svg/pdf2.svg',
        );
    }
  }
}