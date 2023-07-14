import 'dart:math';

import 'package:flutter/material.dart';

class GradientProgressIndicator extends StatefulWidget {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;
  final Color backgroundColor;

  GradientProgressIndicator({
    required this.progress,
    required this.gradient,
    required this.backgroundColor,
    this.strokeWidth = 4.0,
  });

  @override
  _GradientProgressIndicatorState createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator> {
  double turns = 0;
  @override
  void initState() {
    super.initState();
    _makeTurns();
  }

  void _makeTurns() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        turns++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.strokeWidth * 5),
            border: Border.all(
              color: widget.backgroundColor,
              width: widget.strokeWidth,
            ),
          ),
        ),
        Positioned.fill(
          child: AnimatedRotation(
            turns: turns,
            duration: Duration(seconds: 1),
            child: CustomPaint(
              painter: _GradientProgressPainter(
                progress: widget.progress,
                strokeWidth: widget.strokeWidth,
                gradient: widget.gradient,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.strokeWidth * 5),
//             border: Border.all(
//               color: widget.backgroundColor,
//               width: widget.strokeWidth,
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               final rotation = _animationController.value * 2.0 * pi;
//               return Transform.rotate(
//                 angle: rotation,
//                 child: CustomPaint(
//                   painter: _GradientProgressPainter(
//                     progress: widget.progress,
//                     strokeWidth: widget.strokeWidth,
//                     gradient: widget.gradient,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class _GradientProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;

  _GradientProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    final startAngle = pi * 0.17;
    final sweepAngle = pi * 1.6;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_GradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.gradient != gradient;
  }
}
