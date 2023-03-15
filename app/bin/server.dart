import 'package:shelf/shelf.dart';

import 'apis/send_email_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';

void main() async {
  var cascadeHandler = Cascade()
      .add(
        SendEmailApi().handler,
      )
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(cascadeHandler);

  CustomServer().initialize(handler);
}
