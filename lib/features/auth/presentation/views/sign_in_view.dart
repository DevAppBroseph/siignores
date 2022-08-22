import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/auth/presentation/views/register_view.dart';
import '../../../../constants/colors/color_styles.dart';
import '../bloc/auth/auth_bloc.dart';
import 'forgot_password_view.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  String errorEmail = 'Введите email';
  String errorPassword = 'Введите пароль'; 

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void signIn(BuildContext context){
    if(formKey.currentState!.validate()){
      showLoaderWrapper(context);
      context.read<AuthBloc>().add(
        SignInEvent(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 10,
            child: Stack(
              children: [
                Image(
                  width: MediaQuery.of(context).size.width*0.9,
                  image: AssetImage('assets/images/back_login.png')
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorStyles.backgroundColor
                    ),
                  )
                ),
                Positioned(
                  top: 0,
                  left: 40,
                  right: -50,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Color.fromRGBO(240, 238, 236, 0.2),
                          ColorStyles.backgroundColor
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          CustomScrollView(
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
                          padding:
                              EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
                          child: SvgPicture.asset(
                            'assets/svg/logotype.svg',
                            width: 174.w,
                            height: 39.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 66.h),
                          child: DefaultTextFormField(
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            title: 'E-mail',
                            validator: (v){
                              if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v ?? '')){
                                return null;
                              }
                              return errorEmail;
                            },
                            hint: 'mail@siignores.com',
                            controller: emailController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: DefaultTextFormField(
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            title: 'Пароль',
                            validator: (v){
                              if((v ?? '').length > 3){
                                return null;
                              }
                              return errorPassword;
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordView()));
                              },
                              child: Text(
                                'Забыли пароль?',
                                style: TextStyle(
                                  fontFamily: 'Formular',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(50, 50, 50, 1)
                                      .withOpacity(0.5),
                                ),
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
                            style: TextStyles.black_14_w400,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView())),
                            child: Text(
                              'Зарегистрируйтесь',
                              style: TextStyles.black_14_w700.copyWith(color: ColorStyles.text_color),
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
