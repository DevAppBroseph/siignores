

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siignores/constants/colors/color_styles.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/widgets/btns/close_modal_btn.dart';
import 'package:siignores/core/widgets/image/cached_image.dart';


showModalGroupUsers(
    BuildContext context,
  ){
  showMaterialModalBottomSheet(
    elevation: 0,
    barrierColor: ColorStyles.black.withOpacity(0.6),
    duration: Duration(milliseconds: 300),
    
    backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    context: context, 
    builder: (context){
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: MediaQuery.of(context).size.height*0.7,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0),
          
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 53.h),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.h),
                    topRight: Radius.circular(28.h),
                  ),
                  color: ColorStyles.white,
                ),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9.h,),
                        Text('Участники группы', style: TextStyles.black_27_w700,),
                        SizedBox(height: 8.h,),
                        Text(
                          'В группе 4 пользователя', 
                          style: TextStyles.black_15_w500,
                        ),
                        SizedBox(height: 11.h,),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (context, i){
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.w, color: ColorStyles.black.withOpacity(0.1))
                                )
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50.h,
                                    child: CachedImage(
                                      borderRadius: BorderRadius.circular(50.h),
                                      urlImage: 'https://aikidojo.lv/wp-content/uploads/2019/08/nophoto.jpg',
                                      isProfilePhoto: true,
                                      height: 50.h,
                                    ),
                                  ),
                                  SizedBox(width: 17.w,),
                                  Text('Администратор', style: TextStyles.black_15_w500,),
                                  SizedBox(width: 7.w,),
                                  SvgPicture.asset('assets/svg/star.svg')
                                ],
                              ),
                            );
                          }
                        ),
                        SizedBox(height: 55.h,),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 10.h,
                child: CloseModalBtn(
                  onTap: () => Navigator.pop(context)
                )
              ),
             
            ],
          )
        );
      }
    );
  });
}