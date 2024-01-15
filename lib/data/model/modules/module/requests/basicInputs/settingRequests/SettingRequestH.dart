String get pickedDate => (DateTime.now()).toString();

class AdditionalRequestH {
  int? id;
  String? settingRequestCode;
  String? requestTypeCode;
  String? settingRequestNameAra;
  String? settingRequestNameEng;
  String? numberOfLevels;
  String? costCenterCode1;
  String? departmentCode;
  String? sendEmailAfterConfirmation;
  int? relatedTransactionMenuId;
  int? relatedTransactionDestinationMenuId;
  String? descriptionAra;
  String? descriptionEng;

  AdditionalRequestH(
      {
        this.id,
        this.settingRequestCode,
        this.requestTypeCode,
        this.settingRequestNameAra,
        this.settingRequestNameEng,
        this.numberOfLevels,
        this.costCenterCode1,
        this.departmentCode,
        this.sendEmailAfterConfirmation,
        this.relatedTransactionMenuId,
        this.relatedTransactionDestinationMenuId,
        this.descriptionAra,
        this.descriptionEng,
      });
  factory AdditionalRequestH.fromJson(Map<String, dynamic> json){
    return AdditionalRequestH(
      id: (json['id'] != null) ? json['id'] as int : 0,
      settingRequestCode: (json['settingRequestCode'] != null) ? json['settingRequestCode'] as String : "",
      requestTypeCode: (json['requestTypeCode'] != null) ? json['requestTypeCode'] as String : "",
      settingRequestNameAra: (json['settingRequestNameAra'] != null) ? json['settingRequestNameAra'] as String : "",
      settingRequestNameEng: (json['settingRequestNameEng'] != null) ? json['settingRequestNameEng'] as String : " ",
      numberOfLevels: (json['numberOfLevels'] != null) ? json['numberOfLevels'] as String : " ",
      costCenterCode1: (json['costCenterCode1'] != null) ? json['costCenterCode1'] as String : " ",
      departmentCode: (json['departmentCode'] != null) ? json['departmentCode'] as String : " ",
      sendEmailAfterConfirmation: (json['sendEmailAfterConfirmation'] != null) ? json['sendEmailAfterConfirmation'] as String : " ",
      relatedTransactionMenuId: (json['relatedTransactionMenuId'] != null) ? json['relatedTransactionMenuId'] as int : 0,
      relatedTransactionDestinationMenuId: (json['relatedTransactionDestinationMenuId'] != null) ? json['relatedTransactionDestinationMenuId'] as int : 0,
      descriptionAra: (json['descriptionAra'] != null) ? json['descriptionAra'] as String : " ",
      descriptionEng: (json['descriptionEng'] != null) ? json['descriptionEng'] as String : " ",
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $settingRequestCode }';
  }
}
