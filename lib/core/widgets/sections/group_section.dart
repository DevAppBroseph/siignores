import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/main_config_app.dart';
import '../../../constants/texts/text_styles.dart';
import '../../../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../features/chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import '../../../features/chat/presentation/views/chat_view.dart';
import '../../utils/toasts.dart';
import '../cards/chat_card.dart';

class GroupSection extends StatelessWidget {
  const GroupSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatTabsBloc bloc = context.read<ChatTabsBloc>();
    return BlocConsumer<ChatTabsBloc, ChatTabsState>(
      listener: (context, state) {
        if (state is ChatTabsErrorState) {
          showAlertToast(state.message);
        }
        if (state is ChatTabsInternetErrorState) {
          context.read<AuthBloc>().add(InternetErrorEvent());
        }
      },
      builder: (context, state) {
        if (state is ChatTabsInitialState || state is ChatTabsLoadingState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 23.w),
                child: Text(
                  MainConfigApp.app.isSiignores
                      ? 'Группа'
                      : 'Группа'.toUpperCase(),
                  style: MainConfigApp.app.isSiignores
                      ? TextStyles.black_24_w700
                      : TextStyles.black_24_w300
                          .copyWith(color: ColorStyles.primary),
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 23.w),
                height: 105.h,
                decoration: BoxDecoration(
                    color: MainConfigApp.app.isSiignores
                        ? ColorStyles.white
                        : ColorStyles.primary,
                    borderRadius: BorderRadius.circular(13.h)),
              )
            ],
          );
        }
        if (state is GotSuccessChatTabsState) {
          if (bloc.chatTabs.isEmpty) {
            return SizedBox(
              height: 105.h + 13.h + 23.h,
            );
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 23.w),
              child: Text(
                MainConfigApp.app.isSiignores
                    ? 'Группа'
                    : 'Группа'.toUpperCase(),
                style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_24_w700
                    : TextStyles.black_24_w300
                        .copyWith(color: ColorStyles.primary),
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            if (bloc.chatTabs.isNotEmpty)
              ChatCard(
                centerButton: MainConfigApp.app.isSiignores,
                chatTabEntity: bloc.chatTabs[0],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatView(
                                chatTabEntity: bloc.chatTabs[0],
                              )));
                },
              ),
            if (bloc.chatTabs.length >= 2) ...[
              SizedBox(
                height: 13.h,
              ),
              ChatCard(
                centerButton: MainConfigApp.app.isSiignores,
                chatTabEntity: bloc.chatTabs[1],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatView(
                                chatTabEntity: bloc.chatTabs[1],
                              )));
                },
              ),
            ]
          ],
        );
      },
    );
  }
}
