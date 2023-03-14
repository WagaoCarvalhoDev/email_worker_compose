import 'dart:convert';

import '../models/email_model.dart';
import 'package:http/http.dart' as http;

Future<EmailModel> createClient(String subject, String message) async {
  final response = await http.post(
    Uri.parse('http://localhost/send_email'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'subject': subject,
      'message': message,
    }),
  );

  if (response.statusCode == 201) {
    print('XXXXXXXXXXXX ${response.body.runtimeType}');
    return EmailModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}
