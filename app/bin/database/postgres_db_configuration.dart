import 'package:postgres/postgres.dart';

var conn = PostgreSQLConnection("db", 5432, "email_sender", username: "postgres", password: "password");
