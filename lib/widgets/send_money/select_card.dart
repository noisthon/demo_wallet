import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/models/currency.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/send_money/choose_recipient.dart';

class SelectCard extends StatefulWidget {
  const SelectCard({super.key});

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SendMoneyBloc>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
                    CircleAvatar(radius: 40),
                    mehadi.name.text(17500),
                    mehadi.email.text(14400),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          "Choose Account".label,
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  leading: Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColor.lightGrey,
                        ),
                        borderRadius: BorderRadius.circular(6)),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 1.5,
                          left: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                                color: Colors.amber, shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                          top: 1.5,
                          right: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: "Account *****************3994".txt,
                  trailing: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              isSelected ? MyColor.primary : MyColor.lightGrey,
                          width: 2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: isSelected
                        ? Container(
                            decoration: const BoxDecoration(
                              color: MyColor.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                )),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: double.infinity,
            child: StreamBuilder(
              stream: bloc.amtStream,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: isSelected ? () => bloc.onPay(context) : null,
                  child: "Pay \$${snapshot.data}".txt,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
