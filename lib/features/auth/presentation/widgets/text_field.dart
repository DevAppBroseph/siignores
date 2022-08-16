import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/colors/color_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType? textInputType;
  final String? title;
  final TextEditingController controller;
  CustomTextField({
    Key? key,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.title,
    required this.controller,
  }) : super(key: key);

  bool visibility = false;
  final _streamController = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _streamController.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Formular',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              if (title != null) const SizedBox(height: 8),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 32, right: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: TextField(
                        controller: controller,
                        cursorColor: ColorStyles.accentColor,
                        obscureText: textInputType == TextInputType.visiblePassword &&
                                !snapshot.data!
                            ? true
                            : false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 16),
                          hintText: hint,
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                            fontFamily: 'Formular',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    if (textInputType == TextInputType.visiblePassword)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: InkWell(
                            onTap: () {
                              _streamController.add(!snapshot.data!);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.white,
                              child: SvgPicture.asset(
                                'assets/svg/eye.svg',
                                width: 17,
                                height: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
