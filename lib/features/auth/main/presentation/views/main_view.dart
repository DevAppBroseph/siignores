import 'package:econom_time_app/constants/colors/color_styles.dart';
import 'package:econom_time_app/constants/text/text_styles.dart';
import 'package:econom_time_app/core/services/database/auth_params.dart';
import 'package:econom_time_app/core/utils/injection_container.dart';
import 'package:econom_time_app/features/buyer/my_request/data/models/my_request.dart';
import 'package:econom_time_app/features/buyer/my_request/presentation/bloc/my_requests_bloc.dart';
import 'package:econom_time_app/features/buyer/my_request/presentation/views/my_request.dart';
import 'package:econom_time_app/features/buyer/profile_buyer/presentation/views/profile_buyer_screen.dart';
import 'package:econom_time_app/features/common/chat_room/presentation/bloc/chat_bloc.dart';
import 'package:econom_time_app/features/common/chat_tabs/presentation/bloc/chat_tabs_bloc.dart';
import 'package:econom_time_app/features/common/chat_tabs/presentation/views/chat_tabs.dart';
import 'package:econom_time_app/features/common/home/presentation/views/home_view.dart';
import 'package:econom_time_app/features/common/login_user/domain/entities/seller_entity.dart';
import 'package:econom_time_app/features/common/login_user/domain/entities/user_entity.dart';
import 'package:econom_time_app/features/common/login_user/presentation/views/login_enter_phone_view.dart';
import 'package:econom_time_app/features/seller/main_seller_page/logic/bloc/compilation_requests_bloc.dart';
import 'package:econom_time_app/features/seller/main_seller_page/presentation/view/main_seller_page.dart';
import 'package:econom_time_app/features/seller/proposal_seller/bloc/proposal_bloc.dart';
import 'package:econom_time_app/features/seller/proposal_seller/presentation/view/proposals_seller_screen.dart';
import 'package:econom_time_app/features/seller/selection/logic/compilation/bloc/compilation_bloc.dart';
import 'package:econom_time_app/features/seller/seller_profle/presentation/view/seller_profle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  //Это все для примера как надо брать данные
  String? token = sl<AuthConfig>().token;
  UserMode? userMode = sl<AuthConfig>().userMode;
  UserEntity? userEntity = sl<AuthConfig>().userEntity;
  SellerFullEntity? seller = sl<AuthConfig>().sellerEntity;

  // Main app for buyer(usermode is equal to buyer)
  final List<Widget> _buyerWidgets = [
    HomeView(),
    MyRequest(), //TODO: Replace with "Мои заявки" screen
    ChatTabs(), //TODO: Replace with "Чат" screen
    BuyerProfileScreen(
      userEntity: sl<AuthConfig>().userEntity,
    ), //TODO: Replace with "Профиль" screen
  ];

  // Main app for seller(usermode is equal to seller)
  final List<Widget> _sellerWidgets = [
    MainSellerPage(),
    ProposalsScreenSeller(), // Мои предллжения
    ChatTabs(), // Чат
    SellerProfileScreen(sellerFullEntity: sl<AuthConfig>().sellerEntity),
  ];

  int _currentView = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Token is $token');
    print('UserMode is $userMode');

    if (seller != null) {
      print('seller: ${seller!.name}, ${seller!.phone}');
    }
    context.read<ChatTabsBloc>().add(GetChatTabsEvent());

    if(userMode == UserMode.buyer){
      context.read<MyRequestsBloc>().add(GetMyRequestsEvent());
    }
    if (userMode == UserMode.seller) {
      if(sl<AuthConfig>().token == null){
        context.read<CompilationShowBloc>().add(LoadRequestsWithoutLogin());
      }
      else{
        
        context.read<CompilationBloc>().add(LoadRequests());
        context.read<CompilationShowBloc>().add(LoadMyCompilationMy());
      }
      context.read<ProposalBloc>().add(GetCountOfSelectedProposal());
      context.read<ProposalBloc>().add(LoadProposals());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.background_blue,
      body: userMode == UserMode.buyer
          ? _buyerWidgets.elementAt(_currentView)
          : _sellerWidgets.elementAt(_currentView),
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
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (int index) {
              if(token == null && index != 0){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) => LoginEnterPhonePage(userMode: userMode!)));
              }else{
                setState(() {
                  _currentView = index;
                });
              }
              
            },
            currentIndex: _currentView,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/images/svg/home.svg",
                      height: 25,
                      color: _currentView == 0
                          ? ColorStyles.brand_medium_blue
                          : ColorStyles.text_grey_4),
                  label: 'Главная'),
              userMode == UserMode.buyer
                  ? BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset("assets/images/svg/paper.svg",
                        height: 25,
                        color: _currentView == 1
                            ? ColorStyles.brand_medium_blue
                            : ColorStyles.text_grey_4),
                      ),
                      
                      BlocBuilder<MyRequestsBloc, MyRequestState>(
                        builder: (context, state){
                          if(context.read<MyRequestsBloc>().requests.isNotEmpty){
                            return Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: ColorStyles.brand_accent_red,
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                alignment: Alignment.center,
                                child: Text(context.read<MyRequestsBloc>().requests.length.toString(), style: TextStyles.white_13_w700,),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        }
                      )
                      
                    ],
                  ),
                  label: 'Заявки')
                  : BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                                "assets/images/svg/my_response.svg",
                                height: 25,
                                color: _currentView == 1
                                    ? ColorStyles.brand_medium_blue
                                    : ColorStyles.text_grey_4),
                          ),
                          BlocBuilder<ProposalBloc, ProposalState>(
                            builder: (context, state) {
                              if (state is GetCountOfSelectedProposalSuccess) {
                                if (state.count > 0)
                                return Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        color: ColorStyles.brand_accent_red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.count.toString(),
                                      style: TextStyles.white_13_w700,
                                    ),
                                  ),
                                );
                              }
                              if (state is GetCountOfSelectedProposalFailure) {
                                print(state.message);
                              }
                              return SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      label: 'Отклики'),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset("assets/images/svg/message.svg",
                            height: 25,
                            color: _currentView == 2
                                ? ColorStyles.brand_medium_blue
                                : ColorStyles.text_grey_4),
                      ),
                      BlocBuilder<ChatTabsBloc, ChatTabsState>(
                          builder: (context, state) {
                        if (context
                            .read<ChatTabsBloc>()
                            .unreadCount != 0) {
                          return Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: ColorStyles.brand_accent_red,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: Text(
                                context
                                    .read<ChatTabsBloc>()
                                    .unreadCount
                                    .toString(),
                                style: TextStyles.white_13_w700,
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      })
                    ],
                  ),
                  label: 'Чат'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/images/svg/profile.svg",
                      height: 25,
                      color: _currentView == 3
                          ? ColorStyles.brand_medium_blue
                          : ColorStyles.text_grey_4),
                  label: 'Профиль'),
            ],
          ),
        ),
      ),
    );
  }
}
