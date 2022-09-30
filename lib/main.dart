import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:siignores/features/home/presentation/bloc/notifications/notifications_bloc.dart';
import 'constants/colors/color_styles.dart';
import 'constants/texts/text_styles.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/auth/presentation/views/splash_view.dart';
import 'features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'features/chat/presentation/bloc/chat_tabs/chat_tabs_bloc.dart';
import 'features/home/presentation/bloc/calendar/calendar_bloc.dart';
import 'features/home/presentation/bloc/offers/offers_bloc.dart';
import 'features/home/presentation/bloc/progress/progress_bloc.dart';
import 'features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/training/presentation/bloc/course/course_bloc.dart';
import 'features/training/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'features/training/presentation/bloc/lessons/lessons_bloc.dart';
import 'features/training/presentation/bloc/modules/module_bloc.dart';
import 'features/training/presentation/bloc/test/test_bloc.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('key is ' + (await FirebaseMessaging.instance.getToken()).toString());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  setupInjections();
  runApp(MyApp());
  initializeDateFormatting('ru');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<RegisterBloc>()),
          BlocProvider(create: (_) => sl<ForgotPasswordBloc>()),
          BlocProvider(create: (_) => sl<MainScreenBloc>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          BlocProvider(create: (_) => sl<CourseBloc>()),
          BlocProvider(create: (_) => sl<ModuleBloc>()),
          BlocProvider(create: (_) => sl<LessonsBloc>()),
          BlocProvider(create: (_) => sl<LessonDetailBloc>()),
          BlocProvider(create: (_) => sl<ChatTabsBloc>()),
          BlocProvider(create: (_) => sl<ChatBloc>()),
          BlocProvider(create: (_) => sl<OffersBloc>()),
          BlocProvider(create: (_) => sl<ProgressBloc>()),
          BlocProvider(create: (_) => sl<CalendarBloc>()),
          BlocProvider(create: (_) => sl<NotificationsBloc>()),
          BlocProvider(create: (_) => sl<TestBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Siignores',
          theme: ThemeData(
              primaryColor: ColorStyles.primary,
              primarySwatch: ColorStyles.primarySwath,
              bottomAppBarColor: Colors.green,
              scaffoldBackgroundColor: ColorStyles.backgroundColor,
              appBarTheme: AppBarTheme(
                backgroundColor: ColorStyles.backgroundColor,
                centerTitle: true,
                titleTextStyle: MainConfigApp.app.isSiignores
                    ? TextStyles.title_app_bar
                    : TextStyles.title_app_bar2,
                elevation: 1.0,
                toolbarHeight: 64.h,
                shadowColor: MainConfigApp.app.isSiignores
                    ? ColorStyles.black
                    : ColorStyles.white,
                iconTheme: IconThemeData(
                  color: MainConfigApp.app.isSiignores
                      ? ColorStyles.black
                      : ColorStyles.white,
                ),
              )),
          home: SplashView(),
        ),
      ),
    );
  }
}
