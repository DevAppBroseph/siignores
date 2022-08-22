import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siignores/core/services/database/auth_params.dart';
import 'package:siignores/core/utils/toasts.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/profile/presentation/bloc/profile/profile_bloc.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/widgets/modals/privacy_modal.dart';
import '../../../../core/widgets/modals/take_photo_modal.dart';
import '../../../../core/widgets/sections/group_section.dart';
import '../../../../locator.dart';
import '../widgets/profile_photo_picker.dart';
import 'edit_profile_view.dart';



class ProfileView extends StatefulWidget {

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  File? avatar;

  void changePhotoTap(BuildContext context){
    TakePhotoModal(
      context: context,
      title: 'Где выбрать \nизображение',
      callback: (ImageSource source) async{
        final getMedia = await ImagePicker().getImage(source: source, maxWidth: 1000.0, maxHeight: 1000.0);
        if (getMedia != null) {
          final file = File(getMedia.path);
          setState(() {
            avatar = file;
          });
          showLoaderWrapper(context);
          context.read<ProfileBloc>().add(UpdateAvatarEvent(file: file));
        }
      }
    ).showMyDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorStyles.primary,
        title: Text('Профиль', style: TextStyles.black_18_w400,),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is ChangedSuccessState){
            Loader.hide();
            showSuccessAlertToast('Успешно изменили аватар');
          }
        },
        builder: (context, state){
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 40.h,
                      top: -100.h,
                      right: -50.w,
                      left: -50.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorStyles.primary,
                          borderRadius: const BorderRadius.all(Radius.elliptical(130, 50)),
                        ),
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h,),
                        ProfilePhotoPicker(
                          isVerified: true,
                          fileImage: avatar,
                          urlToImage: sl<AuthConfig>().userEntity!.avatar,
                          onTap: () => changePhotoTap(context)
                        ),
                        SizedBox(height: 12.h,),
                        Text('${sl<AuthConfig>().userEntity!.firstName} ${sl<AuthConfig>().userEntity!.lastName}', style: TextStyles.black_17_w700,),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(sl<AuthConfig>().userEntity!.email, style: TextStyles.black_14_w700,),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () =>context.read<MainScreenBloc>().add(ChangeViewEvent(widget: EditProfileView())),
                              child: SvgPicture.asset('assets/svg/edit.svg',)
                            )
                          ],
                        ),
                        SizedBox(height: 14.h,),
                       
                        GroupSection()

                      ],
                    ),
                  ],
                ),

                SizedBox(height: 30.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 23.w),
                      child: Text('Мой прогресс', style: TextStyles.black_24_w700,),
                    ),
                    SizedBox(height: 13.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      height: 105.h,
                      decoration: BoxDecoration(
                        color: ColorStyles.white,
                        borderRadius: BorderRadius.circular(13.h)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 66.w,
                                width: 66.w,
                                child: Transform.rotate(
                                  angle: -135,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5.w,
                                    value: 0.67,
                                    color: ColorStyles.green_accent,
                                    backgroundColor: ColorStyles.backgroundColor,
                                  ),
                                ),
                              ),
                              Text('67%', style: TextStyles.cormorant_black_25_w700,)
                            ],
                          ),
                          SizedBox(width: 20.w,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Модуль 2/5', style: TextStyles.black_14_w700,),
                              SizedBox(height: 6.h,),
                              Text('Урок 2/30', style: TextStyles.black_19_w700,),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 37.h,),
                InkWell(
                  onTap: (){
                    showModalPrivacyPolicy(context);
                  },
                  child: Text(
                    'Политика конфиденциальности', 
                    style: TextStyles.black_13_w400
                      .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 20.h,),
                SvgPicture.asset('assets/svg/gastrosoft.svg'),
                SizedBox(height: 20.h,),
              ],
            ),
          );
        }
      ),
    );
  }
}