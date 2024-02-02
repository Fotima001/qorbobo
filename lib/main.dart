import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Tween<double> animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this, duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        animationController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animation = Tween<double>(
      begin: 0.8, end: 0,
    );
    animationController.forward();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: AnimatedBuilder(
            builder: (context, child) => CustomPaint(
              painter: PackManPainter(
                mouthExtend: animationController.value,
              ),
            ),
            animation: animation.animate(animationController),
          ),
        )
    );
  }
}
class PackManPainter extends CustomPainter {
  final double mouthExtend;
  const PackManPainter({
    super.repaint,
    required this.mouthExtend,
  });
  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint();
    paint.color = Colors.blue;

    canvas.drawCircle(Offset(-10, -50), 30, Paint()..color = Colors.blue,);
    canvas.drawCircle(Offset(-20, -50), 4, Paint()..color = Colors.black,);
    canvas.drawCircle(Offset(-0, -50), 4, Paint()..color = Colors.black,);
    canvas.drawCircle(Offset(-10, 20), 40, Paint()..color = Colors.blue,);
    canvas.drawCircle(Offset(-10, 20), 6, Paint()..color = Colors.black,);
    canvas.drawCircle(Offset(-10, 120), 60, Paint()..color = Colors.blue,);
    canvas.drawCircle(Offset(-10, 90), 6, Paint()..color = Colors.black,);
    canvas.drawCircle(Offset(-10, 120), 6, Paint()..color = Colors.black,);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}