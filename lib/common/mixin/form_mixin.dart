import 'package:flutter/material.dart';

/// A mixin to add form validation and saving functionality
/// to ChangeNotifiers.
/// ### Usage
/// 1. Create the form widget
/// 2. Give the form key to form widget
/// 3. In form fields, save values using saveField method
/// 4. Call validate form and then save the form to get the values
mixin FormMixin on ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final Map<String, dynamic> _formFields = {};

  FormFieldSetter saveField(String fieldName) {
    return (v) {
      _formFields[fieldName] = v;
    };
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Map<String, dynamic> saveForm() {
    formKey.currentState!.save();

    return _formFields;
  }
}
