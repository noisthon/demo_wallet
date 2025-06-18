import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/helper.dart';

class AdditionalInfoCountryOfResidence extends StatelessWidget {
  const AdditionalInfoCountryOfResidence({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdditionalInfoBloc>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Country of residence".text(30700, color: Colors.black),
            "This info needs to be accurate with your ID document.".txt,
            const SizedBox(height: 48),
            "Country".label,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: MyColor.lightGrey,
                  width: 1,
                ),
              ),
              child: StreamBuilder(
                  stream: bloc.residenceStream,
                  builder: (context, asyncSnapshot) {
                    return DropdownButton<String>(
                      underline: SizedBox.shrink(),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      items: countryList
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.code ?? "",
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6),
                                        child: Image.asset(
                                          "packages/country_code_picker/${c.flagUri!}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: (c.name ?? "").txt),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: asyncSnapshot.data,
                      onChanged: (val) => bloc.changeResidence(val ?? ""),
                    );
                  }),
            ),
            const Spacer(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Builder(builder: (context) {
                return StreamBuilder(
                  stream: bloc.isCountryResidenceStepValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data ?? false
                          ? () => bloc.updateAdditionInfo(context)
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
      ),
    );
  }
}
