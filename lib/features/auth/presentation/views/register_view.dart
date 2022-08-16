import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:siignores/features/auth/presentation/widgets/text_field.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/btns/primary_btn.dart';
import '../widgets/top_stage_widget.dart';

class RegisterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    RegisterBloc registerBloc = context.read<RegisterBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: ColorStyles.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state){
              },
              builder: (context, state){
                if(state is RegisterViewState || state is RegisterInitialState){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                        child: TopStageWidget(currentStage: context.read<RegisterBloc>().currentStage,)
                      ),
                      if(context.read<RegisterBloc>().currentStage != CurrentStage.third)
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: ColorStyles.white
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/svg/back.svg'),
                        ),
                      ),
                    
                      if(registerBloc.currentStage == CurrentStage.first)
                        _buildFirstStage(context),
                      if(registerBloc.currentStage == CurrentStage.second)
                        _buildSecondStage(context),
                      if(registerBloc.currentStage == CurrentStage.third)
                        _buildThirdStage(context),
                    ],
                  );
                }
                return Container();
              }, 
            )
            
      ),

      floatingActionButton: PrimaryBtn(
        title: 'Зарегистрироватся',
        onTap: (){
          if(registerBloc.currentStage == CurrentStage.first){
            registerBloc.add(RegisterSendCodeOTPEvent(email: '', firstName: '', lastName: ''));
          }else if(registerBloc.currentStage == CurrentStage.second){
            registerBloc.add(RegisterUserByOTPEvent(OTP: ''));
          }else{
            registerBloc.add(RegisterSignInEvent());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }



  Widget _buildFirstStage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(32, 36.h, 16.w, 0),
          child: Text('Регистрация', style: TextStyles.black_30_w700,)
        ),
        Padding(
          padding: const EdgeInsets.only(top: 66),
          child: CustomTextField(
            title: 'Ваше имя',
            hint: 'Юлия',
            controller: TextEditingController(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: CustomTextField(
            title: 'Ваша фамилия',
            textInputType: TextInputType.visiblePassword,
            hint: 'Бойкова',
            controller: TextEditingController(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: CustomTextField(
            title: 'E-mail',
            hint: 'mail@siignores.com',
            controller: TextEditingController(),
          ),
        ),
        
      ],
    );
  }


  Widget _buildSecondStage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(32, 36.h, 16.w, 0),
          child: Text('Код регистрации', style: TextStyles.black_30_w700,)
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(32, 36.h, 16.w, 0),
          child: Text('Введите код который мы выслали \nна Ваш электронный ящик ', style: TextStyles.black_16_w400,)
        ),
        SizedBox(width: MediaQuery.of(context).size.width,),
        Padding(
          padding: EdgeInsets.only(top: 27.h),
          child: CustomTextField(
            title: 'Код регистрации',
            hint: '545564c',
            controller: TextEditingController(),
          ),
        ),
        
        
      ],
    );
  }


  Widget _buildThirdStage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 126.h,),
        Container(
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(150)
          ),
          width: 178.w,
          height: 178.w,
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/svg/checked.svg')
        ),
        SizedBox(height: 112.h, width: MediaQuery.of(context).size.width,),
        Text('Поздравляем!', style: TextStyles.black_30_w700,),
        SizedBox(height: 24.h,),
        Text.rich(
          TextSpan(
            text: 'Вы успешно зарегистировались\nв приложении.',
            style: TextStyles.black_16_w400.copyWith(),
            children: <InlineSpan>[
              TextSpan(
                text: '\nТеперь Вы можете авторизироватся',
                style: TextStyles.black_16_w700,
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                  },
              )
            ]
          ),
          textAlign: TextAlign.center,
        ),

        
      ],
    );
  }
}
