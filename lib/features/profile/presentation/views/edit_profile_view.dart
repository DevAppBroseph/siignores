import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/modals/password_created_modal.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:siignores/features/profile/presentation/widgets/profile_photo_picker.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/btns/primary_btn.dart';
import '../../../../core/widgets/loaders/overlay_loader.dart';



class EditProfileView extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  String errorFirstName = 'Введите имя';
  String errorEmail = 'Введите email';
  String errorLastName = 'Введите фамилию';

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void saveTap(BuildContext context){
    if(formKey.currentState!.validate()){
      showLoaderWrapper(context);
      context.read<ProfileBloc>().add(UpdateUserInfoEvent(
        firstName: firstNameController.text.trim(), 
        lastName: lastNameController.text.trim()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black,
        title: Text('Редактировать профиль', style: TextStyles.title_app_bar,),
        leading: BackAppbarBtn(
          onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(view: 3)),
        )
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is ChangedSuccessState){
            Loader.hide();
            showSuccessAlertToast('Успешно сохранили');
            context.read<MainScreenBloc>().add(ChangeViewEvent(view: 3));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h,),
                    ProfilePhotoPicker(
                      isVerified: false,
                      borderColor: ColorStyles.backgroundColor,
                      onTap: (){},
                    ),
                    SizedBox(height: 20.h,),
                    DefaultTextFormField(
                      hint: 'Юлия',
                      title: 'Имя',
                      validator: (v){
                        if((v ?? '').length > 1){
                          return null;
                        }
                        return errorFirstName;
                      },
                      controller: firstNameController,
                    ),
                    SizedBox(height: 32.h,),
                    DefaultTextFormField(
                      hint: 'Бойкова',
                      title: 'Фамилия',
                      validator: (v){
                        if((v ?? '').length > 1){
                          return null;
                        }
                        return errorLastName;
                      },
                      controller: lastNameController,
                    ),
                    SizedBox(height: 32.h,),
                    DefaultTextFormField(
                      hint: 'mail@siignores.com',
                      title: 'E-mail',
                      validator: (v){
                        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v ?? '')){
                          return null;
                        }
                        return errorEmail;
                      },
                      controller: emailController,
                    ),
                    SizedBox(height: 50.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: ColorStyles.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Изменить пароль для входа', style: TextStyles.black_15_w700,),
                          SvgPicture.asset('assets/svg/arrow_right.svg')
                        ],
                      ),
                    ),
                    SizedBox(height: 180.h,),
                  ],
                ),
              ),
            ),
          );
        }
      ),


      floatingActionButton: PrimaryBtn(
        title: 'Сохранить изменения',
        onTap: () => saveTap(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}