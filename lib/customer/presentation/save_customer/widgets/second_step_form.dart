import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mc_crud_test/common/utils/validators.dart';

class SecondStepForm extends StatelessWidget {
  const SecondStepForm({
    Key? key,
    required this.onSavedPhoneNumber,
    required this.onSavedEmail,
    required this.onSavedBankAccount,
  }) : super(key: key);

  final FormFieldSetter<String> onSavedPhoneNumber;
  final FormFieldSetter<String> onSavedEmail;
  final FormFieldSetter<String> onSavedBankAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InternationalPhoneNumberInput(
          onInputChanged: (value) {},
          countries: const ['GB', 'US', 'IR'],
          onSaved: (phoneNumber) => onSavedPhoneNumber(phoneNumber.toString()),
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator: FormValidators().email().required().build(),
          onSaved: onSavedEmail,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator:
              FormValidators().minLength(9).maxLength(18).required().build(),
          onSaved: onSavedBankAccount,
          decoration: const InputDecoration(
            labelText: 'Bank account number',
          ),
        ),
      ],
    );
  }
}
