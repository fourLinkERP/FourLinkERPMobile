String get pickedDate => (DateTime.now()).toString();

class CarReceiveH {
  int? id;
  String? trxSerial;
  String? customerCode;
  String? carCode;
  String? receiveCarStatusCode;
  int? returnOldPartStatusCode;
  int? repeatRepairStatusCode;
  String? counter;
  String? customerMobile;
  int? netTotal;
  String? deliveryDate;
  String? deliveryTime;
  String? maintenanceClassificationCode;
  String? maintenanceTypeCode;
  String? paymentMethodCode;
  String? customerSignature;
  bool? navMemoryCard;
  bool? alloyWheelLock;
  bool? usbDevice;
  bool? navDeliverd;
  bool? usbDeliverd;
  bool? alloyWheelDeliverd;
  bool? checkPic1;
  bool? checkPic2;
  bool? checkPic3;
  bool? checkPic4;
  bool? checkPic5;
  bool? checkPic6;
  bool? checkPic7;
  bool? checkPic8;
  bool? checkPic9;
  bool? checkPic10;
  bool? checkPic11;
  bool? checkPic12;
  bool? checkPic13;
  bool? checkPic14;
  bool? checkPic15;
  bool? checkPic16;
  String? checkedInPerson;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? comment1;
  String? comment2;
  String? comment3;
  String? comment4;
  String? comment5;
  String? comment6;
  String? addTime;

  CarReceiveH(
      {
        this.id,
        this.trxSerial,
        this.customerCode,
        this.carCode,
        this.receiveCarStatusCode,
        this.returnOldPartStatusCode,
        this.repeatRepairStatusCode,
        this.counter,
        this.customerMobile,
        this.netTotal,
        this.deliveryDate,
        this.deliveryTime,
        this.maintenanceClassificationCode,
        this.maintenanceTypeCode,
        this.paymentMethodCode,
        this.customerSignature,
        this.navMemoryCard,
        this.alloyWheelLock,
        this.usbDevice,
        this.navDeliverd,
        this.usbDeliverd,
        this.alloyWheelDeliverd,
        this.checkPic1,
        this.checkPic2,
        this.checkPic3,
        this.checkPic4,
        this.checkPic5,
        this.checkPic6,
        this.checkPic7,
        this.checkPic8,
        this.checkPic9,
        this.checkPic10,
        this.checkPic11,
        this.checkPic12,
        this.checkPic13,
        this.checkPic14,
        this.checkPic15,
        this.checkPic16,
        this.checkedInPerson,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.image5,
        this.image6,
        this.comment1,
        this.comment2,
        this.comment3,
        this.comment4,
        this.comment5,
        this.comment6,

      });
  factory CarReceiveH.fromJson(Map<String, dynamic> json){
    return CarReceiveH(
      id: (json['id'] != null) ? json['id'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      customerCode: (json['customerCode'] !=null) ? json['customerCode'] as String : "",
      carCode: (json['carCode'] != null) ? json['carCode'] as String : " ",
      receiveCarStatusCode: (json['receiveCarStatusCode'] != null) ? json['receiveCarStatusCode'] as String : " ",
      returnOldPartStatusCode: (json['returnOldPartStatusCode'] != null) ? json['returnOldPartStatusCode'] as int : 1,
      repeatRepairStatusCode: (json['repeatRepairStatusCode'] != null) ? json['repeatRepairStatusCode'] as int : 1,
      counter: (json['counter'] !=null) ? json['counter'] as String : "",
      customerMobile: (json['customerMobile'] != null) ? json['customerMobile'] as String : " ",
      netTotal: (json['netTotal'] != null) ? json['netTotal'] as int : 0,
      deliveryDate: (json['deliveryDate'] != null) ? json['deliveryDate'] as String : pickedDate,
      deliveryTime: (json['deliveryTime'] != null) ? json['deliveryTime'] as String : " ",
      maintenanceClassificationCode: (json['maintenanceClassificationCode'] != null) ? json['maintenanceClassificationCode'] as String : " ",
      maintenanceTypeCode: (json['maintenanceTypeCode'] != null) ? json['maintenanceTypeCode'] as String : " ",
      paymentMethodCode: (json['paymentMethodCode'] != null) ? json['paymentMethodCode'] as String : " ",
      customerSignature: (json['customerSignature'] != null) ? json['customerSignature'] as String : " ",
      navMemoryCard: (json['navMemoryCard'] != null) ? json['navMemoryCard'] as bool : true,
      alloyWheelLock: (json['alloyWheelLock'] != null) ? json['alloyWheelLock'] as bool : true,
      usbDevice: (json['usbDevice'] != null) ? json['usbDevice'] as bool : true,
      navDeliverd: (json['navDeliverd'] != null) ? json['navDeliverd'] as bool : true,
      usbDeliverd: (json['usbDeliverd'] != null) ? json['usbDeliverd'] as bool : true,
      alloyWheelDeliverd: (json['alloyWheelDeliverd'] != null) ? json['alloyWheelDeliverd'] as bool : true,
      checkPic1: (json['checkPic1'] != null) ? json['checkPic1'] as bool : true,
      checkPic2: (json['checkPic2'] != null) ? json['checkPic2'] as bool : true,
      checkPic3: (json['checkPic3'] != null) ? json['checkPic3'] as bool : true,
      checkPic4: (json['checkPic4'] != null) ? json['checkPic4'] as bool : true,
      checkPic5: (json['checkPic5'] != null) ? json['checkPic5'] as bool : true,
      checkPic6: (json['checkPic6'] != null) ? json['checkPic6'] as bool : true,
      checkPic7: (json['checkPic7'] != null) ? json['checkPic7'] as bool : true,
      checkPic8: (json['checkPic8'] != null) ? json['checkPic8'] as bool : true,
      checkPic9: (json['checkPic9'] != null) ? json['checkPic9'] as bool : true,
      checkPic10: (json['checkPic10'] != null) ? json['checkPic10'] as bool : true,
      checkPic11: (json['checkPic11'] != null) ? json['checkPic11'] as bool : true,
      checkPic12: (json['checkPic12'] != null) ? json['checkPic12'] as bool : true,
      checkPic13: (json['checkPic13'] != null) ? json['checkPic13'] as bool : true,
      checkPic14: (json['checkPic14'] != null) ? json['checkPic14'] as bool : true,
      checkPic15: (json['checkPic15'] != null) ? json['checkPic15'] as bool : true,
      checkPic16: (json['checkPic16'] != null) ? json['checkPic16'] as bool : true,
      checkedInPerson: (json['checkedInPerson'] != null) ? json['checkedInPerson'] as String : " ",
      image1: (json['image1'] != null) ? json['image1'] as String : " ",
      image2: (json['image2'] != null) ? json['image2'] as String : " ",
      image3: (json['image3'] != null) ? json['image3'] as String : " ",
      image4: (json['image4'] != null) ? json['image4'] as String : " ",
      image5: (json['image5'] != null) ? json['image5'] as String : " ",
      image6: (json['image6'] != null) ? json['image6'] as String : " ",
      comment1: (json['comment1'] != null) ? json['comment1'] as String : " ",
      comment2: (json['comment2'] != null) ? json['comment2'] as String : " ",
      comment3: (json['comment3'] != null) ? json['comment3'] as String : " ",
      comment4: (json['comment4'] != null) ? json['comment4'] as String : " ",
      comment5: (json['comment5'] != null) ? json['comment5'] as String : " ",
      comment6: (json['comment6'] != null) ? json['comment6'] as String : " ",

    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
