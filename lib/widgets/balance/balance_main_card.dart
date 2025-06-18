import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/blocs/home_bloc.dart';
import 'package:wallet/models/balance.dart';
import 'package:wallet/models/currency.dart';
import 'package:wallet/screens/additional_info.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/ui_utils.dart';
import 'package:wallet/widgets/app_bar.dart';

class BalanceMainCard extends StatelessWidget {
  const BalanceMainCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final bloc = context.read<HomeBloc>();
    return StreamBuilder(
        stream: bloc.currencyStream,
        builder: (context, asyncSnapshot) {
          final curCode = asyncSnapshot.data ?? "USD";
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () => appBloc.signOut(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: MyColor.purple,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: 'Search "Payments"',
                                hintStyle: 15400.style(color: Colors.white),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("object");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 32,
                width: 100,
                child: StreamBuilder(
                    stream: bloc.currencyDictStream,
                    builder: (context, asyncSnapshot) {
                      return DropdownButton(
                        value: curCode,
                        iconEnabledColor: Colors.white,
                        underline: const SizedBox.shrink(),
                        isExpanded: true,
                        padding: EdgeInsets.zero,
                        dropdownColor: MyColor.primary,
                        items: (asyncSnapshot.data ?? [])
                            .map((c) => DropdownMenuItem(
                                  value: c.curCode,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        minRadius: 5,
                                        backgroundImage: AssetImage(c.flagPath),
                                        maxRadius: 10,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                          child: c.title.text(11400,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          bloc.changeCurrency(
                            value ?? curCode,
                          );
                        },
                      );
                    }),
              ),
              StreamBuilder(
                stream: bloc.balanceStream,
                builder: (context, snapshot) => (snapshot.data?.balance ?? 0.0)
                    .format(curCode: curCode)
                    .text(37700, color: Colors.white),
              ),
              "Available balance".text(
                14400,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(4)),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wallet),
                    const SizedBox(width: 4),
                    "Add Money".txt,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
