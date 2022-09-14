import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../../constants/colors/color_styles.dart';
import '../../../constants/texts/text_styles.dart';


class TakeGalleryOrFileModal {
  BuildContext context;
  String title;
  Function(ImageSource source) tapGallery;
  Function() tapFile;

  TakeGalleryOrFileModal({required this.context, required this.tapGallery, required this.title, required this.tapFile});
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            width: MediaQuery.of(context).size.width*0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Text(
                  title,
                  style: MainConfigApp.app.isSiignores
                  ? TextStyles.black_18_w700
                  : TextStyles.black_18_w400.copyWith(fontFamily: MainConfigApp.fontFamily4),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      iconSize: 50.h,
                      onPressed: (){
                        tapGallery(ImageSource.gallery);
                      }, 
                      icon: Icon(
                        Icons.photo_library_outlined,
                        size: 50.h,
                        color: ColorStyles.primary,
                      )
                    ),
                    IconButton(
                      iconSize: 50.h,
                      onPressed: (){
                        tapFile();
                      }, 
                      icon: Icon(
                        Icons.file_copy_outlined,
                        size: 50.h,
                        color: ColorStyles.primary,
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
