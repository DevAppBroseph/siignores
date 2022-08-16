import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/features/auth/presentation/widgets/text_field.dart';

import '../../../../constants/colors/color_styles.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 100, right: 100, top: 100),
                        child: SvgPicture.asset(
                          'assets/svg/logotype.svg',
                          width: 174,
                          height: 39,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 66),
                        child: CustomTextField(
                          title: 'E-mail',
                          hint: 'mail@siignores.com',
                          controller: TextEditingController(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: CustomTextField(
                          title: 'Пароль',
                          textInputType: TextInputType.visiblePassword,
                          hint: '• • • • • • • •',
                          controller: TextEditingController(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32, top: 20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {},
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
                      const SizedBox(height: 54),
                      PrimaryBtn(
                        title: 'Войти',
                        onTap: (){},
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'У Вас нет аккаунта?',
                          style: TextStyle(
                            fontFamily: 'Formular',
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {},
                          child: const Text(
                            'Зарегистрируйтесь',
                            style: TextStyle(
                              fontFamily: 'Formular',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorStyles.text_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
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
