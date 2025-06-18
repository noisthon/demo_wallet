import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/utils/extensions.dart';

class AdditionalInfoAddEmail extends StatefulWidget {
  const AdditionalInfoAddEmail({super.key});

  @override
  State<AdditionalInfoAddEmail> createState() => _AdditionalInfoAddEmailState();
}

class _AdditionalInfoAddEmailState extends State<AdditionalInfoAddEmail>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = context.read<AdditionalInfoBloc>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Add your email".text(30700, color: Colors.black),
            "This info needs to be accurate with your ID document.".txt,
            const SizedBox(height: 48),
            "Email".label,
            StreamBuilder(
                stream: bloc.emailErrorStream,
                builder: (context, asyncSnapshot) {
                  return TextFormField(
                    onChanged: bloc.changeEmail,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      errorText: asyncSnapshot.data,
                      hintText: "name@example.com",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  );
                }),
            const Spacer(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Builder(builder: (context) {
                return StreamBuilder(
                  stream: bloc.isAddEmailStepValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed:
                          snapshot.data ?? false ? bloc.navToNextStep : null,
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

  @override
  bool get wantKeepAlive => true;
}
