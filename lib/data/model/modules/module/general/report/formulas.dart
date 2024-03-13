

class Formulas {
  String? columnName ;
  String? columnValue ;
  String? dataType;

  Formulas({
    this.columnName ,
    this.columnValue,
    this.dataType
    //image
    });

  factory Formulas.fromJson(Map<String, dynamic> json) {
    return Formulas(
       columnName: json['columnName'] as String,
       columnValue: json['columnValue'] as String,
       dataType: json['dataType'] as String,
    );
  }

}


