
String get pickedDate => (DateTime.now()).toString();
class Mails{
  int? id;
  String? toEmail;
  String? fromEmail;
  String? trxDate;
  String? bodyAra;
  String? messageTitleAra;
  String? maxReplyDate;
  String? priorityCode;
  String? cloneEmail;

  Mails({
   this.id,
   this.trxDate,
   this.toEmail,
   this.fromEmail,
   this.bodyAra,
   this.maxReplyDate,
   this.messageTitleAra,
   this.priorityCode,
   this.cloneEmail
});

  factory Mails.fromJson(Map<String, dynamic> json){
    return Mails(
      id: (json['id'] != null) ? json['id'] as int : 0,
      toEmail: (json['toEmail'] != null) ? json['toEmail'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      maxReplyDate: (json['maxReplyDate'] != null) ? json['maxReplyDate'] as String : pickedDate,
      fromEmail: (json['fromEmail'] != null) ? json['fromEmail'] as String : "",
      bodyAra: (json['bodyAra'] != null) ? json['bodyAra'] as String : " ",
      messageTitleAra: (json['messageTitleAra'] != null) ? json['messageTitleAra'] as String : "",
      priorityCode: (json['priorityCode'] != null) ? json['priorityCode'] as String : " ",
      cloneEmail: (json['cloneEmail'] != null) ? json['cloneEmail'] as String : " ",

    );
  }
  @override
  String toString() {
    return 'Trans{id: $id }';
  }
}