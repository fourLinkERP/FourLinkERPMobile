
class Level {
  int? id;
  String? levelCode;
  String? levelNameAra ;
  String? levelNameEng;


  Level({
    this.id,
    this.levelCode,
    this.levelNameAra,
    this.levelNameEng,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: (json['id'] != null) ? json['id'] as int : 0,
      levelCode: (json['levelCode'] != null) ? json['levelCode'] as String : " ",
      levelNameAra: (json['levelNameAra'] != null) ? json['levelNameAra'] as String : " ",
      levelNameEng: (json['levelNameEng'] != null)? json['levelNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $levelNameAra }';
  }
}


