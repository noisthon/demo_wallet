import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/main.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class QrReaderScreen extends StatefulWidget {
  static const routeName = "QrReaderScreen";
  const QrReaderScreen({super.key});

  @override
  State<QrReaderScreen> createState() => _QrReaderScreenState();
}

class _QrReaderScreenState extends State<QrReaderScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool flash = false;
  @override
  void initState() {
    super.initState();
    if (cameras.isEmpty) {
      print('No cameras found.');
      return;
    }

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.previewSize!.height,
                      height: _controller.value.previewSize!.width,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: CustomPaint(
                    painter: QRBorder(),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.8),
                          BlendMode.srcOut), // This one will create the magic
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                backgroundBlendMode: BlendMode
                                    .dstOut), // This one will handle background + difference out
                          ),
                          Positioned(
                            top: MediaQuery.sizeOf(context).height * 0.3,
                            left: MediaQuery.sizeOf(context).width * 0.2,
                            right: MediaQuery.sizeOf(context).width * 0.2,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.3 - 10,
                  left: MediaQuery.sizeOf(context).width * 0.2 - 10,
                  right: MediaQuery.sizeOf(context).width * 0.2 - 10,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: QRBorder(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 200.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        "Scan a QR to Pay".text(28600, color: Colors.white),
                        "Hold the code inside the frame, it will be scanned automatically"
                            .text(14400,
                                color: Colors.white,
                                textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (flash) {
                            _controller.setFlashMode(FlashMode.off);
                          } else {
                            _controller.setFlashMode(FlashMode.torch);
                          }
                          setState(() {
                            flash = !flash;
                          });
                        },
                        icon: const Icon(
                          Icons.flash_on_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (cameras.length > 1) {
                            final newCamera =
                                (_controller.description == cameras[0])
                                    ? cameras[1]
                                    : cameras[0];
                            _controller = CameraController(
                              newCamera,
                              ResolutionPreset.high,
                              enableAudio: true,
                            );
                            setState(() {
                              _initializeControllerFuture =
                                  _controller.initialize();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Only one camera available')),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class RectangleClipper extends CustomClipper<RRect> {
  final double widthRatio;
  final double heightRatio;
  final double borderRadius;

  RectangleClipper({
    this.widthRatio = 0.8, // Clip to 80% of the container's width
    this.heightRatio = 0.8, // Clip to 80% of the container's height
    this.borderRadius = 0.0, // No rounding by default
  });

  @override
  RRect getClip(Size size) {
    final double clipWidth = size.width * widthRatio;
    final double clipHeight = size.height * heightRatio;

    final double offsetX = (size.width - clipWidth) / 2;
    final double offsetY = (size.height - clipHeight) / 2;

    return RRect.fromLTRBR(
      offsetX,
      offsetY,
      offsetX + clipWidth,
      offsetY + clipHeight,
      Radius.circular(borderRadius),
    );
  }

  @override
  bool shouldReclip(covariant RectangleClipper oldClipper) {
    return oldClipper.widthRatio != widthRatio ||
        oldClipper.heightRatio != heightRatio ||
        oldClipper.borderRadius != borderRadius;
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
