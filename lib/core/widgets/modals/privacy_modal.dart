import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/close_modal_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';

showModalPrivacyPolicy(
  BuildContext context,
) {
  showMaterialModalBottomSheet(
      elevation: 12,
      barrierColor: Colors.black,
      duration: const Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.h),
        topRight: Radius.circular(28.h),
      )),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(0, 0, 0, 0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 11.h,
                            ),
                            Center(
                                child: SvgPicture.asset(
                                    'assets/svg/arrow_bottom_modal.svg')),
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              'Политика\nконфиденциальности',
                              style: TextStyles.black_25_w700.copyWith(
                                  fontFamily: MainConfigApp.fontFamily1),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            Text(
                              'Настоящая Политика конфиденциальности персональной информации (далее — Политика) действует в отношении всей информации, которую и/или его аффилированные лица, включая все лица, объединенные в рамках франчайзинговой сети под брендом могут получить о Пользователе (любое физическое лицо, предоставившее свои персональные данные посредством регистрации на сайте в Telegram-боте в мобильном приложении  во время использования им любого из сайтов, сервисов, служб и программ  (далее — Сервисы). Согласие Пользователя на предоставление персональной информации, данное им в соответствии с настоящей Политикой в рамках отношений с одним из лиц, входящих в «, распространяется на все лица, входящие в',
                              style: TextStyles.black_14_w400.copyWith(
                                  height: 1.9.h,
                                  fontFamily: MainConfigApp.fontFamily1),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            Text(
                              'Использование Сервисов означает безоговорочное согласие Пользователя с настоящей Политикой и указанными в ней условиями обработки его персональной информации; в случае несогласия с этими условиями Пользователь должен воздержаться от использования Сервисов.',
                              style: TextStyles.black_14_w400.copyWith(
                                  height: 1.9.h,
                                  fontFamily: MainConfigApp.fontFamily1),
                            ),
                            SizedBox(
                              height: 155.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 13.h,
                      right: 10.h,
                      child:
                          CloseModalBtn(onTap: () => Navigator.pop(context))),
                  Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorStyles.backgroundColor,
                            border: Border(
                                top: BorderSide(
                                    width: 1.h, color: ColorStyles.primary))),
                        padding: EdgeInsets.fromLTRB(16.w, 28.h, 16.w, 40.h),
                        child: PrimaryBtn(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: 'Хорошо',
                        ),
                      ))
                ],
              ));
        });
      });
}
