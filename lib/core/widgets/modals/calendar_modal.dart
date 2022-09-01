

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/close_modal_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/features/home/domain/entities/calendar_entity.dart';
import 'package:siignores/features/home/domain/entities/offer_entity.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../features/home/presentation/bloc/calendar/calendar_bloc.dart';
import '../../../features/home/presentation/views/calendar_view.dart';
import '../../services/network/config.dart';


showModalCalendar(
    BuildContext context,
    Function(DateTime) onTap
  ){
  DateTime _selectedDay = DateTime.now();
  PageController pageController = PageController();
  List<CalendarEntity> eventLoader(DateTime dt){
    List<CalendarEntity> tasks = context.read<CalendarBloc>().tasks;
    List<CalendarEntity> events = [];
    for(var task in tasks){
      if(isSameDay(task.dateTime, dt)){
        events.add(task);
      }
    }
    return events;
  }

  
  
  showMaterialModalBottomSheet(
    elevation: 0,
    barrierColor: ColorStyles.black.withOpacity(0.6),
    duration: Duration(milliseconds: 300),
    
    backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    context: context, 
    builder: (context){
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: MediaQuery.of(context).size.height*0.8+50.h,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0),
          
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 53.h),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.h),
                    topRight: Radius.circular(28.h),
                  ),
                  color: ColorStyles.white,
                ),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 24.w),
                        child: Text(MainConfigApp.app.isSiignores ? 'Выбор даты' : 'Выбор даты'.toUpperCase(), style: MainConfigApp.app.isSiignores
                          ? TextStyles.black_24_w700
                          : TextStyles.black_24_w300,),
                      ),
                      SizedBox(height: 18.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(MainConfigApp.app.isSiignores ? DateFormat('MMMM yyyy', 'ru').format(_selectedDay).capitalize() : DateFormat('MMMM yyyy', 'ru').format(_selectedDay).toUpperCase(), style: MainConfigApp.app.isSiignores
                                    ? TextStyles.black_16_w700
                                    : TextStyles.black_16_w300,),
                                SizedBox(width: 10.w,),
                                SvgPicture.asset(
                                  'assets/svg/arrow_right.svg',
                                  color: MainConfigApp.app.isSiignores ? null : ColorStyles.black2,
                                )
                              ],
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
                      SizedBox(height: 28.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: TableCalendar<CalendarEntity>(
                          locale: 'ru',
                          headerVisible: false,
                          onPageChanged: (dt){
                            setState((){
                              _selectedDay = dt;
                            });
                          },
                          onCalendarCreated: (cont){
                            pageController = cont;
                          },
                          daysOfWeekVisible: true,
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
                          calendarFormat: CalendarFormat.month,
                          rangeSelectionMode: RangeSelectionMode.toggledOff,
                          eventLoader: eventLoader,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.4))
                              : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.4), fontFamily: MainConfigApp.fontFamily4),
                            weekendStyle: MainConfigApp.app.isSiignores
                              ? TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.4))
                              : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.4), fontFamily: MainConfigApp.fontFamily4)
                          ),
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
                      SizedBox(height: 30.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: PrimaryBtn(
                          width: MediaQuery.of(context).size.width,
                          title: 'Применить', 
                          onTap: (){
                            Navigator.pop(context);
                            onTap(_selectedDay);
                          }
                        ),
                      ),
                      SizedBox(height: 50.h,),
                    ],
                  )
                ),
              ),
              Positioned(
                top: 0,
                right: 10.h,
                child: CloseModalBtn(
                  onTap: () => Navigator.pop(context)
                )
              ),
             
            ],
          )
        );
      }
    );
  });
}