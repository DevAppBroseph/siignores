import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/text_fields/default_text_form_field.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:siignores/features/profile/presentation/widgets/profile_photo_picker.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/services/database/auth_params.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/btns/primary_btn.dart';
import '../../../../core/widgets/loaders/overlay_loader.dart';
import '../../../../core/widgets/modals/take_photo_modal.dart';
import '../../../../locator.dart';

class EditProfileView extends StatefulWidget {
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final formKey = GlobalKey<FormState>();

  String errorFirstName = 'Введите имя';
  String errorEmail = 'Введите email';
  String errorLastName = 'Введите фамилию';

  TextEditingController emailController =
      TextEditingController(text: sl<AuthConfig>().userEntity!.email);
  TextEditingController firstNameController =
      TextEditingController(text: sl<AuthConfig>().userEntity!.firstName);
  TextEditingController lastNameController =
      TextEditingController(text: sl<AuthConfig>().userEntity!.lastName);

  void saveTap(BuildContext context) {
    if (formKey.currentState!.validate()) {
      showLoaderWrapper(context);
      context.read<ProfileBloc>().add(UpdateUserInfoEvent(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim()));
    }
  }

  File? avatar;

  void changePhotoTap(BuildContext context) {
    TakePhotoModal(
        context: context,
        title: 'Где выбрать \nизображение',
        callback: (ImageSource source) async {
          final getMedia = await ImagePicker()
              .getImage(source: source, maxWidth: 1000.0, maxHeight: 1000.0);
          if (getMedia != null) {
            final file = File(getMedia.path);
            setState(() {
              avatar = file;
            });
            showLoaderWrapper(context);
            context.read<ProfileBloc>().add(UpdateAvatarEvent(file: file));
            Navigator.pop(context);
          }
        }).showMyDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1.h,
          title: const Text(
            'Редактировать профиль',
          ),
          leading: BackAppbarBtn(
            onTap: () =>
                context.read<MainScreenBloc>().add(ChangeViewEvent(view: 3)),
          )),
      body: BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state is ChangedSuccessState) {
          Loader.hide();
          showSuccessAlertToast('Успешно сохранили');
          context.read<MainScreenBloc>().add(ChangeViewEvent(view: 3));
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  ProfilePhotoPicker(
                    isVerified: false,
                    borderColor: ColorStyles.backgroundColor,
                    urlToImage: sl<AuthConfig>().userEntity!.avatar,
                    fileImage: avatar,
                    onTap: () => changePhotoTap(context),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DefaultTextFormField(
                    hint: MainConfigApp.hintFirstname,
                    title: 'Имя',
                    validator: (v) {
                      if ((v ?? '').length > 1) {
                        return null;
                      }
                      return errorFirstName;
                    },
                    controller: firstNameController,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  DefaultTextFormField(
                    hint: MainConfigApp.hintLastname,
                    title: 'Фамилия',
                    validator: (v) {
                      if ((v ?? '').length > 1) {
                        return null;
                      }
                      return errorLastName;
                    },
                    controller: lastNameController,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  DefaultTextFormField(
                    hint: MainConfigApp.hintEmail,
                    title: 'E-mail',
                    validator: (v) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(v ?? '')) {
                        return null;
                      }
                      return errorEmail;
                    },
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: MainConfigApp.app.isSiignores
                            ? ColorStyles.white
                            : ColorStyles.black2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Изменить пароль для входа',
                          style: MainConfigApp.app.isSiignores
                              ? TextStyles.black_15_w700
                              : TextStyles.white_15_w400.copyWith(
                                  fontFamily: MainConfigApp.fontFamily4),
                        ),
                        SvgPicture.asset('assets/svg/arrow_right.svg')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280.h,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PrimaryBtn(
            title: 'Сохранить изменения',
            onTap: () => saveTap(context),
          ),
          SizedBox(
            height: 140.h,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
