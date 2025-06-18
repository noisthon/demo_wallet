import 'package:flutter/material.dart';
import 'package:wallet/screens/send_modey.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class BalanceActionTile extends StatelessWidget {
  const BalanceActionTile({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "iconData": Icons.monetization_on,
        "color": MyColor.primary,
        "title": "Send",
        "onPressed": () {
          Navigator.pushNamed(context, SendModeyScreen.routeName);
        },
      },
      {
        "iconData": Icons.attach_money_rounded,
        "color": MyColor.orange,
        "title": "Request",
      },
      {
        "iconData": Icons.account_balance_rounded,
        "color": MyColor.orange,
        "title": "Bank",
      },
    ];
    return SizedBox(
      height: 100,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < actions.length; i++) ...[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: actions[i]["onPressed"] as VoidCallback?,
                  child: Column(
                    children: [
                      Icon(
                        actions[i]["iconData"] as IconData,
                        size: 34,
                        color: actions[i]["color"] as Color,
                      ),
                      const SizedBox(height: 4),
                      (actions[i]["title"] as String).text(13400),
                    ],
                  ),
                ),
                if (i != actions.length - 1)
                  Container(
                    width: 1,
                    height: 20,
                    color: MyColor.lightGrey.withAlpha(100),
                  ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
