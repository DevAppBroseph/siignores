import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siignores/core/constants.dart';
import 'package:siignores/ui/widgets/button.dart';
import 'package:siignores/ui/widgets/text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: CustomScrollView(
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
                      'assets/logotype.svg',
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
                      textInputType: TextInputType.password,
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
                  CustomButton(
                    title: 'Войти',
                    controller: RoundedLoadingButtonController(),
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
                      child: Text(
                        'Зарегистрируйтесь',
                        style: TextStyle(
                          fontFamily: 'Formular',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cursorColor,
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
    );
  }
}
