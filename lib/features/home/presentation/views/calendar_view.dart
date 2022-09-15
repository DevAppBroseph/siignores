import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../../core/widgets/modals/calendar_modal.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../../domain/entities/calendar_entity.dart';
import '../bloc/calendar/calendar_bloc.dart';



class CalendarView extends StatefulWidget {
  
  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
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
    CalendarBloc bloc = context.read<CalendarBloc>();
    if(bloc.state is CalendarInitialState){
      bloc.add(GetCalendarEvent());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        shadowColor: ColorStyles.black.withOpacity(0.3),
        backgroundColor: ColorStyles.white,
        title: Text('Календарь', style: MainConfigApp.app.isSiignores ? null : TextStyles.title_app_bar2.copyWith(color: ColorStyles.black2,)),
        leading: BackAppbarBtn(
          black: true,
          onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(view: 0)),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              DateTime? dt = await showModalCalendar(
                context,
                (dt){
                  setState(() {
                    _selectedDay = dt;
                  });
                }
              );
            },
            child: SvgPicture.asset('assets/svg/calendar.svg')
          ),
          SizedBox(width: 15.w,)
        ],
      ),
      backgroundColor: ColorStyles.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 120.h),
          child: BlocConsumer<CalendarBloc, CalendarState>(
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
              
              return Column(
                children: [
                  SizedBox(height: 25.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<MainScreenBloc>().add(ChangeViewEvent(widget: CalendarView()));
                          },
                          child: Text(MainConfigApp.app.isSiignores ? DateFormat('MMMM yyyy', 'ru').format(_selectedDay).capitalize() : DateFormat('MMMM yyyy', 'ru').format(_selectedDay).toUpperCase(), style: MainConfigApp.app.isSiignores
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
                        rangeHighlightColor: ColorStyles.black,
                        selectedDecoration: BoxDecoration(color: MainConfigApp.app.isSiignores ? ColorStyles.backgroundColor : ColorStyles.lilac.withOpacity(0.6), shape: BoxShape.circle),
                        
                      ),
                      // onDaySelected: _onDaySelected,
                      // onRangeSelected: _onRangeSelected,
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  if(bloc.tasks.any((element) => isSameDay(element.dateTime, _selectedDay) 
                    || (!element.nonCycle && element.period == 'daily')
                    || (!element.nonCycle && element.period == 'monthly' && element.dateTime.day == _selectedDay.day)
                    || (!element.nonCycle && element.period == 'weekly' && element.dateTime.weekday == _selectedDay.weekday)
                  ,))
                  ...bloc.tasks.where((element) => isSameDay(element.dateTime, _selectedDay) 
                    || (!element.nonCycle && element.period == 'daily')
                    || (!element.nonCycle && element.period == 'monthly' && element.dateTime.day == _selectedDay.day)
                    || (!element.nonCycle && element.period == 'weekly' && element.dateTime.weekday == _selectedDay.weekday)
                  ,).map((event) 
                    => Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
                      margin: EdgeInsets.symmetric(horizontal: 22.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.w,
                            color: ColorStyles.grey_f1f1f1
                          )
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('HH:mm').format(event.dateTime), style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_12_w400
                                  : TextStyles.black_12_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
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
                  if(!bloc.tasks.any((element) 
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
              );
            },
          )
        ),
      ),
    );
  }
}
extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);