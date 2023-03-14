import 'package:postgres/postgres.dart';

Future<int> MongoDBConfiguration(String subject, String message) async {
  var connection = PostgreSQLConnection(
    "db",
    5432,
    "email_sender",
    username: "postgres",
    password: "password",
  );
  await connection.open();
  String sql =
      'INSERT INTO emails (subject, message) VALUES (@subject, @description) RETURNING id';
  connection.execute(sql);
  connection.close();
  return 1;
}
