import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/widgets/loaders/loader_v1.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/services/database/auth_params.dart';
import '../../../../core/utils/helpers/date_time_helper.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/image/cached_image.dart';
import '../../../../locator.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notifications/notifications_bloc.dart';
import '../views/calendar_view.dart';



class TopInfoHome extends StatelessWidget {
  final Function() onTapByName;
  TopInfoHome({Key? key, required this.onTapByName}) : super(key: key);
  
  NotificationsBloc? notificationsBloc;
  clearNotifications(){
      notificationsBloc!.add(ClearNotificationsEvent());
    // Future.delayed(Duration(seconds: 3), (){
    // });
  }
  CustomPopupMenuController controller = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    NotificationsBloc bloc = context.read<NotificationsBloc>();
    notificationsBloc = bloc;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapByName,
            child: Container(
              padding: EdgeInsets.fromLTRB(5.h, 5.h, 18.h, 5.h),
              decoration: BoxDecoration(
                border: Border.all(color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.primary, width: 2.w),
                borderRadius: BorderRadius.circular(MainConfigApp.app.isSiignores ? 30.h : 8.h)
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 33.h,
                    child: CachedImage(
                      borderRadius: BorderRadius.circular(30),
                      height: 33.h, 
                      urlImage: sl<AuthConfig>().userEntity!.avatar, 
                      isProfilePhoto: true
                    ),
                  ),
                  SizedBox(width: 7.w,),
                  Text('${sl<AuthConfig>().userEntity!.firstName} ${sl<AuthConfig>().userEntity!.lastName}', style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_16_w700
                    : TextStyles.white_16_w700.copyWith(fontFamily: MainConfigApp.fontFamily4),)
                ],
              ),
            ),
          ),
          BlocConsumer<NotificationsBloc, NotificationsState>(
            listener: (context, state){
              if(state is NotificationsErrorState){
                showAlertToast(state.message);
              }
              if(state is NotificationsInternetErrorState){
                context.read<AuthBloc>().add(InternetErrorEvent());
              }
            },
            builder: (context, state){
              return Container(
                height: 35.h,
                width: 32.h,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: bloc.notifications.isEmpty
                      ? SvgPicture.asset(
                        'assets/svg/notification.svg',
                        width: MediaQuery.of(context).size.width > 550 ? 20.w : null,
                        color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                      ) 
                      : CustomPopupMenu(
                        arrowColor: ColorStyles.white,
                        arrowSize: 20,
                        showArrow: true,
                        controller: controller,
                        child: SvgPicture.asset(
                          'assets/svg/notification.svg',
                          width: MediaQuery.of(context).size.width > 550 ? 20.w : null,
                          color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                        ),
                        menuBuilder: (){
                          return _buildLongPressMenu(context, notificationsBloc!.notifications);
                        },
                        menuOnChange: (open){
                          if(!open){
                            clearNotifications();
                          }
                        },
                        barrierColor: Colors.black.withOpacity(0.5),
                        pressType: PressType.singleClick,
                        
                      )
                    ),
                    if(bloc.notifications.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 17.w,
                        height: 17.w,
                        decoration: BoxDecoration(
                          color: MainConfigApp.app.isSiignores ? ColorStyles.green_accent : ColorStyles.darkViolet,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        alignment: Alignment.center,
                        child: Text('${bloc.notifications.length}', style: MainConfigApp.app.isSiignores 
                          ? TextStyles.white_11_w700
                          : TextStyles.white_11_w700.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                      )
                    )
                  ],
                ),
              );
            },
          )
          
        ],
      ),
    );
  }




  Widget _buildLongPressMenu(BuildContext context, List<NotificationEntity> notifications) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.h),
      child: Container(
        width: 330.w,
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        color: ColorStyles.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notifications.reversed.toList().map((not) 
            => GestureDetector(
              onTap: (){
                controller.hideMenu();
                if(not.chatId == null){
                  context.read<MainScreenBloc>().add(ChangeViewEvent(widget: CalendarView()));
                }else{
                  Navigator.pushNamed(
                    context,
                    'chat',
                    arguments: {'chat_tab': context.read<ChatTabsBloc>().chatTabs.where((element) => element.id == not.chatId).first},
                  );
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 26.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.h, color: ColorStyles.black.withOpacity(0.15))
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(not.message, style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_15_w500
                      : TextStyles.black_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                    SizedBox(height: 4.h,),
                    Text(convertToAgo(not.time), style: MainConfigApp.app.isSiignores 
                      ? TextStyles.black_13_w400
                      .copyWith(color: ColorStyles.black.withOpacity(0.5))
                      : TextStyles.black_13_w400
                      .copyWith(fontFamily: MainConfigApp.fontFamily4, color: ColorStyles.black.withOpacity(0.5)),)
                  ],
                ),
              ),
            )
          ).toList()
        )
      ),
    );
  }
}
// Container(
//                   width: double.maxFinite,
//                   height: 1.h,
//                   color: ColorStyles.black.withOpacity(0.15),
//                 ),