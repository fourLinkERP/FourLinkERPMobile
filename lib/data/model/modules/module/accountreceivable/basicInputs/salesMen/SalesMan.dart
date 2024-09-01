

class SalesMan {
  int? id;
  String? salesManCode ;
  String? salesManNameAra ;
  String?  salesManNameEng;
  String? address;
  String? tel1;



  SalesMan({this.id,
    this.salesManCode ,
    this.salesManNameAra,
    this.salesManNameEng,
    this.address,
    this.tel1,
    //image
    });

  factory SalesMan.fromJson(Map<String, dynamic> json) {
    return SalesMan(
      id: json['id'] as int,
      salesManCode: json['salesManCode'] as String,
      salesManNameAra: json['salesManNameAra'] as String,
      salesManNameEng: json['salesManNameEng'] as String,
      // address: json['address'] as String,
      // tel1: json['tel1'] as String,
      //image: json['image'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $salesManNameAra }';
  }
}

