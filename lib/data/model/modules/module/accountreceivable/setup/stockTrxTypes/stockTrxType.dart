

class StockTrxTypes{
  String? trxSerialCode;
  String? trxSerialName;

  StockTrxTypes({
   this.trxSerialCode,
   this.trxSerialName
});
  factory StockTrxTypes.fromJson(Map<String, dynamic> json) {
    return StockTrxTypes(

      trxSerialCode: (json['trxSerialCode'] != null)?  json['trxSerialCode'] as String : "",
      trxSerialName: (json['trxSerialName'] != null)?  json['trxSerialName'] as String : "",
    );
  }
  @override
  String toString(){
    return 'Trans{id: $trxSerialCode, name: $trxSerialName }';
  }
}