import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/helpers/url_launcher.dart';
import 'package:siignores/core/widgets/btns/back_btn.dart';
import 'package:siignores/core/widgets/btns/primary_btn.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';
import 'package:siignores/core/widgets/loaders/overlay_loader.dart';
import 'package:siignores/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:siignores/features/training/data/models/lesson_detail_model.dart';
import 'package:siignores/features/training/domain/entities/module_enitiy.dart';
import 'package:siignores/features/training/presentation/bloc/lessons/lessons_bloc.dart';
import 'package:siignores/features/training/presentation/views/lessons_view.dart';
import 'package:siignores/features/training/presentation/views/video_view.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/utils/helpers/time_helper.dart';
import '../../../../core/utils/helpers/truncate_text_helper.dart';
import '../../../../core/utils/toasts.dart';
import '../../../../core/widgets/loaders/loader_v1.dart';
import '../../../../core/widgets/text_fields/default_text_form_field.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../bloc/lesson_detail/lesson_detail_bloc.dart';

class LessonDetailView extends StatefulWidget {
  final int lessonId;
  final ModuleEntity moduleEntity;
  final int courseId;
  LessonDetailView(
      {required this.courseId,
      required this.lessonId,
      required this.moduleEntity});

  @override
  State<LessonDetailView> createState() => _LessonDetailViewState();
}

class _LessonDetailViewState extends State<LessonDetailView> {
  bool showAllText = false;
  bool showVideo = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();
  String errorAnswer = 'Введите ответ';

  List<File> files = [];

  Future<void> selectFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> selectedFiles = result.paths
          .map((path) => File(path ?? Random().nextInt(1000).toString()))
          .toList();
      setState(() {
        files.addAll(selectedFiles);
      });
    }
  }

  void sendHomework(BuildContext context) {
    if (formKey.currentState!.validate()) {
      showLoaderWrapper(context);
      context.read<LessonDetailBloc>().add(
          SendHomeworkEvent(files: files, text: textController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ID: ${widget.lessonId}');
    LessonDetailBloc bloc = context.read<LessonDetailBloc>();
    if (bloc.selectedLessonId != widget.lessonId) {
      bloc.add(GetLessonDetailEvent(id: widget.lessonId));
    }
    return Scaffold(
        body: BlocConsumer<LessonDetailBloc, LessonDetailState>(
      listener: (context, state) {
        if (state is LessonDetailErrorState) {
          Loader.hide();
          showAlertToast(state.message);
        }

        if (state is LessonDetailInternetErrorState) {
          context.read<AuthBloc>().add(InternetErrorEvent());
        }
        if (state is LessonDetailLoaderHideState) {
          Loader.hide();
          if (state.message != null) {
            showSuccessAlertToast(state.message!);
          }
          bloc.add(GetLessonDetailEvent(id: widget.lessonId));
          context
              .read<LessonsBloc>()
              .add(GetLessonsEvent(id: widget.moduleEntity.id));
          setState(() {
            textController.clear();
            files.clear();
          });
        }
      },
      builder: (context, state) {
        if (state is LessonDetailInitialState ||
            state is LessonDetailLoadingState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoaderV1(),
              SizedBox(
                height: 75.h,
              )
            ],
          );
        }
        // print("Back Image is: ${Config.url.url + bloc.lesson!.backImage!}");
        print('Question is: ${bloc.lesson?.question}');
        return Stack(
          children: [
            CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  collapsedHeight: 100.h,
                  expandedHeight: 375.h,
                  leading: const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedImage(
                      height: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.zero,
                      isProfilePhoto: true,
                      urlImage: bloc.lesson?.backImage != null
                          ? Config.url.url + bloc.lesson!.backImage!
                          : null,
                    ),
                    expandedTitleScale: 1,
                    centerTitle: true,
                    title: bloc.lesson!.video != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Bounce(
                                duration: const Duration(microseconds: 110),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          VideoView(
                                        url: Config.url.url +
                                            bloc.lesson!.video!,
                                        duration: null,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MainConfigApp.app.isSiignores
                                        ? ColorStyles.white.withOpacity(0.5)
                                        : ColorStyles.primary,
                                    borderRadius: BorderRadius.circular(
                                      MainConfigApp.app.isSiignores
                                          ? 40.h
                                          : 8.h,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 14.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 38.h,
                                        height: 38.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.h),
                                            color: ColorStyles.white),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: SvgPicture.asset(
                                          'assets/svg/play.svg',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text(
                                        MainConfigApp.app.isSiignores
                                            ? 'Смотреть урок'
                                            : 'Смотреть урок'.toUpperCase(),
                                        style: MainConfigApp.app.isSiignores
                                            ? TextStyles.black_16_w700
                                            : TextStyles.black_14_w300,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(30.h),
                    child: Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: MainConfigApp.app.isSiignores
                            ? ColorStyles.backgroundColor
                            : ColorStyles.white2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.h),
                          topRight: Radius.circular(28.h),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      color: MainConfigApp.app.isSiignores
                          ? ColorStyles.backgroundColor
                          : ColorStyles.white2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (MainConfigApp.app.isSiignores)
                            Text(
                              'Урок ${bloc.lesson?.lessonNumber}',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_16_w700
                                  : TextStyles.black_16_w300,
                            ),
                          if (MainConfigApp.app.isSiignores)
                            SizedBox(
                              height: 6.h,
                            ),
                          Text(
                            bloc.lesson!.title,
                            style: MainConfigApp.app.isSiignores
                                ? TextStyles.black_24_w700
                                : TextStyles.black_24_w300,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          if (!showAllText)
                            Text(
                              truncateWithEllipsis(170, bloc.lesson!.text),
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_14_w400
                                      .copyWith(height: 1.75.h)
                                  : TextStyles.black_14_w300.copyWith(
                                      height: 1.75.h,
                                      fontFamily: MainConfigApp.fontFamily4),
                            ),
                          if (showAllText)
                            Text(
                              bloc.lesson!.text,
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_14_w400
                                      .copyWith(height: 1.75.h)
                                  : TextStyles.black_14_w300.copyWith(
                                      height: 1.75.h,
                                      fontFamily: MainConfigApp.fontFamily4),
                            ),
                          if (bloc.lesson!.text.length > 100) ...[
                            SizedBox(
                              height: 3.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showAllText = !showAllText;
                                });
                              },
                              child: Text(
                                !showAllText ? 'Еще' : 'Закрыть',
                                style: MainConfigApp.app.isSiignores
                                    ? TextStyles.black_14_w700.copyWith(
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        decoration: TextDecoration.underline)
                                    : TextStyles.black_14_w300.copyWith(
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        decoration: TextDecoration.underline,
                                        fontFamily: MainConfigApp.fontFamily4),
                              ),
                            ),
                          ],
                          SizedBox(
                            height: 30.h,
                          ),
                          if (bloc.lesson!.times.isNotEmpty) ...[
                            Text(
                              'Тайминг',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_18_w700
                                  : TextStyles.black_18_w300,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: ColorStyles.white,
                                  borderRadius: BorderRadius.circular(13.h)),
                              padding: EdgeInsets.only(
                                  left: 16.w, top: 15.h, bottom: 22.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...bloc.lesson!.times
                                      .map((time) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 16.w,
                                                    top: bloc.lesson!.times
                                                                .indexOf(
                                                                    time) ==
                                                            0
                                                        ? 0
                                                        : 15.h),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                VideoView(
                                                                  url: Config
                                                                          .url
                                                                          .url +
                                                                      bloc.lesson!
                                                                          .video!,
                                                                  duration: Duration(
                                                                      hours: time
                                                                          .hour,
                                                                      minutes: time
                                                                          .minute,
                                                                      seconds: time
                                                                          .second),
                                                                )));
                                                  },
                                                  child: Text.rich(
                                                    TextSpan(
                                                        text:
                                                            convertIntToStringTime(
                                                                time.hour,
                                                                time.minute,
                                                                time.second),
                                                        style: MainConfigApp
                                                                .app.isSiignores
                                                            ? TextStyles
                                                                .black_14_w700
                                                            : TextStyles
                                                                .black_14_w700
                                                                .copyWith(
                                                                    fontFamily:
                                                                        MainConfigApp
                                                                            .fontFamily4),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                            text:
                                                                '- ${time.text}',
                                                            style: MainConfigApp
                                                                    .app
                                                                    .isSiignores
                                                                ? TextStyles
                                                                    .black_14_w400
                                                                : TextStyles
                                                                    .black_14_w400
                                                                    .copyWith(
                                                                    fontFamily:
                                                                        MainConfigApp
                                                                            .fontFamily4,
                                                                  ),
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                              if (bloc.lesson!.times
                                                      .indexOf(time) !=
                                                  (bloc.lesson!.times.length -
                                                      1)) ...[
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 1.h,
                                                  color: ColorStyles.black
                                                      .withOpacity(0.1),
                                                ),
                                              ]
                                            ],
                                          ))
                                      .toList(),
                                  if (false) ...[
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Bounce(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(26.h),
                                              color:
                                                  ColorStyles.backgroundColor),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.w, vertical: 8.h),
                                          child: Text(
                                            'Развернуть',
                                            style: TextStyles.black_15_w700,
                                          ),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 110),
                                        onPressed: () {})
                                  ]
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ],
                          if (bloc.lesson?.question != 'null' &&
                              bloc.lesson?.question != null &&
                              bloc.lesson?.question != '')
                            Text(
                              'Задание',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_18_w700
                                  : TextStyles.black_18_w300,
                            ),
                          if (bloc.lesson?.question != 'null' &&
                              bloc.lesson?.question != null &&
                              bloc.lesson?.question != '')
                            SizedBox(
                              height: 15.h,
                            ),
                          if (bloc.lesson?.question != 'null' &&
                              bloc.lesson?.question != null &&
                              bloc.lesson?.question != '')
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: ColorStyles.white,
                                  borderRadius: BorderRadius.circular(13.h)),
                              padding: EdgeInsets.all(20.h),
                              child: Text(
                                bloc.lesson?.question == null
                                    ? 'Задания пока нет'
                                    : bloc.lesson!.question!,
                                style: MainConfigApp.app.isSiignores
                                    ? TextStyles.black_14_w400
                                        .copyWith(height: 1.75.h)
                                    : TextStyles.black_14_w300.copyWith(
                                        height: 1.75.h,
                                        fontFamily: MainConfigApp.fontFamily4,
                                      ),
                              ),
                            ),
                          if (bloc.lesson!.files.isNotEmpty) ...[
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Дополнительные материалы',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_18_w700
                                  : TextStyles.black_18_w300,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: bloc.lesson!.files
                                  .map((file) => _buildFileLink(
                                      context, file, getFileType(file.file)))
                                  .toList(),
                            ),
                          ],
                          if (bloc.lesson!.teacherAnswer != null) ...[
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              'Комментарии преподавателя',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_18_w700
                                  : TextStyles.black_18_w300,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: bloc.lesson!.teacherAnswer!
                                  .map(
                                    (answer) => SizedBox(
                                      child: ListTile(
                                        // leading: Container(
                                        //   height: 25,
                                        //   width: 25,
                                        //   decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: ColorStyles.backgroundColor,
                                        //   ),
                                        //   child: const Center(
                                        //     child: Text(
                                        //       answer.hashCode.toString(),
                                        //       style: TextStyle(
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                        subtitle: Text(
                                          DateFormat(
                                            "dd MMMM, HH:mm",
                                            'RU',
                                          ).format(answer.time.toLocal()),
                                          style: MainConfigApp.app.isSiignores
                                              ? TextStyles.black_14_w400
                                                  .copyWith(
                                                  height: 1.75.h,
                                                  color: Colors.grey[500],
                                                )
                                              : TextStyles.black_14_w300
                                                  .copyWith(
                                                  height: 1.75.h,
                                                  fontFamily:
                                                      MainConfigApp.fontFamily4,
                                                  color: Colors.grey[500],
                                                ),
                                        ),
                                        title: Text(
                                          answer.comment,
                                          style: MainConfigApp.app.isSiignores
                                              ? TextStyles.black_14_w400
                                                  .copyWith(
                                                  height: 1.75.h,
                                                )
                                              : TextStyles.black_14_w300
                                                  .copyWith(
                                                  height: 1.75.h,
                                                  fontFamily:
                                                      MainConfigApp.fontFamily4,
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                          if ((bloc.lesson!.status == null ||
                                  bloc.lesson!.status == 'failed') &&
                              (bloc.lesson?.question != 'null' &&
                                  bloc.lesson?.question != null &&
                                  bloc.lesson?.question != '')) ...[
                            SizedBox(
                              height: 27.h,
                            ),
                            Text(
                              'Написать ответ',
                              style: MainConfigApp.app.isSiignores
                                  ? TextStyles.black_18_w700
                                  : TextStyles.black_18_w300,
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Form(
                              key: formKey,
                              child: DefaultTextFormField(
                                controller: textController,
                                validator: (v) {
                                  if ((v ?? '').length > 1) {
                                    return null;
                                  }
                                  return errorAnswer;
                                },
                                hint: 'Написать ответ',
                                white: true,
                              ),
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            GestureDetector(
                              onTap: selectFiles,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorStyles.black,
                                  borderRadius: BorderRadius.circular(8.h),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/link_file.svg'),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    Text(
                                      'Прикрепить файлы',
                                      style: MainConfigApp.app.isSiignores
                                          ? TextStyles.white_12_w700
                                          : TextStyles.white_12_w400.copyWith(
                                              fontFamily:
                                                  MainConfigApp.fontFamily4),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: files
                                  .map((file) => Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: Text(
                                          '- ${basename(file.path)}',
                                          style: MainConfigApp.app.isSiignores
                                              ? TextStyles.black_13_w400
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline)
                                              : TextStyles.black_13_w400
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontFamily: MainConfigApp
                                                          .fontFamily4),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            PrimaryBtn(
                                width: MediaQuery.of(context).size.width,
                                title: 'Отправить задание',
                                onTap: () {
                                  sendHomework(context);
                                })
                          ],
                          SizedBox(
                            height: 155.h,
                          ),
                        ],
                      )),
                )
              ],
            ),
            Positioned(
              top: 58.h,
              left: 22.w,
              child: BackBtn(
                  onTap: () =>
                      context.read<MainScreenBloc>().add(ChangeViewEvent(
                              widget: LessonsView(
                            courseId: widget.courseId,
                            moduleEntity: widget.moduleEntity,
                          )))),
            ),
          ],
        );
      },
    ));
  }

  Widget _buildFileLink(
      BuildContext context, LessonFile file, FileType fileType) {
    return GestureDetector(
      onTap: () {
        launchURL(Config.url.url + file.file);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fileType.iconFile,
            SizedBox(
              width: 12.w,
            ),
            Text(
              truncateWithEllipsisLast(
                32,
                Uri.decodeFull(
                  file.file.replaceAll(RegExp('/media/'), ''),
                ),
              ),
              style: MainConfigApp.app.isSiignores
                  ? TextStyles.black_13_w400
                      .copyWith(decoration: TextDecoration.underline)
                  : TextStyles.black_13_w400.copyWith(
                      decoration: TextDecoration.underline,
                      fontFamily: MainConfigApp.fontFamily4,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FileType { doc, image, pdf }

extension FileTypeExtension on FileType {
  Widget get iconFile {
    switch (this) {
      case FileType.doc:
        return SvgPicture.asset(
          'assets/svg/doc.svg',
        );
      case FileType.image:
        return SvgPicture.asset(
          'assets/svg/jpg.svg',
        );
      default:
        return SvgPicture.asset(
          MainConfigApp.app.isSiignores
              ? 'assets/svg/pdf.svg'
              : 'assets/svg/pdf2.svg',
        );
    }
  }
}

FileType getFileType(String nameOfFile) {
  if (nameOfFile.contains('.pdf')) {
    return FileType.pdf;
  } else if (nameOfFile.contains('.doc')) {
    return FileType.doc;
  }
  return FileType.image;
}
