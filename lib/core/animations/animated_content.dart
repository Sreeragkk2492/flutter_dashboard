import 'package:flutter/material.dart';


///custom animation 
class AnimatedContent extends StatefulWidget {
  final Widget child;
  final bool show;
  final double leftToRight;
  final double topToBottom;
  final int time;

  const AnimatedContent(
      {Key? key,
      required this.child,
      this.show = false,
      required this.leftToRight,
      required this.topToBottom,
      required this.time})
      : super(key: key);

  @override
  AnimatedContentState createState() => AnimatedContentState();
}

class AnimatedContentState extends State<AnimatedContent>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<Offset>? animationSlideUp;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.time));

    animationSlideUp = Tween(
            begin: Offset(widget.leftToRight, widget.topToBottom),
            end: const Offset(0.0, 0.0))
        .animate(
            CurvedAnimation(parent: animationController!, curve: Curves.ease));

    if (widget.show) {
      animationController?.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedContent oldWidget) {
    if (widget != oldWidget) {
      if (widget.show && !oldWidget.show) {
        animationController?.forward(from: 0.0);
      } else if (!widget.show) {
        animationController?.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animationSlideUp!,
      child: FadeTransition(
        opacity: animationController!,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
