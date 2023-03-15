import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../database/postgres_db_configuration.dart';
import '../models/email_model.dart';

class SendEmailApi {
  Handler get handler {
    Router router = Router();
    router.post('/send_email', (Request request) async {
      var body = await request.readAsString();
      var result = EmailModel.fromRequest(jsonDecode(body));
      registerMessage(result.subject.toString(), result.message.toString());
      return Response(201, body: jsonEncode(result.toJson()));
    });
    return router;
  }
}
