import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/main.dart';

class QrReaderScreen extends StatefulWidget {
  static const routeName = "QrReaderScreen";
  const QrReaderScreen({super.key});

  @override
  State<QrReaderScreen> createState() => _QrReaderScreenState();
}

class _QrReaderScreenState extends State<QrReaderScreen>
    with WidgetsBindingObserver {
  late CameraController controller;
  @override
  void initState() {
    _initializeCameraController(cameras[0]);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  void _initializeCameraController(CameraDescription description) {
    controller = CameraController(description, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: CameraPreview(controller),
    );
  }
}

class QRBorder extends CustomPainter {
  static const length = 8.0;
  static const width = 4.0;
  static const r = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final path = Path();

    double w = 0;
    double h = 0;
    double fl = length + r;

    path.moveTo(w, fl);
    path.lineTo(w, r);
    path.cubicTo(w, r, w, h, r, h);
    path.lineTo(fl, h);

    w = size.width;

    path.moveTo(w - fl, h);
    path.lineTo(w - r, h);
    path.cubicTo(w - r, h, w, h, w, h + r);
    path.lineTo(w, fl);

    h = size.height;

    path.moveTo(w, h - fl);
    path.lineTo(w, h - r);
    path.cubicTo(w, h - r, w, h, w - r, h);
    path.lineTo(w - fl, h);

    w = 0;

    path.moveTo(w + fl, h);
    path.lineTo(w + r, h);
    path.cubicTo(w + r, h, w, h, w, h - r);
    path.lineTo(w, h - fl);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
