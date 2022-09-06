import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/widgets/btns/close_modal_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import '../../../constants/texts/text_styles.dart';

class PasswordCreatedModal {
  BuildContext context;

  PasswordCreatedModal({required this.context});
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
                    MainConfigApp.app.isSiignores
                        ? Image.asset(
                            'assets/images/lock.png',
                            width: 60.w,
                          )
                        : const SizedBox.shrink(),
                    SizedBox(height: 28.h),
                    Text(
                        MainConfigApp.app.isSiignores
                            ? 'Пароль создан'
                            : 'Пароль создан'.toUpperCase(),
                        style: MainConfigApp.app.isSiignores
                            ? TextStyles.black_26_w700
                            : TextStyles.black_26_w300,
                        textAlign: TextAlign.center),
                    SizedBox(height: 23.h),
                    Text('Вы успешно создали пароль\nдля входа в приложение',
                        style: MainConfigApp.app.isSiignores
                            ? TextStyles.black_16_w400
                            : TextStyles.black_16_w400.copyWith(
                                fontFamily: MainConfigApp.fontFamily4,
                                color: ColorStyles.black2.withOpacity(0.6)),
                        textAlign: TextAlign.center),
                    SizedBox(height: 23.h),
                    PrimaryBtn(
                        title: 'Продолжить',
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              Positioned(
                  top: 16.h,
                  right: 16.h,
                  child: CloseModalBtn(onTap: () {
                    Navigator.pop(context);
                  }))
            ],
          ),
        );
      },
    );
  }
}
