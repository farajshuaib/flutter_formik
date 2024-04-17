import 'package:flutter/material.dart';
import 'package:flutter_formik/flutter_formik.dart';
import 'package:form_validator/form_validator.dart';

import 'user_model.dart';

void main() {
  runApp(const Demo());
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Formik Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Formik Demo'),
        ),
        body: Formik(
          initialValues: {
            'email': '',
            'password': '',
          },
          validationSchema: {
            'email': ValidationBuilder().required('Email is required').email('Email is not valid'),
            'password': ValidationBuilder().required('Password is required').minLength(6, 'Password must be at least 6 characters'),
          },
          onSubmit: (payload, errors) {
            if (errors.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errors.values.first),
                ),
              );
              return;
            }
            UserModel user = UserModel.fromJson(payload);
            // Send user object to your business logic
            // ...
          },
          child: (values, isValid, handleSubmit, handleReset, handleChange, errors) {
            return Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: errors['email'],
                  ),
                  onChanged: (value) {
                    handleChange('email', value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: errors['password'],
                  ),
                  onChanged: (value) {
                    handleChange('password', value);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
