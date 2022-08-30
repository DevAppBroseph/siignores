import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/toasts.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/core/widgets/modals/password_created_modal.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:siignores/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/btns/primary_btn.dart';



class CreatePasswordView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String errorPassword = 'Введите пароль'; 
  String errorPasswordCompare = 'Пароли не совпадают'; 
  String errorPasswordShort = 'Пароль слишком короткий'; 

  TextEditingController passwordFirstController = TextEditingController();
  TextEditingController passwordSecondController = TextEditingController();

  void saveTap(BuildContext context){
    if(formKey.currentState!.validate()){
      if(passwordFirstController.text.trim() != passwordSecondController.text.trim()){
        showAlertToast(errorPasswordCompare);
      }else{
        showLoaderWrapper(context);
        context.read<RegisterBloc>().add(RegisterSetPasswordEvent(password: passwordFirstController.text.trim()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: MainConfigApp.app.isSiignores ? ColorStyles.black : ColorStyles.white,
        title: Text('Установка пароля'),
        leading: BackAppbarBtn(
          onTap: () => Navigator.pop(context),
        )
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if(state is RegisterCompletedState){
            Loader.hide();
            context.read<AuthBloc>().add(CheckUserLoggedEvent());
            await PasswordCreatedModal(context: context).showMyDialog();
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) 
        => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 29.h,),
                  MainConfigApp.app.isSiignores
                  ? Text('Установите пароль для входа в\nприложение', style: TextStyles.black_16_w400
                    .copyWith(color: ColorStyles.black.withOpacity(0.6),),
                    textAlign: TextAlign.center,
                  )
                  : Text('Установите пароль для\nвхода в приложение', style: TextStyles.black_16_w400
                    .copyWith(color: ColorStyles.white.withOpacity(0.5), fontFamily: MainConfigApp.fontFamily4),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 29.h,),
                  DefaultTextFormField(
                    controller: passwordFirstController,
                    hint: '• • • • • • • •',
                    title: 'Придумайте пароль',
                    validator: (v){
                      if((v ?? '').length == 0){
                        return errorPassword;
                      }
                      if((v ?? '').length > 8){
                        return null;
                      }
                      return errorPasswordShort;
                    },
                    textInputType: TextInputType.visiblePassword,
                  ),
                  DefaultTextFormField(
                    controller: passwordSecondController,
                    margin: EdgeInsets.only(top: 28.h),
                    hint: '• • • • • • • •',
                    title: 'Повторите пароль',
                    validator: (v){
                      if((v ?? '').length == 0){
                        return errorPassword;
                      }
                      if((v ?? '').length > 8){
                        return null;
                      }
                      return errorPasswordShort;
                    },
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 150.h,)
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: PrimaryBtn(
        title: 'Сохранить',
        onTap: () => saveTap(context)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}