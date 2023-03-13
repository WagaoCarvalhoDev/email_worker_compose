class EmailModel {
  String? subject;
  String? message;

  EmailModel([this.subject, this.message]);

  factory EmailModel.fromRequest(Map map) {
    return EmailModel()
      ..subject = map['subject']
      ..message = map['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      "subject": subject,
      "message": message,
    };
  }
}
