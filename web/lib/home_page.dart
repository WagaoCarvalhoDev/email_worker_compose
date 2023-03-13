import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web/email_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _subject;
  String? _message;

  Future<EmailModel> createClient(String subject, String message) async {
    final response = await http.post(
      Uri.parse('http://localhost/send_email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': subject,
        'message': message,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('XXXXXXXXXXXX ${response.body.runtimeType}');
      return EmailModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email sender'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Builder(
            builder: (context) => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter with subject',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) => setState(() => _subject = value)),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter with message',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) => setState(() => _message = value),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              createClient(
                                  _subject.toString(), _message.toString());
                              print('Front End :${_subject} ${_message}');
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
