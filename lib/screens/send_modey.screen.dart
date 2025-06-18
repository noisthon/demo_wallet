import 'package:flutter/material.dart';
import 'package:wallet/style/theme.dart';

class SendModeyScreen extends StatelessWidget {
  static const routeName = "SendModey";

  const SendModeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColor.primary,
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}
