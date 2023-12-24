
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
      emailSettingCode: (json['departmentCode'] != null) ? json['departmentCode'] as String : " ",
      emailSettingNameAra: (json['departmentNameAra'] != null) ? json['departmentNameAra'] as String : " ",
      emailSettingNameEng: (json['departmentNameEng'] != null) ? json['departmentNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $emailSettingNameAra }';
  }
}