import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatelessWidget {
  const ShapesDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Smiley Face Emoji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: BasicShapesPainter(),
                size: const Size(double.infinity, 200),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Heart Emoji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: CombinedShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Party Face Emoji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: StyledShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Eye Emoji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: StyledShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Determine the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 0, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX, centerY);



    // smiley face, circle
    final circleRect = Rect.fromCircle(center: circleOffset, radius: 80);
    final circlePaint = Paint()
      ..shader = RadialGradient(
      colors: [Colors.yellow, Colors.orange],
      center: Alignment.center,
      radius: 0.8,
    ).createShader(circleRect);
  canvas.drawCircle(circleOffset, 80, circlePaint);

    // smile
    final arcPaint = Paint()
      ..color = Colors.brown.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 100, height: 100),
      .35, // start angle in radians
      2.5, // sweep angle in radians (about 120 degrees)
      false, // whether to use center
      arcPaint,
    );
    
      // eyes
     final ovalPaint = Paint()
      ..color = Colors.brown.shade800
      ..style = PaintingStyle.fill;
    canvas.drawOval(
  Rect.fromCenter(center: Offset(centerX - 30, centerY - 20), width: 20, height: 30),
  ovalPaint,
);
canvas.drawOval(
  Rect.fromCenter(center: Offset(centerX + 30, centerY - 20), width: 20, height: 30),
  ovalPaint,
);



    
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Background gradient
    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.red.shade100, Colors.white],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = backgroundGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );


  // heart
  // Gradient
final gradient = RadialGradient(
  colors: [Colors.pink.shade200, Colors.red],
  center: Alignment.center,
  radius: 0.8 
);
final shader = gradient.createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: 120));

final roofPaint = Paint()
  ..shader = shader
  ..style = PaintingStyle.fill;
final roofPath = Path()
  ..moveTo(centerX - 100.4, centerY)
  ..lineTo(centerX + 100.4, centerY)
  ..lineTo(centerX, centerY + 110)
  ..close();
canvas.drawPath(roofPath, roofPaint);
final heartPaint = Paint()
  ..shader = shader
  ..style = PaintingStyle.fill;
canvas.drawCircle(Offset(centerX + 50, centerY - 39.8), 64.2, heartPaint);
canvas.drawCircle(Offset(centerX - 50, centerY - 39.8), 64.2, heartPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
  
   
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
