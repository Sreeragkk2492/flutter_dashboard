import 'package:flutter/material.dart';

class A4PayslipSheet extends StatelessWidget {
  final Widget content;

  const A4PayslipSheet({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A4 size in pixels at 96 DPI
    final double a4Width = 795.28;
    final double a4Height = 1122.52;

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = a4Width;
        double height = a4Height;

        // If the available width is less than the A4 width, scale down proportionally
        if (constraints.maxWidth < a4Width) {
          width = constraints.maxWidth;
          height = width * (a4Height / a4Width);
        }

        // If the height exceeds the constraint, scale it down
        if (height > constraints.maxHeight) {
          height = constraints.maxHeight;
          width = height * (a4Width / a4Height);
        }

        return Center(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(width * 0.05), // 5% padding
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}
