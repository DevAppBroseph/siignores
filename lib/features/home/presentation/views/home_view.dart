import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/core/widgets/loaders/loader_v1.dart';
import 'package:siignores/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:siignores/features/home/domain/entities/calendar_entity.dart';
import 'package:siignores/features/home/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:siignores/features/home/presentation/views/calendar_view.dart';
import 'package:siignores/features/home/presentation/widgets/top_info_home.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/modals/lecture_modal.dart';
import '../../../../core/widgets/sections/group_section.dart';
import '../../../chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../bloc/offers/offers_bloc.dart';
import '../widgets/lecture_card.dart';
import '../widgets/lecture_loading_card.dart';



class HomeView extends StatefulWidget {

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime _selectedDay = DateTime.now();
  PageController pageController = PageController();
  List<CalendarEntity> eventLoader(DateTime dt){
    List<CalendarEntity> tasks = context.read<CalendarBloc>().tasks;
    List<CalendarEntity> events = [];
    for(var task in tasks){
      if(!task.nonCycle){
        if(task.period == 'daily' 
          || (task.period == 'monthly' && task.dateTime.day == dt.day)
          || (task.period == 'weekly' && task.dateTime.weekday == dt.weekday)){
          events.add(task);
        }
      }else if(isSameDay(task.dateTime, dt)){
        events.add(task);
      }
    }
    return events;
  }
  @override
  Widget build(BuildContext context) {
    OffersBloc offersBloc = context.read<OffersBloc>();
    CalendarBloc calendarBloc = context.read<CalendarBloc>();
    if(offersBloc.state is OffersInitialState){
      offersBloc.add(GetOffersEvent());
    }
    if(calendarBloc.state is CalendarInitialState){
      calendarBloc.add(GetCalendarEvent());
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
                      onTapByName: (){
                        context.read<MainScreenBloc>().add(ChangeViewEvent(view: context.read<ChatTabsBloc>().chatTabs.isNotEmpty ? 3 : 2));
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
                                  isFirst: e == 1,
                                )
                              ).toList()
                            );
                          }
                          if(state is GotSuccessOffersState){
                            if(offersBloc.offers.isEmpty){
                              return Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 23.w, left: 23.w),
                                decoration: BoxDecoration(
                                  color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.darkViolet,
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

            BlocConsumer<CalendarBloc, CalendarState>(
              listener: (context, state){
                if(state is CalendarErrorState){
                  showAlertToast(state.message);
                }
                if(state is CalendarInternetErrorState){
                  context.read<AuthBloc>().add(InternetErrorEvent());
                }
              },
              builder: (context, state){
                if(state is CalendarInitialState || state is CalendarLoadingState){
                  return Center(
                    child: LoaderV1(),
                  );
                }
                if(state is GotSuccessCalendarState && calendarBloc.tasks.isEmpty){
                  return SizedBox.shrink();
                }
                
                return Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(minHeight: 400.h),
                  padding: EdgeInsets.only(bottom: 120.h),
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
                            GestureDetector(
                              onTap: (){
                                context.read<MainScreenBloc>().add(ChangeViewEvent(widget: CalendarView()));
                              },
                              child: Text(MainConfigApp.app.isSiignores ? 'Календарь' : 'Календарь'.toUpperCase(), style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_24_w700
                                : TextStyles.black_24_w300,),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    pageController.previousPage(duration: Duration(milliseconds: 100), curve: Curves.linear);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg/arrow_left.svg',
                                    color: MainConfigApp.app.isSiignores ? null : ColorStyles.black2,
                                  ),
                                ),
                                SizedBox(width: 16.w,),
                                GestureDetector(
                                  onTap: (){
                                    pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.linear);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg/arrow_right.svg',
                                    color: MainConfigApp.app.isSiignores ? null : ColorStyles.black2,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TableCalendar<CalendarEntity>(
                          headerVisible: false,
                          onCalendarCreated: (cont){
                            pageController = cont;
                          },
                          daysOfWeekVisible: false,
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _selectedDay,
                          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay){
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          },
                          rangeStartDay: null,
                          rangeEndDay: null,
                          calendarFormat: CalendarFormat.week,
                          rangeSelectionMode: RangeSelectionMode.toggledOff,
                          eventLoader: eventLoader,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            markerDecoration: BoxDecoration(
                              color: MainConfigApp.app.isSiignores ? ColorStyles.green_accent : ColorStyles.darkViolet, 
                              shape: BoxShape.circle
                            ),
                            outsideDaysVisible: false,
                            cellPadding: EdgeInsets.zero,
                            todayDecoration: BoxDecoration(color: ColorStyles.black.withOpacity(0.7), shape: BoxShape.circle),
                            defaultTextStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_14_w400
                              : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                            weekendTextStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_14_w400
                              : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                            selectedTextStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_14_w400
                              : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                            todayTextStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.white_14_w400
                              : TextStyles.white_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                            outsideTextStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_14_w400
                              : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                            rangeHighlightColor: ColorStyles.black,
                            selectedDecoration: BoxDecoration(color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.lilac.withOpacity(0.6), shape: BoxShape.circle),
                            
                          ),
                          // onDaySelected: _onDaySelected,
                          // onRangeSelected: _onRangeSelected,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      if(calendarBloc.tasks.any((element) => isSameDay(element.dateTime, _selectedDay) 
                        || (!element.nonCycle && element.period == 'daily')
                        || (!element.nonCycle && element.period == 'monthly' && element.dateTime.day == _selectedDay.day)
                        || (!element.nonCycle && element.period == 'weekly' && element.dateTime.weekday == _selectedDay.weekday)
                      ,))
                      ...calendarBloc.tasks.where((element) => isSameDay(element.dateTime, _selectedDay) 
                        || (!element.nonCycle && element.period == 'daily')
                        || (!element.nonCycle && element.period == 'monthly' && element.dateTime.day == _selectedDay.day)
                        || (!element.nonCycle && element.period == 'weekly' && element.dateTime.weekday == _selectedDay.weekday)
                      ,).map((event)  
                        => Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 6.h),
                          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 22.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat('HH:mm').format(event.dateTime), style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_12_w400
                                  : TextStyles.black_12_w400.copyWith(fontFamily: MainConfigApp.fontFamily4)),
                              Container(
                                width: 253.w,
                                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 50.w),
                                decoration: BoxDecoration(
                                  color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.lilac.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(11.w)
                                ),
                                alignment: Alignment.center,
                                child: Text(event.header, style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_13_w400
                                  : TextStyles.black_13_w400.copyWith(fontFamily: MainConfigApp.fontFamily4), textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        )
                      ).toList(),
                      if(!calendarBloc.tasks.any((element) 
                        => isSameDay(element.dateTime, _selectedDay)
                        || (!element.nonCycle && element.period == 'daily')
                        || (!element.nonCycle && element.period == 'monthly' && element.dateTime.day == _selectedDay.day)
                        || (!element.nonCycle && element.period == 'weekly' && element.dateTime.weekday == _selectedDay.weekday)))
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        alignment: Alignment.center,
                        child: Text('Нет намеченных дел', style: MainConfigApp.app.isSiignores
                              ? TextStyles.black_15_w400
                              : TextStyles.black_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                      )
                    ],
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}