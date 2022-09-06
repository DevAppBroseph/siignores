import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/auth/presentation/views/register_view.dart';
import '../../../../constants/colors/color_styles.dart';
import '../bloc/auth/auth_bloc.dart';
import 'forgot_password_view.dart';

class SignInView extends StatefulWidget {
  SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();

  String errorEmail = 'Введите email';
  String errorPassword = 'Введите пароль';
  String errorPasswordShort = 'Пароль слишком короткий';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool showBackImage = true;
  late StreamSubscription<bool> keyboardSub;

  void signIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      showLoaderWrapper(context);
      context.read<AuthBloc>().add(SignInEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ));
    }
  }

  void scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 400));
    scrollController.animateTo(scrollController.position.maxScrollExtent - 80.h,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  void initState() {
    super.initState();
    keyboardSub = KeyboardVisibilityController().onChange.listen((event) {
      print('event: $event');
      setState(() {
        showBackImage = !event;
      });
      if (event == true) {
        scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    keyboardSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (showBackImage)
            MainConfigApp.app.isSiignores
                ? Positioned(
                    bottom: 0,
                    right: 10,
                    child: Stack(
                      children: [
                        Image(
                            width: MediaQuery.of(context).size.width * 0.9,
                            image: const AssetImage(
                                'assets/images/back_login.png')),
                        Positioned(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                  color: ColorStyles.backgroundColor),
                            )),
                        Positioned(
                            top: 0,
                            left: 40,
                            right: -50,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    const Color.fromRGBO(240, 238, 236, 0.2),
                                    ColorStyles.backgroundColor
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                : Positioned(
                    bottom: -20.h,
                    child: Image.asset('assets/images/sign_in_back.png',
                        width: MediaQuery.of(context).size.width)),
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 100.w, right: 100.w, top: 100.h),
                          child: SvgPicture.asset(
                            MainConfigApp.app.isSiignores
                                ? 'assets/svg/logotype.svg'
                                : 'assets/svg/logotype2.svg',
                            width:
                                MainConfigApp.app.isSiignores ? 174.w : 113.w,
                            height: MainConfigApp.app.isSiignores ? 39.h : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MainConfigApp.app.isSiignores ? 66.h : 27.h),
                          child: DefaultTextFormField(
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            title: 'E-mail',
                            validator: (v) {
                              if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(v ?? '')) {
                                return null;
                              }
                              return errorEmail;
                            },
                            hint: MainConfigApp.hintEmail,
                            controller: emailController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: DefaultTextFormField(
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            title: 'Пароль',
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
                            hint: '• • • • • • • •',
                            controller: passwordController,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 32.w, top: 20.h),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordView(),
                                  ),
                                );
                              },
                              child: Text(
                                'Забыли пароль?',
                                style: MainConfigApp.app.isSiignores
                                    ? TextStyles.black_15_w400.copyWith(
                                        color:
                                            ColorStyles.black.withOpacity(0.5))
                                    : TextStyles.black_15_w400.copyWith(
                                        color:
                                            ColorStyles.white.withOpacity(0.5),
                                        fontFamily: MainConfigApp.fontFamily4),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 54.h),
                        PrimaryBtn(
                          title: 'Войти',
                          onTap: () => signIn(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Text(
                            'У Вас нет аккаунта?',
                            style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_14_w400
                                : TextStyles.white_16_w400.copyWith(
                                    fontFamily: MainConfigApp.fontFamily4),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ),
                            ),
                            child: Text(
                              'Зарегистрируйтесь',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_14_w700
                                      .copyWith(color: ColorStyles.text_color)
                                  : TextStyles.white_16_w400.copyWith(
                                      fontFamily: MainConfigApp.fontFamily4,
                                      color: ColorStyles.primary),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
