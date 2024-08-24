import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class DefaultAddButton extends StatelessWidget {
  final String buttonname;
  final Callback onClick;

  const DefaultAddButton({
    Key? key,
    required this.buttonname,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.defaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding:  EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        elevation: 2,
      ),
     // icon: const Icon(Icons.add, size: 20),
      label: Text(
        buttonname,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, 
        ),
      ),
    );
  }
}