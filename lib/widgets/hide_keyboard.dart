import 'package:flutter/material.dart';
import 'package:wallet/utils/ui_utils.dart';

class HelperWidget extends StatefulWidget {
  const HelperWidget({super.key, required this.child});

  final Widget? child;

  @override
  State<HelperWidget> createState() => _HelperWidgetState();
}

class _HelperWidgetState extends State<HelperWidget> {
  @override
  void initState() {
    UIUtils.hideKeyboard(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.child,
    );
  }
}
