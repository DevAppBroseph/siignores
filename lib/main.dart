import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:siignores/features/auth/presentation/bloc/register/register_bloc.dart';
import 'constants/colors/color_styles.dart';
import 'constants/texts/text_styles.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/views/splash_view.dart';
import 'locator.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjections();
  runApp(
    MyApp()
  );
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
              backgroundColor: ColorStyles.white,
              centerTitle: true,
              titleTextStyle: TextStyles.title_app_bar,
              elevation: 1.0,
              toolbarHeight: 56,
              iconTheme: IconThemeData(
                color: ColorStyles.black,
              ),
              
            )
          ),
          home: SplashView(),
        ),
      ),
    );
  }
}
