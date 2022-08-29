import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siignores/constants/main_config_app.dart';
import '../../../constants/colors/color_styles.dart';


class LoaderV1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        color: MainConfigApp.app.isSiignores
          ? ColorStyles.black
          : ColorStyles.primary,
        size: 30,
      ),
    );
  }
}