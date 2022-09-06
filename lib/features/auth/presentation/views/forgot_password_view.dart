import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/toasts.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../core/widgets/btns/back_btn.dart';
import '../../../../core/widgets/btns/primary_btn.dart';
import '../bloc/forgot_password/forgot_password_bloc.dart';
import '../widgets/top_stage_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  var maskFormatter =
      MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'[0-9]')});

  String errorEmail = 'Введите email';
  String errorCode = 'Введите код';
  String errorPassword = 'Введите пароль';
  String errorPasswordCompare = 'Пароли не совпадают';
  String errorPasswordShort = 'Пароль слишком короткий';

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordFirstController = TextEditingController();
  TextEditingController passwordSecondController = TextEditingController();

  void onTap(BuildContext context) {
    if (context.read<ForgotPasswordBloc>().currentStage == CurrentStage.first) {
      if (formKey.currentState!.validate()) {
        showLoaderWrapper(context);
        context.read<ForgotPasswordBloc>().add(FPSendCodeEvent(
              email: emailController.text.trim(),
            ));
      }
    } else if (context.read<ForgotPasswordBloc>().currentStage ==
        CurrentStage.second) {
      if (formKey2.currentState!.validate()) {
        showLoaderWrapper(context);
        context
            .read<ForgotPasswordBloc>()
            .add(FPVerifyCodeEvent(code: codeController.text.trim()));
      }
    } else {
      if (formKey3.currentState!.validate()) {
        if (passwordFirstController.text.trim() !=
            passwordSecondController.text.trim()) {
          showAlertToast(errorPasswordCompare);
        } else {
          showLoaderWrapper(context);
          context.read<ForgotPasswordBloc>().add(FPSetPasswordEvent(
              password: passwordFirstController.text.trim()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ForgotPasswordBloc forgotPasswordBloc = context.read<ForgotPasswordBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: ColorStyles.backgroundColor,
      ),
      body: SingleChildScrollView(
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is FPErrorState) {
            Loader.hide();
            if (state.message == 'internet_error') {
              context.read<AuthBloc>().add(InternetErrorEvent());
            } else {
              showAlertToast(state.message);
            }
          }
          if (state is! FPBlankState) {
            setState(() {});
            Loader.hide();
          }
          if (state is ForgotPasswordCompletedState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: TopStageWidget(
                    currentStage:
                        context.read<ForgotPasswordBloc>().currentStage,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                  child: BackBtn(
                    onTap: () {
                      if (forgotPasswordBloc.currentStage ==
                          CurrentStage.first) {
                        Navigator.pop(context);
                      } else {
                        context.read<ForgotPasswordBloc>().add(FPBackEvent());
                      }
                    },
                  )),
              if (forgotPasswordBloc.currentStage == CurrentStage.first)
                _buildFirstStage(context),
              if (forgotPasswordBloc.currentStage == CurrentStage.second)
                _buildSecondStage(context),
              if (forgotPasswordBloc.currentStage == CurrentStage.third)
                _buildThirdStage(context),
            ],
          );
        },
      )),
      floatingActionButton: PrimaryBtn(
        title: forgotPasswordBloc.currentStage == CurrentStage.first
            ? 'Отправить'
            : forgotPasswordBloc.currentStage == CurrentStage.second
                ? 'Подтвердить'
                : 'Сохранить',
        onTap: () => onTap(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFirstStage(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
                child: Text(
                    MainConfigApp.app.isSiignores
                        ? 'Забыли пароль'
                        : 'Забыли пароль'.toUpperCase(),
                    style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_30_w700
                        : TextStyles.black_30_w300.copyWith(
                            color: ColorStyles.primary,
                          ))),
            Padding(
                padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
                child: Text(
                  'Введите email чтобы мы смогли\nвыслать код на ваш email',
                  style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_16_w400
                      : TextStyles.white_16_w400
                          .copyWith(fontFamily: MainConfigApp.fontFamily4),
                )),
            Padding(
              padding: EdgeInsets.only(top: 32, left: 32.w, right: 32.w),
              child: DefaultTextFormField(
                title: 'E-mail',
                hint: MainConfigApp.hintEmail,
                controller: emailController,
                validator: (v) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(v ?? '')) {
                    return null;
                  }
                  return errorEmail;
                },
              ),
            ),
            SizedBox(
              height: 150.h,
            )
          ],
        ));
  }

  Widget _buildSecondStage(BuildContext context) {
    return Form(
      key: formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 14.h,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
              child: Text(
                  MainConfigApp.app.isSiignores
                      ? 'Код подтверждения'
                      : 'Код подтверждения'.toUpperCase(),
                  style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_30_w700
                      : TextStyles.black_30_w300.copyWith(
                          color: ColorStyles.primary,
                        ))),
          Padding(
              padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
              child: Text(
                  'Введите код который мы выслали\nна Ваш электронный ящик ',
                  style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_16_w400
                      : TextStyles.white_16_w400
                          .copyWith(fontFamily: MainConfigApp.fontFamily4))),
          Padding(
            padding: EdgeInsets.only(top: 32, left: 32.w, right: 32.w),
            child: DefaultTextFormField(
              title: 'Код регистрации',
              hint: '545564',
              validator: (v) {
                if ((v ?? '').length == 6) {
                  return null;
                }
                return errorCode;
              },
              inputFormatters: [maskFormatter],
              keyboardType: TextInputType.number,
              controller: codeController,
            ),
          ),
          SizedBox(
            height: 150.h,
          )
        ],
      ),
    );
  }

  Widget _buildThirdStage(BuildContext context) {
    return Form(
      key: formKey3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
              child: Text('Новый пароль',
                  style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_30_w700
                      : TextStyles.black_30_w300.copyWith(
                          color: ColorStyles.primary,
                        ))),
          Padding(
            padding: EdgeInsets.only(top: 32.h, left: 32.w, right: 32.w),
            child: DefaultTextFormField(
              controller: passwordFirstController,
              hint: '• • • • • • • •',
              title: 'Придумайте пароль',
              validator: (v) {
                if ((v ?? '').length > 8) {
                  return null;
                }
                return errorPassword;
              },
              textInputType: TextInputType.visiblePassword,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 32.h, left: 32.w, right: 32.w),
              child: DefaultTextFormField(
                controller: passwordSecondController,
                margin: EdgeInsets.only(top: 28.h),
                hint: '• • • • • • • •',
                title: 'Повторите пароль',
                validator: (v) {
                  if ((v ?? '').length == 0) {
                    return errorPassword;
                  }
                  if ((v ?? '').length > 8) {
                    return null;
                  }
                  return errorPasswordShort;
                },
                textInputType: TextInputType.visiblePassword,
              )),
          SizedBox(
            height: 150.h,
          )
        ],
      ),
    );
  }
}
