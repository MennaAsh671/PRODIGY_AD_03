import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final double percent;
  final double radius;
  final double fontSize;
  final double lineWidth;
  final bool reverse;
  final double startAngle;
  final Color progressColor;

  const MyCircularProgressIndicator({
    super.key,
    required this.percent,
    this.radius = 40,
    this.fontSize = 0,
    this.lineWidth = 12,
    this.reverse = false,
    this.startAngle = 0.0,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      startAngle: startAngle,
      reverse: reverse,
      circularStrokeCap: CircularStrokeCap.round,
      radius: radius,
      lineWidth: lineWidth,
      percent: percent,
      backgroundColor: Colors.grey,
      progressColor: progressColor,
    );
  }
}
