import 'package:flutter/material.dart';

RegExp _email = RegExp(
  r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
);


/// A class to use in form fields
/// to validate field values.
/// 
/// To add a custom validator, Use `addValidator` method.
/// 
/// Remember to call `build` method after adding all validators.
/// 
/// ### Usage
/// - Example: Email validation
/// ```dart
/// TextFormField(
/// ...
/// validator: FormValidators().required().email().build(),
/// )
/// ```
/// 
class FormValidators {
  final List<FormFieldValidator<String>> _validators =
      List.empty(growable: true);

  FormValidators addValidator(FormFieldValidator<String> validator) {
    _validators.add(validator);
    return this;
  }

  FormValidators email({String? errorMessage}) {
    String? emailValidator(String? v) {
      if (v != null && _email.hasMatch(v.toLowerCase()) == false) {
        return errorMessage ?? 'Please enter a valid email address';
      }

      return null;
    }

    return maxLength(40, errorMessage: 'Please enter a valid email address')
        .addValidator(emailValidator);
  }

  FormFieldValidator<String> build() {
    return (v) {
      for (final validator in _validators) {
        final error = validator(v);
        if (error != null) {
          return error;
        }
      }

      return null;
    };
  }

  FormValidators phoneNumber({String? errorMessage}) {
    // TODO(sajad): We probably need more validations for phone number
    return maxLength(20,
        errorMessage: errorMessage ?? 'Please enter a valid phone number.');
  }

  FormValidators maxLength(int n, {String? errorMessage}) {
    String? max(v) {
      if (v != null && v.length > n) {
        return errorMessage ??
            'Please enter a value less than $n characters long.';
      }
      return null;
    }

    return addValidator(max);
  }

  FormValidators minLength(int n, {String? errorMessage}) {
    String? min(v) {
      if (v != null && v.length < n) {
        return errorMessage ?? 'Please enter at least $n characters.';
      }
      return null;
    }

    return addValidator(min);
  }

  FormValidators required({String? errorMessage}) {
    String? req(v) {
      if (v == null || v.isEmpty) {
        return errorMessage ?? 'This field is required.';
      }
      return null;
    }

    return addValidator(req);
  }
}
