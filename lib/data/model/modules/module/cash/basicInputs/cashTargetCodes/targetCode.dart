

class TargetCode {
  int? id;
  String? code ;
  String? nameAra ;
  String?  nameEng;


  TargetCode({
    this.id,
    this.code ,
    this.nameAra,
    this.nameEng,
    //image
  });

  factory TargetCode.fromJson(Map<String, dynamic> json) {
    return TargetCode(
      id: json['id'] as int,
      code: json['code'] as String,
      nameAra: json['nameAra'] as String,
      nameEng: json['nameEng'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $nameAra }';
  }
}
