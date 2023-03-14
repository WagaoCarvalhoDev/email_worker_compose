import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/email_model.dart';

final router = Router()
  ..get('/', _rootHandler)
  ..post('/send_email', _emailHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, Woorld!\n');
}

Future<Response> _emailHandler(Request request) async {
  var body = await request.readAsString();
  var result = EmailModel.fromRequest(jsonDecode(body));
  return Response(201, body: jsonEncode(result.toJson()));
}
