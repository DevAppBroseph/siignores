import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/colors/color_styles.dart';

class CachedImage extends StatelessWidget {
  final BorderRadius? borderRadius;
  final String? urlImage;
  final double height;
  final bool isProfilePhoto;
  final BoxFit fit;
  final Alignment? alignment;
  CachedImage({this.alignment, this.borderRadius, required this.height, required this.urlImage, required this.isProfilePhoto, this.fit = BoxFit.cover});


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage == null ? '' :  urlImage!,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Image(
          height: height,
          alignment: alignment ?? Alignment.center,
          width: MediaQuery.of(context).size.width,
          fit: fit,
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
          image: AssetImage(isProfilePhoto ? 'assets/images/profile.jpeg' : 'assets/images/nophoto.png'),
        ),
      ),
    );
  }
}