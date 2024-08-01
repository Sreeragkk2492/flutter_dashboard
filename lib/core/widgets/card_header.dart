import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';


class CardHeader extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final bool showDivider;
 

   const CardHeader({
    Key? key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
  
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          Visibility(
            visible: showDivider,
            child: const Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  final Widget child;
 
   CardBody({
    Key? key,
    required this.child,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding), 
      child: child,
    );
  }
}
