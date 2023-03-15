import 'package:postgres/postgres.dart';

var conn = PostgreSQLConnection("db", 5432, "email_sender",
    username: "postgres", password: "password");

dynamic registerMessage(String subject, String message) async {
  var conn = PostgreSQLConnection("db", 5432, "email_sender",
      username: "postgres", password: "password");
  await conn.open();
  await conn.execute(
      "INSERT INTO emails (subject, message) VALUES (@subject, @message)",
      substitutionValues: {"subject": subject, "message": message});
  print('Mensagem registrada');
  conn.close();
}
