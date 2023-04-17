import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:mc_crud_test/common/utils/validators.dart';
import 'package:mc_crud_test/customer/presentation/widgets/async_text_form_field.dart';

class SecondStepForm extends StatelessWidget {
  const SecondStepForm({
    Key? key,
    required this.initialPhoneNumber,
    required this.initialEmail,
    required this.initiaBankAccount,
    required this.onSavedPhoneNumber,
    required this.onSavedEmail,
    required this.onSavedBankAccount,
    required this.isEmailAvaliable,
  }) : super(key: key);

  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initiaBankAccount;

  final FormFieldSetter<String> onSavedPhoneNumber;
  final FormFieldSetter<String> onSavedEmail;
  final FormFieldSetter<String> onSavedBankAccount;

  final Future<bool> Function(String) isEmailAvaliable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PhoneNumberInput(
          onSavedPhoneNumber: onSavedPhoneNumber,
          initialPhoneNumber: initialPhoneNumber,
        ),
        const SizedBox(height: 16),
        AsyncTextFormField(
          initialValue: initialEmail,
          autovalidateMode: AutovalidateMode.disabled,
          validator: (value) async {
            String? error = FormValidators().email().required().build()(value);

            if(error == null)  {
              if(!(await isEmailAvaliable(value))) {
                error = 'This email already exists!';
              }
            }

            return error;
          },
          onSaved: onSavedEmail,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: initiaBankAccount,
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

class _PhoneNumberInput extends StatefulWidget {
  const _PhoneNumberInput({
    Key? key,
    required this.onSavedPhoneNumber,
    this.initialPhoneNumber,
  }) : super(key: key);
  final FormFieldSetter<String> onSavedPhoneNumber;
  final String? initialPhoneNumber;

  @override
  State<_PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<_PhoneNumberInput> {
  late bool isEditing = widget.initialPhoneNumber == null;

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return InternationalPhoneNumberInput(
        initialValue: widget.initialPhoneNumber == null
            ? null
            : PhoneNumber(phoneNumber: widget.initialPhoneNumber),
        formatInput: false,
        onInputChanged: (value) {},
        countries: const ['GB', 'US', 'IR'],
        onSaved: (phoneNumber) => widget.onSavedPhoneNumber(
          phoneNumber.phoneNumber,
        ),
      );
    } else {
      return TextFormField(
        initialValue: widget.initialPhoneNumber,
        onSaved: widget.onSavedPhoneNumber,
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              isEditing = true;

              setState(() {});
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ),
      );
    }
  }
}
