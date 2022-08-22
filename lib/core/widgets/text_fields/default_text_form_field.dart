import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/texts/text_styles.dart';

import '../../../constants/colors/color_styles.dart';



class DefaultTextFormField extends StatelessWidget {
  final TextInputType? textInputType;
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final double? width;
  final String? Function(String?)? validator;
  final EdgeInsets? margin;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  DefaultTextFormField({
    Key? key,
    this.width,
    required this.hint,
    this.title,
    this.validator,
    this.controller,
    this.margin,
    this.inputFormatters,
    this.keyboardType,
    this.textInputType = TextInputType.text
  }) : super(key: key);
  
  final _streamController = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _streamController.stream,
      initialData: false,
      builder: (context, snapshot) { 
        return Container(
          width: width,
          margin: margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(title != null)
              ...[
                Text(title!, style: TextStyles.black_15_w700,),
                SizedBox(height: 8.h,),
              ],
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: ColorStyles.white,
                      ),
                    )
                  ),
                  TextFormField(
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    validator: validator,
                    controller: controller,
                    obscureText: textInputType == TextInputType.visiblePassword && !snapshot.data!,
                    style: TextStyles.black_16_w400,
                    obscuringCharacter: '•',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.h),
                      hintText: hint,
                      border: InputBorder.none,
                      fillColor: ColorStyles.white,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 20.w),
                        child: textInputType == TextInputType.visiblePassword
                        ? GestureDetector(
                          onTap: (){
                            _streamController.add(!snapshot.data!);
                          },
                          child: SvgPicture.asset(
                            'assets/svg/eye.svg',
                          ),
                        ) : null,
                      ),
                      hintStyle: TextStyles.black_16_w400.copyWith(color: ColorStyles.black.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}