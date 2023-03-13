import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'email_model.dart';
import 'middleware_interception.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/send_email', _emailHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, Woorld!\n');
}

Future<Response> _emailHandler(Request request) async {
  var body = await request.readAsString();
  var result = EmailModel.fromRequest(jsonDecode(body));
  //print('YYYYYYYYYYYYYYYYYYYYYY ${result.subject.runtimeType}');
  var email = EmailModel(result.subject, result.message).toJson();
  return Response(201,
      body:
          'Message queued! Subject: ${email.values} fdfd${email.runtimeType}');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
