import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/blocs/home_bloc.dart';
import 'package:wallet/screens/additional_info.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/ui_utils.dart';
import 'package:wallet/widgets/balance/balance_action_tile.dart';
import 'package:wallet/widgets/balance/balance_main_card.dart';
import 'package:wallet/widgets/balance/balance_transaction_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AppBloc appBloc;
  int selectedTab = 0;

  final menuList = [
    [Icons.home, Icons.home_outlined],
    [Icons.pie_chart, Icons.pie_chart_outline],
    [Icons.chat, Icons.chat_outlined],
    [Icons.person, Icons.person_outline],
  ];

  @override
  void initState() {
    appBloc = context.read();
    if (!appBloc.authUser.hasAddition) {
      UIUtils.callback((_) {
        Navigator.of(context).pushNamed(AdditionalInfoScreen.routeName);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UIUtils.callback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: SizedBox(
            height: 60,
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              elevation: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < menuList.length; i++) ...[
                    if (i == 2)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: MyColor.primary,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            selectedTab = i;
                          });
                        },
                        child: Stack(
                          children: [
                            Center(
                                child: Icon(
                              selectedTab == i
                                  ? menuList[i][0]
                                  : menuList[i][1],
                              size: selectedTab == i ? 24 : 24,
                              color: selectedTab == i
                                  ? MyColor.primary
                                  : MyColor.grey,
                            )),
                            if (i == selectedTab)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColor.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverStack(
              children: [
                SliverPositioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      MyColor.primary.withAlpha(175),
                      BlendMode.srcATop,
                    ),
                    child: SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/cover.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverSafeArea(
                  sliver: SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 4),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                            height: 350 - MediaQuery.of(context).padding.top,
                            child: const BalanceMainCard(),
                          ),
                          const BalanceActionTile(),
                          const SizedBox(
                            height: 24,
                          ),
                          const BalanceTransactionCard()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
