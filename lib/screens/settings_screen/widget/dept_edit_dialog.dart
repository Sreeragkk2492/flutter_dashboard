  import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:google_fonts/google_fonts.dart';

void showEditDialog(BuildContext context, DialogType dialogType, 
      int index) {
  
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Company Info',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             
              buildSizedBoxH(kDefaultPadding),
             
            ]),
          ),
        ),
      //  width: dialogWidth,
        btnOkOnPress: () {},
        btnOk: Container(
          alignment: Alignment.bottomRight,
          width: 150,
          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // fixedSize: const Size.fromHeight(3),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors
                    .defaultColor // Change this color to your desired color
                ),

            onPressed: () {
             // showDialog(context, DialogType.success, );
              // Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Update',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            // onPressed: widget.onClick
          ),
        ));

    dialog.show();
  }