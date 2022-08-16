import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siignores/constants/colors/color_styles.dart';

showLoaderWrapper(BuildContext context){
  return Loader.show(
    context,
    progressIndicator: LoadingAnimationWidget.flickr(
      leftDotColor: ColorStyles.primary,
      rightDotColor: ColorStyles.black,
      size: 35,
    ),
  );
}