

class ItemType {
  int? id;
  int? itemTypeCode ;
  String? itemTypeName ;
  String? itemTypeNameAra ;
  String?  itemTypeNameEng;


  ItemType({
    this.id,
    this.itemTypeCode ,
    this.itemTypeName,
    this.itemTypeNameAra,
    this.itemTypeNameEng,

  });

  factory ItemType.fromJson(Map<String, dynamic> json) {
    return ItemType(
      id: (json['id'] != null) ? json['id'] as int : 0,
      itemTypeCode: (json['itemTypeCode'] != null) ? json['itemTypeCode']  as int : 0,
      itemTypeName: (json['itemTypeName'] != null) ? json['itemTypeName'] as String:" ",
      itemTypeNameAra: (json['itemTypeNameAra'] != null) ? json['itemTypeNameAra'] as String:" ",
      itemTypeNameEng: (json['itemTypeNameEng'] != null) ? json['itemTypeNameEng'] as String:" ",

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $itemTypeName }';
  }
}