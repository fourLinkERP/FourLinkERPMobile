

class CustomerGroup {
  int? id;
  String? cusGroupsCode ;
  String? cusGroupsNameAra ;
  String?  cusGroupsNameEng;
  String? descriptionAra;
  String? descriptionEng;

  CustomerGroup({
    this.id,
    this.cusGroupsCode ,
    this.cusGroupsNameAra,
    this.cusGroupsNameEng,
    this.descriptionAra,
    this.descriptionEng
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) {
    return CustomerGroup(
      id: (json['id'] != null) ? json['id'] as int : 0,
      cusGroupsCode: (json['cusGroupsCode'] != null) ? json['cusGroupsCode'] as String:" ",
      cusGroupsNameAra: (json['cusGroupsNameAra'] != null) ? json['cusGroupsNameAra'] as String:" ",
      cusGroupsNameEng: (json['cusGroupsNameEng'] != null) ? json['cusGroupsNameEng'] as String:" ",
      descriptionAra: (json['descriptionAra'] != null) ? json['descriptionAra'] as String:" ",
      descriptionEng: (json['descriptionEng'] != null) ? json['descriptionEng'] as String:" "
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $cusGroupsNameAra }';
  }
}




