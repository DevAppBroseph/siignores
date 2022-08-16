import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siignores/features/chat/presentation/views/chat_view.dart';
import 'package:siignores/features/profile/presentation/views/profile_view.dart';
import 'package:siignores/features/training/presentation/views/training_view.dart';

import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/texts/text_styles.dart';
import '../../../home/presentation/views/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  final List<Widget> _screens = [
    HomeView(),
    TrainingView(),
    ChatView(),
    ProfileView()
  ];

  int _currentView = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<ChatTabsBloc>().add(GetChatTabsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentView),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
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
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: (int index) {
            setState(() {
              print('Current view: ${index}');
              _currentView = index;
            });
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
                        )
                        : SvgPicture.asset("assets/svg/home.svg",
                          height: 23.h,
                        )
                    ),
                    Text('Главная', style: TextStyles.black_12_w400)
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 6.h),
                      child: _currentView == 1
                        ? SvgPicture.asset("assets/svg/training_selected.svg",
                          height: 30.h,
                        )
                        : SvgPicture.asset("assets/svg/training.svg",
                          height: 30.h,
                        )
                    ),
                    Text('Тренинг', style: TextStyles.black_12_w400)
                  ],
                ),
              ),
              label: 'Тренинг'
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 6.h),
                      child: _currentView == 2 
                        ? SvgPicture.asset("assets/svg/chat_selected.svg",
                          height: 23.h,
                        )
                        : SvgPicture.asset("assets/svg/chat.svg",
                          height: 23.h,
                        )
                    ),
                    Text('Общение', style: TextStyles.black_12_w400)
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
                      child: _currentView == 3
                        ? SvgPicture.asset("assets/svg/profile_selected.svg",
                          height: 23.h,
                        )
                        : SvgPicture.asset("assets/svg/profile.svg",
                          height: 23.h,
                        )
                    ),
                    Text('Профиль', style: TextStyles.black_12_w400)
                  ],
                ),
              ),
              label: 'Профиль'
            ),
                
          ],
        ),
      ),
    );
  }
}
