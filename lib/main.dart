import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Morning Scene')),
        body: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: MorningScenePainter(),
        ),
      ),
    );
  }
}

class MorningScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw sky with a gradient
    Rect skyRect = Rect.fromLTRB(0, 0, size.width, size.height);
    Gradient skyGradient = LinearGradient(
      colors: [Colors.lightBlue[300]!, Colors.lightBlue[100]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    paint.shader = skyGradient.createShader(skyRect);
    canvas.drawRect(skyRect, paint);

    // Draw the sun with a glow
    paint.shader = null;
    paint.color = Colors.orangeAccent;
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 50, paint);
    paint.color = Colors.orangeAccent.withOpacity(0.5);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 70, paint);

    // Draw clouds
    Paint cloudPaint = Paint()..color = Colors.white.withOpacity(0.8);
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.1, 150, 50),
      cloudPaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.15, 120, 40),
      cloudPaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.4, size.height * 0.05, 180, 60),
      cloudPaint,
    );

    // Draw buildings with varying heights and shadows
    double buildingWidth = size.width * 0.15;
    List<double> buildingHeights = [
      size.height * 0.4,
      size.height * 0.5,
      size.height * 0.45,
      size.height * 0.35
    ];

    for (int i = 0; i < buildingHeights.length; i++) {
      double xOffset = i * (buildingWidth + 20);
      double buildingHeight = buildingHeights[i];
      Rect buildingRect = Rect.fromLTWH(
          xOffset, size.height - buildingHeight - 100, buildingWidth, buildingHeight);
      paint.color = Colors.grey[800]!;
      canvas.drawRect(buildingRect, paint);

      // Draw windows
      paint.color = Colors.yellow[100]!;
      for (int j = 0; j < 4; j++) {
        for (int k = 0; k < 3; k++) {
          double windowWidth = buildingWidth * 0.2;
          double windowHeight = buildingHeight * 0.15;
          double windowX = xOffset + 10 + j * (windowWidth + 10);
          double windowY = size.height - buildingHeight - 90 + k * (windowHeight + 10);

          canvas.drawRect(
              Rect.fromLTWH(windowX, windowY, windowWidth, windowHeight), paint);
        }
      }

      // Draw building shadows
      paint.color = Colors.black.withOpacity(0.2);
      canvas.drawRect(
          Rect.fromLTWH(xOffset + buildingWidth, size.height - buildingHeight - 80,
              buildingWidth * 0.4, buildingHeight + 80),
          paint);
    }

    // Draw trees with more detail
    Paint trunkPaint = Paint()..color = Colors.brown[800]!;
    Paint leavesPaint = Paint()..color = Colors.green[700]!;
    for (int i = 0; i < 5; i++) {
      double treeX = size.width * 0.1 + i * size.width * 0.2;
      double treeY = size.height - 100;

      // Draw trunk
      canvas.drawRect(
          Rect.fromLTWH(treeX - 10, treeY - 60, 20, 60), trunkPaint);

      // Draw leaves
      canvas.drawCircle(Offset(treeX, treeY - 80), 40, leavesPaint);
      canvas.drawCircle(Offset(treeX - 30, treeY - 60), 30, leavesPaint);
      canvas.drawCircle(Offset(treeX + 30, treeY - 60), 30, leavesPaint);
      canvas.drawCircle(Offset(treeX - 20, treeY - 40), 25, leavesPaint);
      canvas.drawCircle(Offset(treeX + 20, treeY - 40), 25, leavesPaint);
    }

    // Draw grass
    paint.color = Colors.green[400]!;
    Rect grassRect = Rect.fromLTRB(0, size.height - 100, size.width, size.height);
    canvas.drawRect(grassRect, paint);

    // Draw a pathway through the grass
    Path path = Path();
    path.moveTo(size.width * 0.4, size.height);
    path.quadraticBezierTo(size.width * 0.5, size.height - 50, size.width * 0.6, size.height);
    paint.color = Colors.brown[400]!;
    canvas.drawPath(path, paint);

    // Add birds to the sky
    Paint birdPaint = Paint()..color = Colors.black;
    drawBird(canvas, size.width * 0.2, size.height * 0.2, birdPaint);
    drawBird(canvas, size.width * 0.3, size.height * 0.25, birdPaint);
    drawBird(canvas, size.width * 0.7, size.height * 0.1, birdPaint);
  }

  void drawBird(Canvas canvas, double x, double y, Paint paint) {
    Path birdPath = Path();
    birdPath.moveTo(x, y);
    birdPath.relativeQuadraticBezierTo(10, -10, 20, 0);
    birdPath.relativeQuadraticBezierTo(10, 10, 20, 0);
    canvas.drawPath(birdPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
