import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/features/chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import 'package:siignores/features/chat/presentation/views/chat_tabs_view.dart';
import 'package:siignores/features/profile/presentation/views/profile_view.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../training/presentation/views/courses_view.dart';
import '../bloc/main_screen/main_screen_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  final List<Widget> _screens = [
    HomeView(),
    CoursesView(),
    ProfileView()
  ];

  int _currentView = 0;
  Widget? _currentWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(context.read<ChatTabsBloc>().chatTabs.isNotEmpty){
      _screens.insert(2, ChatTabsView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainScreenBloc, MainScreenState>(
      listener: (context, state){
        if(state is MainScreenChangedState){
          setState(() {
            if(state.currentView >= _screens.length){
              _currentView = _screens.length-1;
            }else{
              _currentView = state.currentView;
            }
            _currentWidget = state.currentWidget;
          });
        }
        if(state is MainScreenSetStateState){
          setState(() {});
        }
      },
      builder: (context, state) => Scaffold(
        body: _currentWidget ?? _screens.elementAt(_currentView),
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.w),
              topLeft: Radius.circular(15.w),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.11),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, -1), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.w),
              topLeft: Radius.circular(15.w),
            ),
            child: BottomNavigationBar(
              backgroundColor: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2,
              onTap: (int index) {
                context.read<MainScreenBloc>().add(ChangeViewEvent(view: index));
              },
              currentIndex: _currentView,

              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 6.h),
                          child: _currentView == 0 
                            ? SvgPicture.asset("assets/svg/home_selected.svg",
                              height: 23.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                            )
                            : SvgPicture.asset("assets/svg/home.svg",
                              height: 23.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white.withOpacity(0.5),
                            )
                        ),
                        Text('Главная', style: MainConfigApp.app.isSiignores 
                          ? (_currentView == 0 ? TextStyles.black_12_w400 : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.7)))
                          : (_currentView == 0 ? TextStyles.white_11_w400_ff4 : TextStyles.white_11_w400_ff4.copyWith(color: ColorStyles.white.withOpacity(0.7))))
                      ],
                    ),
                  ),
                  label: 'Главная'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 3.h),
                          child: _currentView == 1
                            ? SvgPicture.asset("assets/svg/training_selected.svg",
                              height: 30.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                            )
                            : SvgPicture.asset("assets/svg/training.svg",
                              height: 30.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white.withOpacity(0.9),
                            )
                        ),
                        Text('Тренинг', style: MainConfigApp.app.isSiignores 
                          ? (_currentView == 1 ? TextStyles.black_12_w400 : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.7)))
                          : (_currentView == 1 ? TextStyles.white_11_w400_ff4 : TextStyles.white_11_w400_ff4.copyWith(color: ColorStyles.white.withOpacity(0.7)))),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ),
                  label: 'Тренинг'
                ),
                if(context.read<ChatTabsBloc>().chatTabs.isNotEmpty)
                BottomNavigationBarItem(
                  icon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 6.h),
                          child: _currentView == 2 
                            ? SvgPicture.asset(MainConfigApp.app.isSiignores ? "assets/svg/chat_selected.svg" : "assets/svg/chat_selected_white.svg",
                              height: 23.h,
                            )
                            : SvgPicture.asset("assets/svg/chat.svg",
                              height: 23.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white.withOpacity(0.9),
                            )
                        ),
                        Text('Общение', style: MainConfigApp.app.isSiignores 
                          ? (_currentView == 2 ? TextStyles.black_12_w400 : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.7)))
                          : (_currentView == 2 ? TextStyles.white_11_w400_ff4 : TextStyles.white_11_w400_ff4.copyWith(color: ColorStyles.white.withOpacity(0.7))))
                      ],
                    ),
                  ),
                  label: 'Общение'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 6.h),
                          child: _currentView == _screens.length-1
                            ? SvgPicture.asset("assets/svg/profile_selected.svg",
                              height: 23.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white,
                            )
                            : SvgPicture.asset("assets/svg/profile.svg",
                              height: 23.h,
                              color: MainConfigApp.app.isSiignores ? null : ColorStyles.white.withOpacity(0.5),
                            )
                        ),
                        Text('Профиль', style: MainConfigApp.app.isSiignores 
                          ? (_currentView == _screens.length-1 ? TextStyles.black_12_w400 : TextStyles.black_12_w400.copyWith(color: ColorStyles.black.withOpacity(0.7)))
                          : (_currentView == _screens.length-1 ? TextStyles.white_11_w400_ff4 : TextStyles.white_11_w400_ff4.copyWith(color: ColorStyles.white.withOpacity(0.7))))
                      ],
                    ),
                  ),
                  label: 'Профиль'
                ),
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}
