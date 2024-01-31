
class CarGroup{
  int? id;
  String? groupCode;
  String? groupNameAra;
  String? groupNameEng;

  CarGroup({
    this.id,
    this.groupCode,
    this.groupNameAra,
    this.groupNameEng,
  });

  factory CarGroup.fromJson(Map<String, dynamic> json) {
    return CarGroup(
      id: (json['id'] != null) ? json['id'] as int : 0,
      groupCode: (json['groupCode'] != null) ? json['groupCode'] as String : " ",
      groupNameAra: (json['groupNameAra'] != null) ? json['groupNameAra'] as String : " ",
      groupNameEng: (json['groupNameEng'] != null) ? json['groupNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $groupNameAra }';
  }
}