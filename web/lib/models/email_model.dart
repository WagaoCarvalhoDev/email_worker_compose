class EmailModel {
  final String subject;
  final String message;

  EmailModel({required this.subject, required this.message});

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      subject: json['subject'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subject": subject,
      "message": subject,
    };
  }
}
