library flutter_formik;

import 'package:flutter/material.dart';
import 'package:flutter_formik/types.dart';
import 'package:form_validator/form_validator.dart';

/*
  * This is the main widget of the library
  * It will be used to wrap the form fields
  * It will be called with the following parameters:
  * initialValues: The initial values of the form
  * validationSchema: The validation schema of the form
  * onSubmit: The function to submit the form
  * child: The child widget that will be wrapped by the form
  * enableReinitialize: A boolean to enable reinitialization of the form
  * validateOnChange: A boolean to enable validation on change
  * validateOnMount: A boolean to enable validation on mount
  * initialErrors: The initial errors of the form
  * key: The key of the widget
*/

class Formik extends StatefulWidget {
  final Map<String, dynamic> initialValues;
  Map<String, ValidationBuilder> validationSchema;
  final Submitter onSubmit;
  final ChildCallback child;
  final bool enableReinitialize;
  final bool validateOnChange;
  final bool validateOnMount;
  final Map<String, String> initialErrors;

  Formik(
      {required this.initialValues,
      required this.validationSchema,
      required this.onSubmit,
      required this.child,
      this.enableReinitialize = false,
      this.validateOnChange = false,
      this.validateOnMount = false,
      this.initialErrors = const {},
      super.key}) {}

  @override
  State<Formik> createState() => _FormikState();
}

class _FormikState extends State<Formik> {
  Map<String, String> errors = {};
  Map<String, dynamic> values = {};
  bool? isValid;

  @override
  void initState() {
    super.initState();
    values = widget.initialValues;

    if (widget.validateOnMount) validate();

    if (widget.initialErrors.isNotEmpty) {
      setState(() {
        errors = widget.initialErrors;
        isValid = false;
      });
    }
  }

  @override
  void didUpdateWidget(Formik oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableReinitialize && widget.initialValues != oldWidget.initialValues) {
      setState(() {
        values = widget.initialValues;
      });
    }
  }

  void handleReset() {
    setState(() {
      values.clear();
      errors.clear();
      isValid = false;
    });
  }

  void handleChange(String key, dynamic value) {
    try {
      if (values[key] != value) {
        setState(() {
          values[key] = value;
        });
        if (widget.validateOnChange) validate();
      }
    } catch (e) {
      throw Exception('Property $key does not exist in object ${widget.initialValues.runtimeType.toString()}');
    }
  }

  void handleSubmit() {
    validate();
    widget.onSubmit(values, errors);
  }

  void validate() {
    Map<String, String> updatedErrors = {};
    bool updatedIsValid = true;

    for (var key in values.keys) {
      final value = values[key];
      final validator = widget.validationSchema[key];

      if (validator != null && value != null) {
        final error = validator.test(value);
        if (error != null && error.isNotEmpty) updatedErrors[key] = error;
      }
    }

    updatedIsValid = updatedErrors.isEmpty;

    setState(() {
      errors = updatedErrors;
      isValid = updatedIsValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(
      values,
      isValid,
      handleSubmit,
      handleReset,
      handleChange,
      errors,
    );
  }
}
