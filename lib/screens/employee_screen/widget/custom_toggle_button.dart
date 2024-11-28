import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const CustomToggleButton({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(
        //   'User Status: ',
        //   style: TextStyle(
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black87,
        //   ),
        // ),
        Switch(
          value: value,
          activeColor: activeColor,
          activeTrackColor: activeColor.withOpacity(0.5),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
          onChanged: onChanged,
        ),
        Text(
          value ? 'Active' : 'Inactive',
          style: TextStyle(
            color: value ? activeColor : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
} 