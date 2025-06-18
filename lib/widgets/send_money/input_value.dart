import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/models/currency.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/send_money/choose_recipient.dart';

const dict = [
  Currency(
    curCode: "USD",
    title: "US Dollar",
    flagPath: 'packages/country_code_picker/flags/us.png',
  ),
  Currency(
    curCode: "MNT",
    title: "MN Tugrik",
    flagPath: 'packages/country_code_picker/flags/mn.png',
  ),
];

class InputValue extends StatefulWidget {
  const InputValue({super.key});

  @override
  State<InputValue> createState() => _InputValueState();
}

class _InputValueState extends State<InputValue> {
  Currency selectedCurrency = dict[0];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SendMoneyBloc>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Select a Purpose".text(30700, color: Colors.black),
            "Select a method for Sending Money".txt,
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(radius: 40),
                      mehadi.name.text(17500),
                      mehadi.email.text(14400),
                      const SizedBox(
                        height: 12,
                      ),
                      PopupMenuButton(
                        position: PopupMenuPosition.under,
                        itemBuilder: (_) => dict
                            .map((c) => PopupMenuItem(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        minRadius: 5,
                                        backgroundImage: AssetImage(c.flagPath),
                                        maxRadius: 10,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedCurrency = c;
                                    });
                                  },
                                ))
                            .toList(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              minRadius: 5,
                              backgroundImage:
                                  AssetImage(selectedCurrency.flagPath),
                              maxRadius: 10,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: StreamBuilder(
                            stream: bloc.amtErrorStream,
                            builder: (context, asyncSnapshot) {
                              return TextField(
                                style: 24500.style(),
                                decoration: InputDecoration(
                                  errorText: asyncSnapshot.data,
                                  hintText: "0.00",
                                  hintStyle:
                                      24500.style(color: MyColor.lightGrey),
                                  enabledBorder: const UnderlineInputBorder(),
                                  focusedBorder: const UnderlineInputBorder(),
                                ),
                                onChanged: bloc.changeAmt,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                              );
                            }),
                      ),
                      const SizedBox(height: 24),
                      StreamBuilder(
                        stream: bloc.isAmtValid,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.data ?? false
                                ? () => bloc.navToNextStep()
                                : null,
                            child: "Sign up".txt,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
