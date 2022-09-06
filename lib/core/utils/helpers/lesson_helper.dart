import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';

Widget getStatusWidget(LessonListEntity lesson) {
  if (lesson.status == null) {
    return const SizedBox.shrink();
  } else if (lesson.status == 'complete') {
    return SvgPicture.asset('assets/svg/lesson_complete.svg');
  } else if (lesson.status == 'failed') {
    return SvgPicture.asset('assets/svg/lesson_failed.svg');
  } else {
    return SvgPicture.asset('assets/svg/lesson_waiting.svg');
  }
}
