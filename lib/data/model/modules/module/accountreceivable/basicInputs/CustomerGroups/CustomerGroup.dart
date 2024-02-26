

class CustomerGroup {
  int? id;
  String? cusGroupsCode ;
  String? cusGroupsNameAra ;
  String?  cusGroupsNameEng;


  CustomerGroup({
    this.id,
    this.cusGroupsCode ,
    this.cusGroupsNameAra,
    this.cusGroupsNameEng,

    //image
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) {
    return CustomerGroup(
      id: (json['id'] != null) ? json['id'] as int : 0,
      cusGroupsCode: (json['cusGroupsCode'] != null) ? json['cusGroupsCode'] as String:" ",
      cusGroupsNameAra: (json['cusGroupsNameAra'] != null) ? json['cusGroupsNameAra'] as String:" ",
      cusGroupsNameEng: (json['cusGroupsNameEng'] != null) ? json['cusGroupsNameEng'] as String:" ",

      //image: json['image'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $cusGroupsNameAra }';
  }
}




