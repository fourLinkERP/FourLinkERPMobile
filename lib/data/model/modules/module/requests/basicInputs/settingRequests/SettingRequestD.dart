String get pickedDate => (DateTime.now()).toString();

class SettingRequestD {
  int? id;
  int? lineNum;
  String? settingRequestCode;
  int? levels;
  int? groupCode;
  String? groupName;
  String? empCode;
  String? empName;
  String? alternativeEmpCode;
  String? alternativeEmpName;
  String? emailReceivers;
  String? smsReceivers;
  String? whatsappReceivers;
  String? descriptionAra;
  String? descriptionEng;
  bool? isUpdate = false;

  SettingRequestD(
      {
        this.id,
        this.lineNum,
        this.settingRequestCode,
        this.levels,
        this.groupCode,
        this.groupName,
        this.empCode,
        this.empName,
        this.alternativeEmpCode,
        this.alternativeEmpName,
        this.emailReceivers,
        this.smsReceivers,
        this.whatsappReceivers,
        this.descriptionAra,
        this.descriptionEng,
      });
  factory SettingRequestD.fromJson(Map<String, dynamic> json){
    return SettingRequestD(
      id: (json['id'] != null) ? json['id'] as int : 0,
      lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
      settingRequestCode: (json['settingRequestCode'] != null) ? json['settingRequestCode'] as String : "",
      levels: (json['levels'] != null) ? json['levels'] as int : 0,
      groupCode: (json['groupCode'] != null) ? json['groupCode'] as int : 0,
      groupName: (json['groupName'] != null) ? json['groupName'] as String : "",
      empCode: (json['empCode'] != null) ? json['empCode'] as String : "",
      empName: (json['empName'] != null) ? json['empName'] as String : "",
      alternativeEmpCode: (json['alternativeEmpCode'] != null) ? json['alternativeEmpCode'] as String : "",
      alternativeEmpName: (json['alternativeEmpName'] != null) ? json['alternativeEmpName'] as String : "",
      emailReceivers: (json['emailReceivers'] != null) ? json['emailReceivers'] as String : " ",
      smsReceivers: (json['smsReceivers'] != null) ? json['smsReceivers'] as String : " ",
      whatsappReceivers: (json['whatsappReceivers'] != null) ? json['whatsappReceivers'] as String : " ",
      descriptionAra: (json['descriptionAra'] != null) ? json['descriptionAra'] as String : " ",
      descriptionEng: (json['descriptionEng'] != null) ? json['descriptionEng'] as String : " ",
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $settingRequestCode }';
  }
}
