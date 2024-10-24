import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:intl/intl.dart';

Future<String?> pickDate(
  context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime? dateTime = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(DateTime.now().year - 20),
    lastDate: lastDate ?? DateTime(DateTime.now().year + 2),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.defaultColor,
          colorScheme: const ColorScheme.light(
            primary: AppColors.defaultColor,
            onPrimary: Colors.white,
          ), 
        ),
        child: child ?? Container(),
      );
    },
  );

  if (dateTime != null) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  return null;
}
