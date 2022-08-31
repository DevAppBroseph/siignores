import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:siignores/features/home/presentation/widgets/top_info_home.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/modals/lecture_modal.dart';
import '../../../../core/widgets/sections/group_section.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../bloc/offers/offers_bloc.dart';
import '../widgets/lecture_card.dart';
import '../widgets/lecture_loading_card.dart';
import 'calendart_test.dart';



class HomeView extends StatelessWidget {

  List<Map<String, String>> _list = [
    {
      'title': 'Лекция 4 -',
      'desc': 'выход за установки родителей'
    },
    {
      'title': 'Лекция 3 -',
      'desc': 'страх'
    },
    {
      'title': 'Лекция 2 -',
      'desc': 'выход за установки родителей'
    },
  ];
  @override
  Widget build(BuildContext context) {
    OffersBloc offersBloc = context.read<OffersBloc>();
    if(offersBloc.state is OffersInitialState){
      offersBloc.add(GetOffersEvent());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: MainConfigApp.app.isSiignores ? ColorStyles.primary : ColorStyles.backgroundColor,
      ),
      body: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    TopInfoHome(
                      notificationCount: 3, 
                      onTapByName: (){
                        context.read<MainScreenBloc>().add(ChangeViewEvent(widget: ProfileView()));
                      }, 
                      onTapNotification: (){
                        
                      }, 
                    ),
                    SizedBox(height: 28.h,),
                    Container(
                      height: 120.h,
                      child: BlocConsumer<OffersBloc, OffersState>(
                        listener: (context, state){
                          if(state is OffersErrorState){
                            showAlertToast(state.message);
                          }
                          if(state is OffersInternetErrorState){
                            context.read<AuthBloc>().add(InternetErrorEvent());
                          }
                        },
                        builder: (context, state){
                          if(state is OffersInitialState || state is OffersLoadingState){
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [1, 2, 3, 4].map((e) 
                                => LectureLoadingCard(
                                  isFirst: e == 1
                                )
                              ).toList()
                            );
                          }
                          if(state is GotSuccessOffersState){
                            if(offersBloc.offers.isEmpty){
                              return Container(
                                height: 120.h,
                                width: 412.w,
                                margin: EdgeInsets.only(right: 16.w, left: 23.w),
                                decoration: BoxDecoration(
                                  color: ColorStyles.backgroundColor,
                                  borderRadius: BorderRadius.circular(13.h)
                                ),
                                alignment: Alignment.center,
                                child: Text('Пока нет спец. предложений', style: MainConfigApp.app.isSiignores
                                    ? TextStyles.black_15_w700
                                    : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                              );
                            }
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: offersBloc.offers.map((offer) 
                              => LectureCard(
                                onTap: () => showModalLecture(context, offer),
                                offerEntity: offer,
                                isFirst: offersBloc.offers.indexOf(offer) == 0,
                              )
                            ).toList()
                          );
                        },
                      )
                    ),
                    SizedBox(height: 27.h,),
                    GroupSection()

                  ],
                ),
              ],
            ),

            SizedBox(height: 32.h,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(28.h), topRight: Radius.circular(28.h))
              ),

              child: Column(
                children: [
                  SizedBox(height: 22.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(MainConfigApp.app.isSiignores ? 'Календарь' : 'Календарь'.toUpperCase(), style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_24_w700
                          : TextStyles.black_24_w300,),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/arrow_left.svg',
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.black2,
                            ),
                            SizedBox(width: 16.w,),
                            SvgPicture.asset(
                              'assets/svg/arrow_right.svg',
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.black2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TableCalendar<Event>(
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime.now(),
                      // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      rangeStartDay: null,
                      rangeEndDay: null,
                      calendarFormat: CalendarFormat.week,
                      rangeSelectionMode: RangeSelectionMode.toggledOff,
                      eventLoader: (d){return [];},
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: CalendarStyle(
                        // Use `CalendarStyle` to customize the UI
                        outsideDaysVisible: false,
                        cellPadding: EdgeInsets.zero,
                        todayDecoration: BoxDecoration(color: ColorStyles.black, shape: BoxShape.circle),
                        defaultTextStyle: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400
                          : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                        weekendTextStyle: MainConfigApp.app.isSiignores
                          ? TextStyles.black_14_w400
                          : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                        selectedTextStyle: MainConfigApp.app.isSiignores
                          ? TextStyles.white_14_w400
                          : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                        todayTextStyle: MainConfigApp.app.isSiignores
                          ? TextStyles.white_14_w400
                          : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                        rangeHighlightColor: ColorStyles.black,
                        selectedDecoration: BoxDecoration(color: ColorStyles.black, shape: BoxShape.circle)
                        
                      ),
                      // onDaySelected: _onDaySelected,
                      // onRangeSelected: _onRangeSelected,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 6.h),
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: [
                        Text('08:00', style: TextStyles.black_12_w400,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }
}