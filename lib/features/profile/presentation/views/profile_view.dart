import 'dart:io';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/services/database/auth_params.dart';
import 'package:siignores/core/utils/toasts.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/profile/presentation/bloc/profile/profile_bloc.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/widgets/modals/delete_account_modal.dart';
import '../../../../core/widgets/modals/privacy_modal.dart';
import '../../../../core/widgets/modals/take_photo_modal.dart';
import '../../../../core/widgets/sections/group_section.dart';
import '../../../../locator.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../chat/presentation/bloc/chat/chat_bloc.dart';
import '../widgets/profile_photo_picker.dart';
import 'edit_profile_view.dart';



class ProfileView extends StatefulWidget {

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  File? avatar;
  CustomPopupMenuController controller = CustomPopupMenuController();

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
          Navigator.pop(context);
        }
      }
    ).showMyDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MainConfigApp.app.isSiignores ? ColorStyles.primary : ColorStyles.backgroundColor,
        title: Text('Профиль', ),
        leading: Row(
          children: [
            SizedBox(width: 15.w,),
            CustomPopupMenu(
              controller: controller,
              arrowColor: ColorStyles.white,
              arrowSize: 20,
              showArrow: true,
              child: Icon(
                Icons.more_vert,
                color: MainConfigApp.app.isSiignores ? ColorStyles.black : ColorStyles.primary,
                size: 26.w,
              ),
              menuBuilder: _buildLongPressMenu,
              barrierColor: Colors.black.withOpacity(0.5),
              pressType: PressType.singleClick,
              
            )
          ],
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  context.read<ChatBloc>().add(CloseSocketEvent());
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: MainConfigApp.app.isSiignores ? ColorStyles.black : ColorStyles.primary,
                  size: 26.w,
                ),
              ),
              SizedBox(width: 15.w,)
            ],
          )
        ],
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
                          color: MainConfigApp.app.isSiignores ? ColorStyles.primary : ColorStyles.backgroundColor,
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
                        Text(MainConfigApp.app.isSiignores 
                          ? '${sl<AuthConfig>().userEntity!.firstName} ${sl<AuthConfig>().userEntity!.lastName}'
                          : '${sl<AuthConfig>().userEntity!.firstName} ${sl<AuthConfig>().userEntity!.lastName}'.toUpperCase(), style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_17_w700
                          : TextStyles.black_17_w300.copyWith(color: ColorStyles.primary),),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(sl<AuthConfig>().userEntity!.email, style: MainConfigApp.app.isSiignores
                              ? TextStyles.black_14_w700
                              : TextStyles.white_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () =>context.read<MainScreenBloc>().add(ChangeViewEvent(widget: EditProfileView())),
                              child: SvgPicture.asset(
                                'assets/svg/edit.svg',
                                color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                              )
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
                      child: Text(MainConfigApp.app.isSiignores ? 'Мой прогресс' : 'Мой прогресс'.toUpperCase(), style: MainConfigApp.app.isSiignores
                        ? TextStyles.black_24_w700
                        : TextStyles.black_24_w300.copyWith(color: ColorStyles.primary),),
                    ),
                    SizedBox(height: 13.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      height: 105.h,
                      decoration: BoxDecoration(
                        color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
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
                                    color: MainConfigApp.app.isSiignores ? ColorStyles.green_accent : ColorStyles.primary,
                                    backgroundColor: ColorStyles.backgroundColor,
                                  ),
                                ),
                              ),
                              Text('67%', style: MainConfigApp.app.isSiignores
                                ? TextStyles.cormorant_black_25_w700
                                : TextStyles.white_22_w300,)
                            ],
                          ),
                          SizedBox(width: 20.w,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Модуль 2/5', style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_14_w700
                                : TextStyles.black_14_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white),),
                              SizedBox(height: 6.h,),
                              Text('Урок 2/30', style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_19_w700
                                : TextStyles.black_19_w400.copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white),),
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
                    style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_13_w400
                      .copyWith(decoration: TextDecoration.underline)
                      : TextStyles.black_13_w400
                      .copyWith(decoration: TextDecoration.underline, fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.white.withOpacity(0.5)),
                  ),
                ),
                SizedBox(height: 20.h,),
                SvgPicture.asset('assets/svg/gastrosoft.svg'),
                SizedBox(height: 155.h,),
              ],
            ),
          );
        }
      ),
    );
  }







  Widget _buildLongPressMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.h),
      child: Container(
        width: 180.w,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        color: ColorStyles.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                controller.hideMenu();
                DeleteAccountModal(
                  context: context, 
                  onDelete: (){
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(DeleteAccountEvent());
                  }
                ).showMyDialog();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Text('Удалить аккаунт', style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_15_w500
                      : TextStyles.black_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),)
              ),
            ),
            
          ],
        )
      ),
    );
  }
}