import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/home_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class BalanceTransactionCard extends StatelessWidget {
  const BalanceTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = context.read();

    return Column(
      children: [
        "Transaction".text(20700, color: MyColor.grey),
        const SizedBox(
          height: 12,
        ),
        StreamBuilder(
            stream: homeBloc.currencyStream,
            builder: (context, asyncSnapshot) {
              final currency = asyncSnapshot.data;
              final curCode = currency?.curCode ?? "USD";
              return Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                elevation: 1,
                child: StreamBuilder(
                    stream: homeBloc.balanceStream,
                    builder: (context, asyncSnapshot) {
                      return Column(
                        children: [
                          ...ListTile.divideTiles(
                              color: MyColor.lightGrey,
                              tiles: [
                                ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor: Color(0xFFeaebff),
                                      child: Icon(
                                        Icons.sell_rounded,
                                        color: Color(0xFF4f65eb),
                                      )),
                                  title: "Spending".txt,
                                  trailing:
                                      "-${(asyncSnapshot.data?.spending ?? 0).format(curCode: curCode)}"
                                          .text(
                                    17500,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor: Color(0xFFe9f5e9),
                                      child: Icon(
                                        Icons.confirmation_num,
                                        color: Color(0xFF45a14a),
                                      )),
                                  title: "Income".txt,
                                  trailing: (asyncSnapshot.data?.income ?? 0)
                                      .format(curCode: curCode)
                                      .text(
                                        17500,
                                        color: const Color(0xFF45a14a),
                                      ),
                                ),
                                ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor: Color(0xFFfff9c5),
                                      child: Icon(
                                        Icons.note,
                                        color: Color(0xFFf57e16),
                                      )),
                                  title: "Bills".txt,
                                  trailing:
                                      "-${(asyncSnapshot.data?.bills ?? 0).format(curCode: curCode)}"
                                          .text(
                                    17500,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor: Color(0xFFfff2df),
                                      child: Icon(
                                        Icons.sell_rounded,
                                        color: Color(0xFFfca438),
                                      )),
                                  title: "Savings".txt,
                                  trailing: (asyncSnapshot.data?.savings ?? 0)
                                      .format(curCode: curCode)
                                      .text(
                                        17500,
                                        color: const Color(0xFFfca438),
                                      ),
                                ),
                              ])
                        ],
                      );
                    }),
              );
            })
      ],
    );
  }
}
