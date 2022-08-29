import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/btns/back_appbar_btn.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../main/presentation/bloc/main_screen/main_screen_bloc.dart';
import '../bloc/modules/module_bloc.dart';
import '../widgets/module_card.dart';



class TrainingView extends StatelessWidget {
  final int courseId;
  TrainingView({required this.courseId});

  @override
  Widget build(BuildContext context) {
    ModuleBloc bloc = context.read<ModuleBloc>();
    if(bloc.selectedCourseId != courseId){
      bloc.add(GetModulesEvent(id: courseId));
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1.h,
        title: Text('Тренинг'),
        leading: BackAppbarBtn(
          onTap: () => context.read<MainScreenBloc>().add(ChangeViewEvent(view: 1)),
        )
      ),
      body: BlocConsumer<ModuleBloc, ModuleState>(
        listener: (context, state){
          if(state is ModuleErrorState){
            Loader.hide();
            showAlertToast(state.message);
          }

          if(state is ModuleInternetErrorState){
            context.read<AuthBloc>().add(InternetErrorEvent());
          }
        },
        builder: (context, state){
          if(state is ModuleInitialState || state is ModuleLoadingState){
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoaderV1(),
                SizedBox(height: 75.h,)
              ],
            );
          }
          if(state is GotSuccessModuleState){
            if(bloc.modules.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Пока нет модулей', style: MainConfigApp.app.isSiignores
                    ? TextStyles.black_15_w700
                    : TextStyles.white_15_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),),
                  SizedBox(height: 75.h, width: MediaQuery.of(context).size.width,)
                ],
              );
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  SizedBox(height: 15.h,),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bloc.modules.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.15
                    ), 
                    itemBuilder: (context, i){
                      return ModuleCard(
                        index: i+1,
                        moduleEntity: bloc.modules[i],
                        onTap: (){
                          context.read<MainScreenBloc>().add(ChangeViewEvent(widget: LessonsView()));
                        },
                      );
                    }
                  ),
                  SizedBox(height: 30.h,),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}