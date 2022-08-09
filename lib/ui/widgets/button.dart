import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siignores/core/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final RoundedLoadingButtonController controller;
  const CustomButton({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: RoundedLoadingButton(
        width: MediaQuery.of(context).size.width - 64,
        controller: controller,
        valueColor: Colors.black,
        onPressed: () {},
        color: accentColor,
        elevation: 0,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Formular',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
