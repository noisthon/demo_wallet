import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/parser.dart';

class AdditionalInfoPersonalInfo extends StatelessWidget {
  const AdditionalInfoPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdditionalInfoBloc>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Add your personal info".text(30700, color: Colors.black),
                  "This info needs to be accurate with your ID document.".txt,
                  const SizedBox(height: 48),
                  "Full Name".label,
                  StreamBuilder(
                    stream: bloc.fullNameLineErrorStream,
                    builder: (context, asyncSnapshot) {
                      return TextFormField(
                        onChanged: bloc.changeFullNameLine,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: asyncSnapshot.data,
                          hintText: "Mr. John Doe",
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  "Username".label,
                  StreamBuilder(
                    stream: bloc.usernameErrorStream,
                    builder: (context, asyncSnapshot) {
                      return TextFormField(
                        onChanged: bloc.changeUsername,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: "@".widget(color: MyColor.primary),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          errorText: asyncSnapshot.data,
                          hintText: "username",
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  "Date of Birth".label,
                  StreamBuilder(
                    stream: bloc.birthDateStream,
                    builder: (context, asyncSnapshot) {
                      return GestureDetector(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: Parser.parseDateTime(),
                            lastDate: DateTime.now(),
                          );
    
                          if (selectedDate != null) {
                            bloc.changeBirthDate(selectedDate);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: MyColor.lightGrey,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(Icons.calendar_today_rounded,
                                    color: MyColor.lightGrey),
                              ),
                              const SizedBox(width: 4),
                              !asyncSnapshot.hasData
                                  ? "MM/DD/YYYY"
                                      .text(16400, color: MyColor.lightGrey)
                                  : asyncSnapshot.data!
                                      .format()
                                      .text(16400, color: Colors.black),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Builder(builder: (context) {
              return StreamBuilder(
                stream: bloc.isPersonalInfoStepValid,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    onPressed: snapshot.data ?? false
                        ? () => bloc.navToNextStep()
                        : null,
                    child: "Continue".txt,
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
