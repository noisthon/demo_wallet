import 'dart:async';

import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/models/recipient.dart';
import 'package:wallet/screens/qr_reader.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/ui_utils.dart';
import 'package:wallet/widgets/send_money/choose_recipient.dart';
import 'package:wallet/widgets/send_money/input_value.dart';
import 'package:wallet/widgets/send_money/select_card.dart';
import 'package:wallet/widgets/send_money/select_purpose.dart';

class SendModeyScreen extends StatefulWidget {
  static const routeName = "SendModey";

  const SendModeyScreen({super.key});

  @override
  State<SendModeyScreen> createState() => _SendModeyScreenState();
}

class _SendModeyScreenState extends State<SendModeyScreen> {
  late final PageController pageController;
  late final SendMoneyBloc bloc;

  StreamSubscription? _stepChangeListener;

  @override
  void initState() {
    bloc = context.read();
    pageController = PageController();
    _stepChangeListener = bloc.stepStream.listen(onStepChanged);
    super.initState();
  }

  @override
  void dispose() {
    _stepChangeListener?.cancel();
    super.dispose();
  }

  void onStepChanged(int page) {
    UIUtils.hideKeyboard(context);

    if (pageController.page?.round() != page) {
      pageController.animateToPage(
        page,
        duration: Durations.medium2,
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stepStream,
        builder: (context, asyncSnapshot) {
          return PopScope(
            canPop: asyncSnapshot.data == 0,
            onPopInvokedWithResult: (didPop, result) {
              if (asyncSnapshot.data != 0) {
                bloc.navToPrevStep();
              }
            },
            child: Scaffold(
                appBar: AppBar(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: asyncSnapshot.data == 0
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            shape: CircleBorder(),
                            elevation: 0,
                            backgroundColor: MyColor.primary,
                            child: const Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, QrReaderScreen.routeName);
                            },
                          ),
                          const SizedBox(height: 4),
                          "Scan to Pay".txt,
                        ],
                      )
                    : null,
                body: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ChooseRecipient(),
                    SelectPurpose(),
                    InputValue(),
                    SelectCard(),
                  ],
                )),
          );
        });
  }
}
