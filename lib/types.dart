import 'package:flutter/material.dart';

/*
    * This is the callback that will be passed to the parent widget
    * It will be called with the following parameters:
    * payload: The payload of the form
*/
typedef Submitter = Function(Map<String, dynamic> payload, Map<String, dynamic> errors);

/*
    * This is the callback that will be passed to the child widget
    * It will be called with the following parameters:
    * values: The current values of the form
    * isValid: The current validity of the form
    * handleSubmit: The function to submit the form
    * handleReset: The function to reset the form
    * handleChange: The function to change the value of a field
    * errors: The current errors of the form
*/
typedef ChildCallback = Widget Function(
  Map<String, dynamic> values,
  bool? isValid,
  Function handleSubmit,
  Function handleReset,
  Function handleChange,
  Map<String, String> errors,
);
