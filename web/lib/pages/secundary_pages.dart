import 'package:flutter/material.dart';

class SecondaryPage extends StatefulWidget {
  const SecondaryPage({
    Key? key,
    required this.subject,
    required this.message,
  }) : super(key: key);

  final String subject;
  final String message;

  @override
  State<SecondaryPage> createState() => _SecondaryPageState();
}

class _SecondaryPageState extends State<SecondaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Secundaria"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text("Subject: ${widget.subject} Message: ${widget.subject}")
          ],
        ),
      ),
    );
  }
}
