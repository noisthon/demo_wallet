import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/ui_utils.dart';
import 'package:wallet/widgets/additional_info/additional_info_add_email.dart';
import 'package:wallet/widgets/additional_info/additional_info_country_of_residence.dart';
import 'package:wallet/widgets/additional_info/additional_info_home_address.dart';
import 'package:wallet/widgets/additional_info/additional_info_personal_info.dart';
import 'package:wallet/widgets/app_bar.dart';

class AdditionalInfoScreen extends StatefulWidget {
  static const routeName = "AdditionalInfo";
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  late final PageController pageController;
  late final AdditionalInfoBloc bloc;
  late final StreamSubscription _stepChangeListener;

  @override
  void initState() {
    bloc = context.read();
    pageController = PageController();
    _stepChangeListener = bloc.stepStream.listen(onStepChanged);
    super.initState();
  }

  @override
  void dispose() {
    _stepChangeListener.cancel();
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
              if ((asyncSnapshot.data ?? 0) > 0) {
                bloc.navToPrevStep();
              }
            },
            child: Scaffold(
              appBar: const MyAppBar(),
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AdditionalInfoAddEmail(),
                  AdditionalInfoHomeAddress(),
                  AdditionalInfoPersonalInfo(),
                  AdditionalInfoCountryOfResidence(),
                ],
              ),
            ),
          );
        });
  }
}
