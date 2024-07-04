class DTO {
  static Map<String, String> page1 = {
    "trxSerial": "",
    "customerCode": "",
    "carCode": "",
    "checkedInPerson": "",
    "customerMobile": "",
    "counter": ""
  };

  static int netTotal = 0; //page2
  static Map<String, bool> page3 = {
    "checkMemory": false,
    "checkUsb": false,
    "checkAlloyWheelLock": false,
    "checkMemoryDelivery": false,
    "checkUsbDelivery": false,
    "checkAlloyWheelLockDelivery": false,
    "checkPic1": false,
    "checkPic2": false,
    "checkPic3": false,
    "checkPic4": false,
    "checkPic5": false,
    "checkPic7": false,
    "checkPic8": false,
    "checkPic9": false,
    "checkPic10": false,
    "checkPic11": false,
    "checkPic12": false,
    "checkPic13": false,
    "checkPic14": false,
    "checkPic15": false,
    "checkPic16": false,

  };

  static Map<String, String> page4Images = {
    "image1": "",
    "image2": "",
    "image3": "",
    "image4": "",
    "image5": "",
    "image6": "",
  };
  static Map<String, String> page4Comments = {
    "comment1": "",
    "comment2": "",
    "comment3": "",
    "comment4": "",
    "comment5": "",
    "comment6": "",
  };
  static Map<String, String> page5 = {
    "paymentMethodCode": "",
    "maintenanceClassificationCode": "",
    "maintenanceTypeCode": "",
    "deliveryDate": "",
    "deliveryTime": "",
    "returnOldPartStatusCode": "", // parse to int
    "repeatRepairsStatusCode": "", //parse to int
  };
}