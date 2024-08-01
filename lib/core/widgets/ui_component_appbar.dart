import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
class UIComponenetsAppBar extends StatefulWidget {
  const UIComponenetsAppBar(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon, required this.buttonTitle, required this.onClick});
  final String title;
  final String subtitle;
  final Widget icon;
  final String buttonTitle;
 final Callback onClick;

  @override
  State<UIComponenetsAppBar> createState() => _UIComponenetsAppBarState();
}

class _UIComponenetsAppBarState extends State<UIComponenetsAppBar> {
  String buttonList = 'Inbox';
  var popupMenuItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.bgGreyColor,
            spreadRadius: 5,
            blurRadius: 7, 
          )
        ],
          borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
      padding: EdgeInsets.symmetric(
          horizontal: mediaQueryData.size.width > kScreenWidthSm
              ? kDefaultPadding * 1.5
              : kDefaultPadding,
          vertical: kDefaultPadding * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Visibility(
                  visible: mediaQueryData.size.width >= kScreenWidthLg,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.lightgrayColor,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0),
                        ],
                        color: AppColors.lightBackgroundColor,
                        borderRadius:
                            BorderRadius.circular(kDefaultPadding / 2)),
                    child: Padding(
                        padding:  EdgeInsets.all(kDefaultPadding),
                        child: widget.icon),
                  ),
                ),
                buildSizedboxW(mediaQueryData.size.width < kScreenWidthLg
                    ? 0
                    : kDefaultPadding * 2),
                Flexible(
                  child: Column(
                    crossAxisAlignment:
                        mediaQueryData.size.width >= kScreenWidthLg
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      buildSizedboxW(kTextPadding),
                      Text(
                        widget.subtitle,
                        textAlign: mediaQueryData.size.width >= kScreenWidthLg
                            ? TextAlign.start
                            : TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                      Visibility(
                        visible: mediaQueryData.size.width <= kScreenWidthLg,
                        child: Padding(
                          padding:  EdgeInsets.only(top: kDefaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //       padding:  EdgeInsets.symmetric(
                              //           vertical: kDefaultPadding / 2,
                              //           horizontal: 0),
                              //       backgroundColor: AppColors
                              //           .uiComponentstarbuttonColor // Change this color to your desired color
                              //       ),
                              //   child:  Tooltip(
                              //     decoration: BoxDecoration(
                              //         color: AppColors.blackColor),
                              //     message: 'hello',
                              //     child: Icon(Icons.star,
                              //         size: kDefaultPadding - 2),
                              //   ),
                              //   onPressed: () {},
                              // ),
                              buildSizedboxW(kDefaultPadding),
                              ElevatedButton(
                                onHover: (value) {},
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)), 
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
                                child: Text(widget.buttonTitle ,style: TextStyle(color: AppColors.whiteColor),),
                                onPressed: 
                                 widget.onClick
                                
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: mediaQueryData.size.width >= kScreenWidthLg,
            child: Row(
              children: [
                // Tooltip(
                //   decoration: BoxDecoration(
                //       color: AppColors.blackColor,
                //       borderRadius: BorderRadius.circular(kTextPadding * 2)),
                //   padding:  EdgeInsets.all(kDefaultPadding),
                //   message: 'Show toastify Notification Example!',
                //   child: ElevatedButton(
                //     onHover: (value) {},
                //     style: ElevatedButton.styleFrom(
                //         fixedSize: const Size.fromHeight(33),
                //         padding: EdgeInsets.zero,
                //         backgroundColor: AppColors
                //             .uiComponentstarbuttonColor // Change this color to your desired color
                //         ),
                //     child:  Icon(Icons.star, size: kDefaultPadding - 2),
                //     onPressed: () {},
                //   ),
                // ),
                buildSizedboxW(kDefaultPadding),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)), 
                     // fixedSize: const Size.fromHeight(3),
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors
                          .defaultColor // Change this color to your desired color
                      ),
                  // child: PopupMenuButton(
                  //   onSelected: (value) {
                  //     _onMenuItemSelected(value as int);
                  //   },
                  //   offset: const Offset(0.0, 33),
                  //   itemBuilder: (ctx) => [
                  //     _buildPopupMenuItem(
                  //         'Inbox', Icons.search, Options.search.index),
                  //     _buildPopupMenuItem(
                  //         'Book', Icons.upload, Options.upload.index),
                  //     _buildPopupMenuItem(
                  //         'Picture', Icons.copy, Options.copy.index),
                  //     _buildPopupMenuItem('File Disabled', Icons.exit_to_app,
                  //         Options.exit.index),
                  //   ],
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [
                  //         const Icon(Icons.badge_outlined,
                  //             size: kDefaultPadding - 4),
                  //         buildSizedboxW(kTextPadding * 2),
                  //         const Text(
                  //           'Buttons',
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //         buildSizedboxW(kTextPadding),
                  //         const Icon(Icons.arrow_drop_down,
                  //             size: kDefaultPadding - 4)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.buttonTitle,style: TextStyle(color: AppColors.whiteColor),),
                  ),
                  onPressed: widget.onClick
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PopupMenuItem _buildPopupMenuItem(
  //     String title, IconData iconData, int position) {
  //   return PopupMenuItem(
  //     value: position,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(
  //                 iconData,
  //                 color: Colors.black,
  //               ),
  //               buildSizedboxW(kTextPadding * 2),
  //               Text(title),
  //             ],
  //           ),
  //           Visibility(
  //             visible: title == 'Inbox' || title == 'Book',
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  //               decoration: BoxDecoration(
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 color: title == 'Inbox'
  //                     ? AppColors.lightgrayColor
  //                     : AppColors.errorcolor,
  //               ),
  //               child: Text(
  //                 title == 'Inbox' ? '86' : '5',
  //                 style: const TextStyle(fontSize: 11),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
    });
  }
}

enum Options { search, upload, copy, exit }
