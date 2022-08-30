import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';
import '../../domain/entities/module_enitiy.dart';



class ModuleCard extends StatelessWidget {
  final Function() onTap;
  final int index;
  final ModuleEntity moduleEntity;
  const ModuleCard({Key? key, required this.onTap, required this.moduleEntity, this.index = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(MainConfigApp.app.isSiignores) {
      return GestureDetector(
        onTap: onTap, 
        child: Container(
          margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(14.h)
          ),
          
          child: Stack(
            children: [
              Positioned(
                bottom: 5.h,
                right: 5.h,
                child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    child: CachedImage(
                      height: 80.w,
                      isProfilePhoto: false,
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.contain,
                      borderRadius: BorderRadius.zero,
                      urlImage: moduleEntity.image == null ? null : Config.url.url+moduleEntity.image!
                    ),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(moduleEntity.title.toUpperCase(), style: TextStyles.cormorant_black_18_w400,),
                  Text(index.toString(), style: TextStyles.cormorant_black_41_w400,),
                  
                ],
              ),
            ],
          ),
        ),
      );
    }else{
      return GestureDetector(
        onTap: onTap, 
        child: Container(
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
          decoration: BoxDecoration(
            color: ColorStyles.black2,
            borderRadius: BorderRadius.circular(14.h)
          ),
          
          child: Stack(
            children: [
              Positioned(
                bottom: 5.h,
                right: 5.h,
                child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    child: CachedImage(
                      height: 60.w,
                      isProfilePhoto: false,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight,
                      borderRadius: BorderRadius.zero,
                      urlImage: moduleEntity.image == null ? null : Config.url.url+moduleEntity.image!
                    ),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(moduleEntity.title.toUpperCase(), style: MainConfigApp.app.isSiignores
                    ? TextStyles.cormorant_black_18_w400
                    : TextStyles.white_16_w300,),
                  SizedBox(height: 5.h,),
                  Text('Анализируем себя', style: TextStyles.grey_10_w400
                    .copyWith(color: ColorStyles.grey929292, fontFamily: MainConfigApp.fontFamily4 ),),
                  
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}