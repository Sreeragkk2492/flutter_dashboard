import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';

class UIComponenetsAppBarNoButton extends StatefulWidget {
  const UIComponenetsAppBarNoButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final Widget icon;

  @override
  State<UIComponenetsAppBarNoButton> createState() => _UIComponenetsAppBarState();
}

class _UIComponenetsAppBarState extends State<UIComponenetsAppBarNoButton> {
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
                        padding: EdgeInsets.all(kDefaultPadding),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}