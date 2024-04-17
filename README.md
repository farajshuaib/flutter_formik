# Flutter Formik

Flutter Formik is a form management library for Flutter inspired by the React Formik package. It provides an easy and intuitive way to handle form state, validation, and submission in your Flutter applications. Flutter Formik is designed to be simple, flexible, and extensible, allowing you to build complex forms with minimal boilerplate code. It is built on top of the form_validator package to provide customizable validation rules and error messages, this package remind of yup js library lol.
## Features

- Simple and declarative API for managing form state
- Built-in validation support with customizable validation rules using form_validator package
- Form submission handling with optional asynchronous operations
- Integration with Flutter's widget tree for seamless rendering
- Designed to promote separation of concerns and reusability

## Installation

To use Flutter Formik in your Flutter project, add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_formik: ^1.0.0
```

Then run `flutter pub get` to install the package.

## Usage
Here's a basic example of how to use Flutter Formik:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_formik/flutter_formik.dart';
import 'package:form_validator/form_validator.dart';

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
```

For more detailed examples and advanced usage, please refer to the examples folder in the Flutter Formik GitHub repository.

## Documentation
The documentation for Flutter Formik is available in the GitHub repository. It provides detailed explanations of the available features, usage guidelines, and API references.

## Contributing
Contributions to Flutter Formik are welcome and encouraged! If you have any ideas, suggestions, or bug reports, please feel free to open an issue or submit a pull request on the GitHub repository.

## License
Flutter Formik is licensed under the MIT License. See the LICENSE file for more information.
[]: # (END)