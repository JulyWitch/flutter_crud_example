import 'package:flutter/material.dart';

import 'package:customer_management/common/utils/validators.dart';

class FirstStepForm extends StatelessWidget {
  const FirstStepForm({
    Key? key,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialBirthDate,
    required this.onSavedFirstName,
    required this.onSavedLastName,
    required this.onSavedBirthDate,
  }) : super(key: key);

  final String? initialFirstName;
  final String? initialLastName;
  final DateTime? initialBirthDate;

  final FormFieldSetter<String> onSavedFirstName;
  final FormFieldSetter<String> onSavedLastName;
  final FormFieldSetter<DateTime> onSavedBirthDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                key: const ValueKey('firstNameField'),
                initialValue: initialFirstName,
                onSaved: onSavedFirstName,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'First name',
                  errorMaxLines: 2,
                ),
                validator: FormValidators()
                    .minLength(2)
                    .maxLength(50)
                    .required()
                    .build(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                key: const ValueKey('lastNameField'),
                initialValue: initialLastName,
                onSaved: onSavedLastName,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Last name',
                  errorMaxLines: 2,
                ),
                validator: FormValidators()
                    .minLength(2)
                    .maxLength(50)
                    .required()
                    .build(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        InputDatePickerFormField(
          key: const ValueKey('birthDateField'),
          fieldLabelText: 'Birth date',
          initialDate: initialBirthDate,
          onDateSaved: onSavedBirthDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ),
      ],
    );
  }
}
