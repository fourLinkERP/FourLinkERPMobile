

class CostCenter {
  int? id;
  String? costCenterCode ;
  String? costCenterNameAra ;
  String?  costCenterNameEng;




  CostCenter({
    this.id,
    this.costCenterCode ,
    this.costCenterNameAra,
    this.costCenterNameEng,
    });

  factory CostCenter.fromJson(Map<String, dynamic> json) {
    return CostCenter(
      id: (json['id'] != null) ? json['id'] as int : 0,
      costCenterCode: (json['costCenterCode'] != null) ? json['costCenterCode'] as String : " ",
      costCenterNameAra: (json['costCenterNameAra'] != null) ? json['costCenterNameAra'] as String : " ",
      costCenterNameEng: (json['costCenterNameEng'] != null) ? json['costCenterNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $costCenterNameAra }';
  }
}






// Our demo Branchs

// List<CostCenter> demoBranches = [
//   CostCenter(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   CostCenter(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

