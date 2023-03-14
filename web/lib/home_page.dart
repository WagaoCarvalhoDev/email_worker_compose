import 'package:flutter/material.dart';
import 'package:web/models/email_model.dart';

import 'services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<EmailModel>? _emailModel;
  String _subject = '';
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email sender'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child:
            (_emailModel == null) ? buildBuilderColumn() : buildFutureBuilder(),
      ),
    );
  }

  Builder buildBuilderColumn() {
    return Builder(
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
                onSaved: (value) =>
                    setState(() => _subject = value.toString())),
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
              onSaved: (value) => setState(() => _message = value.toString()),
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
                      _subject,
                      _message,
                    );
                    print('Front End :${_subject} ${_message}');
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<EmailModel> buildFutureBuilder() {
    return FutureBuilder<EmailModel>(
      future: _emailModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.subject} ${snapshot.data!.message}');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
