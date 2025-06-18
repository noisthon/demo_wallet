import 'package:flutter/material.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/models/recipient.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

const mehadi =
    Recipient(name: "Mehadi Hasan", email: "helloyouthmind@gmail.com");
final suggestion = [mehadi];

class ChooseRecipient extends StatefulWidget {
  const ChooseRecipient({super.key});

  @override
  State<ChooseRecipient> createState() => _ChooseRecipientState();
}

class _ChooseRecipientState extends State<ChooseRecipient> {
  final searchController = TextEditingController();
  final boxController = BoxController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SendMoneyBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Choose recipient".text(30700, color: Colors.black),
            "Please select your recpient to send money".txt,
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: MyColor.light,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: MyColor.lightGrey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                              child: FieldSuggestion<Recipient>(
                            inputDecoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Search "Recipient Email"',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            suggestions: suggestion,
                            textController: searchController,
                            boxController: boxController,
                            boxStyle: BoxStyle(
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            itemBuilder: (p0, index) {
                              return GestureDetector(
                                  onTap: () {
                                    bloc.navToNextStep();
                                    boxController.close?.call();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(),
                                    title: suggestion[0].name.txt,
                                    subtitle: suggestion[0].email.txt,
                                  ));
                            },
                            search: (Recipient item, String input) {
                              return item.name.contains(input) ||
                                  item.email.contains(input);
                            },
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    "Most Recent".text(15500),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          bloc.navToNextStep();
                        },
                        dense: true,
                        leading: const CircleAvatar(),
                        title: mehadi.name.txt,
                        subtitle: mehadi.email.txt,
                        trailing: "-${100.0.format(curCode: "USD")}"
                            .text(15400, color: Colors.red),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        color: MyColor.light,
                      ),
                      itemCount: 5,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
