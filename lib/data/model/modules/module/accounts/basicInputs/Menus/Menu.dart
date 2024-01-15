
class Menu {
  int? sysId;
  int? menuId;
  String? menuAraName ;
  String? menuLatName;


  Menu({
    this.sysId,
    this.menuId,
    this.menuAraName,
    this.menuLatName,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      sysId: (json['sysId'] != null) ? json['sysId'] as int : 0,
      menuId: (json['menuId'] != null) ? json['menuId'] as int : 0,
      menuAraName: (json['menuAraName'] != null) ? json['menuAraName'] as String : " ",
      menuLatName: (json['menuLatName'] != null)? json['menuLatName'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $sysId, name: $menuAraName }';
  }
}


