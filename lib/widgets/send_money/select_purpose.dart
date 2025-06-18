import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class SelectPurpose extends StatefulWidget {
  const SelectPurpose({super.key});

  @override
  State<SelectPurpose> createState() => _SelectPurposeState();
}

class _SelectPurposeState extends State<SelectPurpose> {
  int selectedPurpose = 0;
  void selectPurpose(int index) {
    setState(() {
      selectedPurpose = index;
    });
  }

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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedPurpose == 0
                    ? const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: MyColor.primary,
                        )
                      ]
                    : [],
                color: Colors.white),
            child: ListTile(
              onTap: () => selectPurpose(0),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFeaebff),
                child: Icon(
                  Icons.sell_rounded,
                  color: Color(0xFF4f65eb),
                ),
              ),
              title: "Personal".txt,
              subtitle: "Pay your friends and family".txt,
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedPurpose == 0
                          ? MyColor.primary
                          : MyColor.lightGrey,
                      width: 2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(3),
                child: selectedPurpose == 0
                    ? Container(
                        decoration: const BoxDecoration(
                          color: MyColor.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedPurpose == 1
                    ? const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: MyColor.primary,
                        )
                      ]
                    : [],
                color: Colors.white),
            child: ListTile(
              onTap: () => selectPurpose(1),
              leading: const CircleAvatar(
                  backgroundColor: Color(0xFFfff2df),
                  child: Icon(
                    Icons.sell_rounded,
                    color: Color(0xFFfca438),
                  )),
              title: "Business".txt,
              subtitle: "Pay your employee".txt,
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedPurpose == 1
                          ? MyColor.primary
                          : MyColor.lightGrey,
                      width: 2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(3),
                child: selectedPurpose == 1
                    ? Container(
                        decoration: const BoxDecoration(
                          color: MyColor.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedPurpose == 2
                    ? const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: MyColor.primary,
                        )
                      ]
                    : [],
                color: Colors.white),
            child: ListTile(
              onTap: () => selectPurpose(2),
              leading: const CircleAvatar(
                  backgroundColor: Color(0xFFfff9c5),
                  child: Icon(
                    Icons.note,
                    color: Color(0xFFf57e16),
                  )),
              title: "Payment".txt,
              subtitle: "For payment utility bills".txt,
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedPurpose == 2
                          ? MyColor.primary
                          : MyColor.lightGrey,
                      width: 2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(3),
                child: selectedPurpose == 2
                    ? Container(
                        decoration: const BoxDecoration(
                          color: MyColor.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: bloc.navToNextStep,
                child: "Continue".txt,
              );
            }),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
