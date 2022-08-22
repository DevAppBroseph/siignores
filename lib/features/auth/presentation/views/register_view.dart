import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/toasts.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/modals/sent_code_otp_modal.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:siignores/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:siignores/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:siignores/features/auth/presentation/views/create_password_view.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/btns/back_btn.dart';
import '../../../../core/widgets/btns/primary_btn.dart';
import '../widgets/top_stage_widget.dart';

class RegisterView extends StatefulWidget {

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(mask: '######', filter: { "#": RegExp(r'[0-9]') });

  String errorEmail = 'Введите email';
  String errorFirstName = 'Введите имя';
  String errorLastName = 'Введите фамилию';
  String errorCode = 'Введите код';

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void registerTap(BuildContext context){
    if(context.read<RegisterBloc>().currentStage == CurrentStage.first){
      if(formKey.currentState!.validate()){
        showLoaderWrapper(context);
        context.read<RegisterBloc>().add(RegisterByInfoEvent(
          email: emailController.text.trim(), 
          firstName: firstNameController.text.trim(), 
          lastName: lastNameController.text.trim()
        ));
      }
    }else if(context.read<RegisterBloc>().currentStage == CurrentStage.second){
      if(formKey2.currentState!.validate()){
        showLoaderWrapper(context);
        context.read<RegisterBloc>().add(RegisterActivationCodeEvent(code: codeController.text.trim()));
      }
    }else{
      context.read<RegisterBloc>().add(RegisterSignInEvent());
    }
  }

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
            if(state is RegisterToSetPassswordViewState){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePasswordView()));
            }
            if(state is RegisterErrorState){
              Loader.hide();
              if(state.message == 'internet_error'){
                context.read<AuthBloc>().add(InternetErrorEvent());
              }else{
                showAlertToast(state.message);
              }
            }
            if(state is RegisterViewState && registerBloc.currentStage == CurrentStage.second){
              SentCodeOTPModal(context: context).showMyDialog();
            }
            if(state is! RegisterBlankState){
              setState(() {});
              Loader.hide();
            }
            if(state is ForgotPasswordCompletedState){
              showSuccessAlertToast('Успешно сменили пароль');
              Navigator.pop(context);
            }
          },
          builder: (context, state){
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
                  child: BackBtn(
                    onTap: (){
                      if(registerBloc.currentStage == CurrentStage.first){
                        Navigator.pop(context);
                      }else{
                        context.read<RegisterBloc>().add(RegisterBackEvent());
                      }
                    },
                  )
                ),
              
                if(registerBloc.currentStage == CurrentStage.first)
                  _buildFirstStage(context),
                if(registerBloc.currentStage == CurrentStage.second)
                  _buildSecondStage(context),
                if(registerBloc.currentStage == CurrentStage.third)
                  _buildThirdStage(context),
              ],
            );
          }, 
        )
            
      ),

      floatingActionButton: PrimaryBtn(
        title: registerBloc.currentStage == CurrentStage.first
        ? 'Зарегистрироватся'
        : registerBloc.currentStage == CurrentStage.second
        ? 'Продолжить'
        : 'Войти',
        onTap: () => registerTap(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFirstStage(BuildContext context){
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
            child: Text('Регистрация', style: TextStyles.black_30_w700,)
          ),
          DefaultTextFormField(
            margin: EdgeInsets.only(top: 66.h, left: 32.w, right: 32.w),
            title: 'Ваше имя',
            hint: 'Юлия',
            validator: (v){
              if((v ?? '').length > 1){
                return null;
              }
              return errorFirstName;
            },
            controller: firstNameController,
          ),
          DefaultTextFormField(
            margin: EdgeInsets.only(top: 32.h, left: 32.w, right: 32.w),
            title: 'Ваша фамилия',
            hint: 'Бойкова',
            validator: (v){
              if((v ?? '').length > 1){
                return null;
              }
              return errorLastName;
            },
            controller: lastNameController,
          ),
          DefaultTextFormField(
            margin: EdgeInsets.only(top: 32.h, left: 32.w, right: 32.w),
            title: 'E-mail',
            hint: 'mail@siignores.com',
            validator: (v){
              if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v ?? '')){
                return null;
              }
              return errorEmail;
            },
            controller: emailController,
          )
          
        ],
      ),
    );
  }

  Widget _buildSecondStage(BuildContext context){
    return Form(
      key: formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
            child: Text('Код регистрации', style: TextStyles.black_30_w700,)
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(32.w, 36.h, 16.w, 0),
            child: Text('Введите код который мы выслали \nна Ваш электронный ящик ', style: TextStyles.black_16_w400,)
          ),
          SizedBox(width: MediaQuery.of(context).size.width,),
          DefaultTextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [maskFormatter],
            margin: EdgeInsets.only(top: 27.h, left: 32.w, right: 32.w),
            title: 'Код регистрации',
            hint: '545564',
            validator: (v){
              if((v ?? '').length == 6){
                return null;
              }
              return errorCode;
            },
            controller: codeController,
          ),
          
        ],
      ),
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
                    context.read<RegisterBloc>().add(RegisterSignInEvent());
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
