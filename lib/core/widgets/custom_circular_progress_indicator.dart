import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';

class AnimatedCircularProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final Color backgroundColor;
  final Color valueColor;
  final double size;

  const AnimatedCircularProgressIndicator({
    super.key,
    this.strokeWidth = 4.0,
    this.backgroundColor = Colors.grey,
    this.valueColor = AppColors.defaultColor,
    this.size = 50.0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedCircularProgressIndicatorState createState() => 
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState 
    extends State<AnimatedCircularProgressIndicator> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: widget.strokeWidth,
            backgroundColor: widget.backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
          );
        },
      ),
    );
  }
}