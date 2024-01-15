
class UserGroup {
  int? id;
  int? groupId;
  String? groupNameAra ;
  String? groupNameEng;


  UserGroup({
    this.id,
    this.groupId,
    this.groupNameAra,
    this.groupNameEng,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      id: (json['id'] != null) ? json['id'] as int : 0,
      groupId: (json['groupId'] != null) ? json['groupId'] as int : 0,
      groupNameAra: (json['groupNameAra'] != null) ? json['groupNameAra'] as String : " ",
      groupNameEng: (json['groupNameEng'] != null)? json['groupNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $groupNameAra }';
  }
}


