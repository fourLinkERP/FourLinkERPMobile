
class Account{
  int? id;
  String? accountCode;
  String? accountNameAra;
  String? accountNameEng;


  Account({
    this.id,
    this.accountCode,
    this.accountNameAra,
    this.accountNameEng
});

  factory Account.fromJson(Map<String, dynamic> json){
    return Account(
      id: (json["id"] != null) ? json["id"] as int : 0,
      accountCode: (json["accountCode"] != null) ? json["accountCode"] as String : "",
      accountNameAra: (json["accountNameAra"] != null) ? json["accountNameAra"] as String : "",
      accountNameEng: (json["accountNameEng"] != null) ? json["accountNameEng"] as String : "",
    );
  }
}