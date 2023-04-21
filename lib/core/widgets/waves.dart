import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';

class Waves extends StatelessWidget {
  const Waves({
    required this.path,
    this.color,
    super.key,
  });

  Waves.ascendingRight({this.color, super.key})
      : path = Shapes.waveAscendingRight;

  final Path path;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _WavesPainter(
        path: path,
        color: color ?? Theme.of(context).colorScheme.background,
      ),
    );
  }
}

class _WavesPainter extends CustomPainter {
  const _WavesPainter({
    required this.path,
    required this.color,
  });

  final Path path;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var scaleFactorX = 1.0;
    var scaleFactorY = 1.0;
    final rect = path.getBounds();
    final width = rect.right - rect.left;
    final height = rect.bottom - rect.top;
    path.moveTo(0, 0.1);

    if (size.height > 0) {
      scaleFactorY = size.height / height;
    }
    if (size.width > 0) {
      scaleFactorX = size.width / width;
    }
    // canvas.scale(scaleFactor);
    final transformedPath = path
        .transform(_scale(scaleFactorX, scaleFactorY, rect.topLeft).storage);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    canvas.drawPath(transformedPath, paint);
  }

  Matrix4 _scale(double scaleX, double scaleY, Offset focalPoint) {
    final dx = (1 - scaleX) * focalPoint.dx;
    final dy = (1 - scaleY) * focalPoint.dy;
    return Matrix4(scaleX, 0, 0, 0, 0, scaleY, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
