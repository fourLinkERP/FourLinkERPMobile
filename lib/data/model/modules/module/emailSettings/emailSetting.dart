
class EmailSettings{
  int? id;
  String? emailSettingCode;
  String? emailSettingNameAra;
  String? emailSettingNameEng;

  EmailSettings({
    this.id,
    this.emailSettingCode ,
    this.emailSettingNameAra,
    this.emailSettingNameEng,
  });

  factory EmailSettings.fromJson(Map<String, dynamic> json) {
    return EmailSettings(
      id: (json['id'] != null) ? json['id'] as int : 0,
      emailSettingCode: (json['emailSettingCode'] != null) ? json['emailSettingCode'] as String : " ",
      emailSettingNameAra: (json['emailSettingNameAra'] != null) ? json['emailSettingNameAra'] as String : " ",
      emailSettingNameEng: (json['emailSettingNameEng'] != null) ? json['emailSettingNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $emailSettingNameAra }';
  }
}