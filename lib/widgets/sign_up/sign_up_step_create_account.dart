import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:wallet/main.dart';
import 'package:wallet/utils/extensions.dart';

class SignUpStepCreateAccount extends StatelessWidget {
  const SignUpStepCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          "Create an Account".text(17500),
          "Enter your mobile number to verify your account".text(14400),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: MyColor.lightGrey,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: CountryCodePicker(
                  initialSelection: "+976",
                  builder: (countryCode) {
                    if (countryCode == null) {
                      return const SizedBox.shrink();
                    }
                    return Row(
                      children: [
                        if (countryCode.flagUri != null)
                          Image.asset(
                            "packages/country_code_picker/${countryCode.flagUri!}",
                          ),
                        const SizedBox(width: 2),
                        countryCode.dialCode?.text(15500) ?? SizedBox.shrink()
                      ],
                    );
                  },
                ),
              ),
              Expanded(child: TextFormField()),
            ],
          ),
          TextFormField(),
        ],
      ),
    );
  }
}
