import 'package:flutter/material.dart';
import 'package:mc_crud_test/common/utils/validators.dart';

class FirstStepForm extends StatelessWidget {
  const FirstStepForm({
    Key? key,
    required this.onSavedFirstName,
    required this.onSavedLastName,
    required this.onSavedBirthDate,
  }) : super(key: key);

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
          fieldLabelText: 'Birth date',
          onDateSaved: onSavedBirthDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ),
      ],
    );
  }
}
