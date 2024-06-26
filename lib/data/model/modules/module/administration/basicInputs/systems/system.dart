
class System{
  int? id;
  int? systemCode;
  String? systemName;
  String? systemNameAra;
  String? systemNameEng;

  System({
    this.id,
    this.systemCode,
    this.systemName,
    this.systemNameAra,
    this.systemNameEng
});
  factory System.fromJson(Map<String, dynamic> json) {
    return System(
      id: (json['id'] != null) ? json['id'] as int : 0,
      systemCode: (json['systemCode'] != null) ? json['systemCode'] as int: 0,
      systemNameAra: (json['systemNameAra'] != null) ? json['systemNameAra'] as String : "",
      systemNameEng: (json['systemNameEng'] != null) ? json['systemNameEng'] as String : "",
      systemName: (json['systemName'] != null) ? json['systemName'] as String : "",

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $systemNameAra }';
  }
}