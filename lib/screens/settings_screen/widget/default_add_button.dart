import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class DefaultAddButton extends StatelessWidget {
  String buttonname;
  Callback onClick;
  DefaultAddButton(
      {super.key, required this.buttonname, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onHover: (value) {},
        style: ElevatedButton.styleFrom(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            // fixedSize: const Size.fromHeight(3),
            padding: EdgeInsets.all(kDefaultPadding),
            backgroundColor: AppColors
                .defaultColor // Change this color to your desired color
            ),
        // child: PopupMenuButton(
        //   onSelected: (value) {
        //     _onMenuItemSelected(value as int);
        //   },
        //   offset: const Offset(0.0, 33),
        //   itemBuilder: (ctx) => [
        //     _buildPopupMenuItem('Inbox', Icons.search,
        //         Options.search.index),
        //     _buildPopupMenuItem('Book', Icons.upload,
        //         Options.upload.index),
        //     _buildPopupMenuItem('Picture', Icons.copy,
        //         Options.copy.index),
        //     _buildPopupMenuItem('File Disabled',
        //         Icons.exit_to_app, Options.exit.index),
        //   ],
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       children: [
        //          Icon(Icons.badge_outlined,
        //             size: kDefaultPadding - 4),
        //         buildSizedboxW(kTextPadding * 2),
        //         const Text(
        //           'Buttons',
        //           style: TextStyle(fontSize: 12),
        //         ),
        //         buildSizedboxW(kTextPadding),
        //          Icon(Icons.arrow_drop_down,
        //             size: kDefaultPadding - 4)
        //       ],
        //     ),
        //   ),
        // ),
        child: Text(
          buttonname,
          style: TextStyle(color: AppColors.whiteColor),
        ),
        onPressed: onClick);
  }
}
