import 'dart:convert';

import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/email_model.dart';

dynamic registerMessage(String subject, String message)async{
  var conn = PostgreSQLConnection("db", 5432, "email_sender", username: "postgres", password: "password");
  await conn.open();
  await conn.execute("INSERT INTO emails (subject, message) VALUES (@subject, @message)", substitutionValues: {
  "subject" : subject, "message": message});
  print('Mensagem registrada');
  conn.close();
}

final router = Router()
  ..get('/', _rootHandler)
  ..post('/send_email', _emailHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, Woorld!\n');
}

Future<Response> _emailHandler(Request request) async {
  var body = await request.readAsString();
  var result = EmailModel.fromRequest(jsonDecode(body));
  registerMessage(result.subject.toString(), result.message.toString());
  return Response(201, body: jsonEncode(result.toJson()));
}
