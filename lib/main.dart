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
      home: const EmojiDrawingBoard(),
    );
  }
}

class EmojiDrawingBoard extends StatefulWidget {
  const EmojiDrawingBoard({super.key});

  @override
  State<EmojiDrawingBoard> createState() => _EmojiDrawingBoardState();
}

class DrawnEmoji {
  final String type;
  final Offset position;

  DrawnEmoji({required this.type, required this.position});
}

class _EmojiDrawingBoardState extends State<EmojiDrawingBoard> {
  String selectedEmoji = 'Smiley Face';
  List<DrawnEmoji> drawnEmojis = [];

  final List<String> emojiOptions = [
    'Smiley Face',
    'Heart',
    'Party Face',
    'Eye',
  ];

  void _onCanvasTap(TapUpDetails details) {
    setState(() {
      drawnEmojis.add(DrawnEmoji(
        type: selectedEmoji,
        position: details.localPosition,
      ));
    });
  }

  void _clearCanvas() {
    setState(() {
      drawnEmojis.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearCanvas,
            tooltip: 'Clear Canvas',
          ),
        ],
      ),
      body: Column(
        children: [
          // control panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Select Emoji: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedEmoji,
                      isExpanded: true,
                      underline: Container(),
                      items: emojiOptions.map((String emoji) {
                        return DropdownMenuItem<String>(
                          value: emoji,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(emoji),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEmoji = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // instructions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue.shade50,
            child: Text(
              'Tap anywhere on the canvas below to draw a $selectedEmoji!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          // drawing canvas
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: GestureDetector(
                onTapUp: _onCanvasTap,
                child: CustomPaint(
                  painter: EmojiCanvasPainter(drawnEmojis: drawnEmojis),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          
          // bottom info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey.shade100,
            child: Text(
              'Emojis drawn: ${drawnEmojis.length} | Tap the clear button to reset',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmojiCanvasPainter extends CustomPainter {
  final List<DrawnEmoji> drawnEmojis;

  EmojiCanvasPainter({required this.drawnEmojis});

  @override
  void paint(Canvas canvas, Size size) {
    for (DrawnEmoji emoji in drawnEmojis) {
      switch (emoji.type) {
        case 'Smiley Face':
          _drawSmileyFace(canvas, emoji.position);
          break;
        case 'Heart':
          _drawHeart(canvas, emoji.position);
          break;
        case 'Party Face':
          _drawPartyFace(canvas, emoji.position);
          break;
        case 'Eye':
          _drawEye(canvas, emoji.position);
          break;
      }
    }
  }

  void _drawSmileyFace(Canvas canvas, Offset center) {

    final centerX = center.dx;
    final centerY = center.dy;
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 0, centerY);

    // smiley face, circle
    final circleRect = Rect.fromCircle(center: circleOffset, radius: 80); 
    final circlePaint = Paint()
      ..shader = RadialGradient(
      colors: [Colors.yellow, Colors.orange],
      center: Alignment.center,
      radius: 0.8,
    ).createShader(circleRect);
    canvas.drawCircle(circleOffset, 40, circlePaint);

    // smile
    final arcPaint = Paint()
      ..color = Colors.brown.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 50, height: 50),
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
      Rect.fromCenter(center: Offset(centerX - 15, centerY - 10), width: 10, height: 15),
      ovalPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX + 15, centerY - 10), width: 10, height: 15),
      ovalPaint,
    );
  }

  void _drawHeart(Canvas canvas, Offset center) {
    final centerX = center.dx;
    final centerY = center.dy;
    // heart
    final gradient = RadialGradient(
      colors: [Colors.pink.shade200, Colors.red],
      center: Alignment.center,
      radius: 0.8 
    );
    final shader = gradient.createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: 60));
    final roofPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;
    final roofPath = Path()
      ..moveTo(centerX - 25, centerY)
      ..lineTo(centerX + 25, centerY)
      ..lineTo(centerX, centerY + 30)
      ..close();
    canvas.drawPath(roofPath, roofPaint);
    final heartPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX + 12.5, centerY - 10), 16, heartPaint);
    canvas.drawCircle(Offset(centerX - 12.5, centerY - 10), 16, heartPaint);
  }
   //placeholder for party face
  void _drawPartyFace(Canvas canvas, Offset center) {

    final placeholderPaint = Paint()
      ..color = Colors.purple.shade200
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 30, placeholderPaint);
    

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '🎉',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }
   
   //placeholder for eyes
  void _drawEye(Canvas canvas, Offset center) {
    

    final placeholderPaint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: 50, height: 30),
      placeholderPaint,
    );
    

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '👁',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }
// placeholder done

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; 
  }
}