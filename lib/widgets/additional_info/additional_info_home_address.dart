import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/utils/extensions.dart';

class AdditionalInfoHomeAddress extends StatefulWidget {
  const AdditionalInfoHomeAddress({super.key});

  @override
  State<AdditionalInfoHomeAddress> createState() =>
      _AdditionalInfoHomeAddressState();
}

class _AdditionalInfoHomeAddressState extends State<AdditionalInfoHomeAddress>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  "Home address".text(30700, color: Colors.black),
                  "This info needs to be accurate with your ID document.".txt,
                  const SizedBox(height: 48),
                  "Address Line".label,
                  StreamBuilder(
                    stream: bloc.addressLineErrorStream,
                    builder: (context, asyncSnapshot) {
                      return TextFormField(
                        onChanged: bloc.changeAddressLine,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: asyncSnapshot.data,
                          hintText: "e.g., Building 12, Unit A, Main St",
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  "City".label,
                  StreamBuilder(
                    stream: bloc.cityErrorStream,
                    builder: (context, asyncSnapshot) {
                      return TextFormField(
                        onChanged: bloc.changeCity,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: asyncSnapshot.data,
                          hintText: "City, State",
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  "Postcode".label,
                  StreamBuilder(
                    stream: bloc.postCodeErrorStream,
                    builder: (context, asyncSnapshot) {
                      return TextFormField(
                        onChanged: bloc.changePostCode,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: asyncSnapshot.data,
                          hintText: "Ex: 00000",
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
                stream: bloc.isHomeAddressValid,
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

  @override
  bool get wantKeepAlive => true;
}
