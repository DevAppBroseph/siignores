import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/colors/color_styles.dart';

class CachedImage extends StatelessWidget {
  final BorderRadius? borderRadius;
  final String? urlImage;
  final double height;
  final bool isProfilePhoto;
  CachedImage({this.borderRadius, required this.height, required this.urlImage, required this.isProfilePhoto});


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage == null ? '' :  urlImage!,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image(
          height: height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          image: imageProvider,
        ),
      ),
      placeholder: (context, url) => Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: ColorStyles.backgroundColor,
        ),
        child: Center(
          child: LoadingAnimationWidget.fallingDot(
            color: ColorStyles.primary,
            size: 35,
          ),
        ),
      ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          height: height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          image: AssetImage(isProfilePhoto ? 'https://aikidojo.lv/wp-content/uploads/2019/08/nophoto.jpg' : 'https://diamed.ru/wp-content/uploads/2020/11/nophoto.png'),
        ),
      ),
    );
  }
}