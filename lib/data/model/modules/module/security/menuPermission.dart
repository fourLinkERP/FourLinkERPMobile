

//import 'dart:core';

class MenuPermission {
  int? sysId;
  int? menuId;
  int? parentId;
  int? mainParentId;
  String?  formName;
  bool allowAdd;
  bool allowDelete;
  bool allowEdit;
  bool allowView;
  bool allowPrint;
  bool allowEmail;
  bool allowWhatsApp;
  bool allowExport;
  bool allowImport;
  bool allowCopy;
  bool allowDesign;

  // int? redColor;
  // int? greenColor;
  // int? blueColor;
  // int? groupId;
  // int? moduleTypeCode;
  // int? menuTypeId;
  // int? orderId;
  // int? active;
  // String? menuNameAra ;
  // String? menuNameEng ;
  // String?  menuName;

  // String?  formParameters;
  // String?  viewName;
  // String?  viewParameters;
  // String?  imageName;
  // String?  colorName;
  // String?  userId;
  // String?  groupNameAra;
  // String?  groupLatName;
  // String?  groupName;
  // String?  viewNameSearchTable;
  // String?  viewNameSearchField;
  // String?  viewNameSelectedFields;
  // String?  tabName;
  // String?  viewCaptionAra;
  // String?  viewCaptionEng;
  // String?  viewCaption;
  // String?  dynamicTransactionScreensTableName;
  // String?  parameter;
  // String?  shortCut;
  // bool blockModule;

  // bool isDraft;
  // bool isService;
  // bool isSynchronized;
  // bool noHavePermission;
  // bool isFavoriteMenu;
  // bool isMiniERP;
  // bool isUseYear;
  // bool isUseGeneralSerial;

  MenuPermission({
    this.sysId,
    this.menuId,
    this.parentId,
    this.mainParentId,
    this.formName,
    this.allowAdd=false,
    this.allowDelete=false,
    this.allowEdit=false,
    this.allowView=false,
    this.allowPrint=false,
    this.allowEmail=false,
    this.allowWhatsApp=false,
    this.allowExport=false,
    this.allowImport=false,
    this.allowCopy=false,
    this.allowDesign=false,

    // this.redColor,
    // this.greenColor,
    // this.blueColor,
    // this.userId,
    // this.groupId,
    // this.menuNameAra ,
    // this.menuNameEng ,
    // this.menuName,

    // this.formParameters,
    // this.viewName,
    // this.viewParameters,
    // this.imageName,
    // this.colorName,
    // this.moduleTypeCode,
    // this.menuTypeId,
    // this.orderId,
    // this.active,
    // this.groupNameAra,
    // this.groupLatName,
    // this.groupName,
    // this.viewNameSearchTable,
    // this.viewNameSearchField,
    // this.viewNameSelectedFields,
    // this.tabName,
    // this.viewCaptionAra,
    // this.viewCaptionEng,
    // this.viewCaption,
    // this.dynamicTransactionScreensTableName,
    // this.parameter,
    // this.shortCut,
    // this.blockModule=false,

    // this.isDraft=false,
    // this.isService=false,
    // this.isSynchronized=false,
    // this.noHavePermission=false,
    // this.isFavoriteMenu=false,
    // this.isMiniERP=false,
    // this.isUseYear =false,
    // this.isUseGeneralSerial=false,
  
    //image
    });

  factory MenuPermission.fromJson(Map<String, dynamic> json) {
    return MenuPermission(
    sysId: (json['sysId'] != null ) ? json['sysId'] as int : 0,
    menuId: (json['menuId'] != null ) ? json['menuId'] as int : 0,
    parentId: (json['parentId'] != null ) ? json['parentId'] as int : 0,
    mainParentId: (json['mainParentId'] != null ) ? json['mainParentId'] as int : 0,
    formName: (json['formName'] != null ) ? json['formName'] as String : "",
    allowAdd: (json['allowAdd'] != null ) ?json['allowAdd'] as bool :false ,
    allowDelete: (json['allowDelete'] != null ) ?json['allowDelete'] as bool :false ,
    allowEdit: (json['allowEdit'] != null ) ?json['allowEdit'] as bool :false ,
    allowView: (json['allowView'] != null ) ?json['allowView'] as bool :false ,
    allowPrint: (json['allowPrint'] != null ) ?json['allowPrint'] as bool :false ,
    allowEmail: (json['allowEmail'] != null ) ?json['allowEmail'] as bool :false ,
    allowWhatsApp: (json['allowWhatsApp'] != null ) ?json['allowWhatsApp'] as bool :false ,
    allowExport: (json['allowExport'] != null ) ?json['allowExport'] as bool :false ,
    allowImport: (json['allowImport'] != null ) ?json['allowImport'] as bool :false ,
    allowCopy: (json['allowCopy'] != null ) ?json['allowCopy'] as bool :false ,
    allowDesign: (json['allowDesign'] != null ) ?json['allowDesign'] as bool :false

    // redColor: (json['redColor'] != null ) ? json['redColor'] as int : 0,
    // greenColor: (json['greenColor'] != null ) ? json['greenColor'] as int : 0,
    // blueColor: (json['blueColor'] != null ) ? json['blueColor'] as int : 0,
    // groupId: (json['groupId'] != null ) ? json['groupId'] as int : 0,
    // moduleTypeCode: (json['moduleTypeCode'] != null ) ? json['moduleTypeCode'] as int : 0,
    // menuTypeId: (json['menuTypeId'] != null ) ? json['menuTypeId'] as int : 0,
    // orderId: (json['orderId'] != null ) ? json['orderId'] as int : 0,
    // active: (json['active'] != null ) ? json['active'] as int : 0,

    // menuNameAra: (json['menuNameAra'] != null ) ? json['menuNameAra'] as String : "",
    // menuNameEng: (json['menuNameEng'] != null ) ? json['menuNameEng'] as String : "",
    // menuName: (json['menuName'] != null ) ? json['menuName'] as String : "",

    // formParameters: (json['formParameters'] != null ) ? json['formParameters'] as String : "",
    // viewName: (json['viewName'] != null ) ? json['viewName'] as String : "",
    // viewParameters: (json['viewParameters'] != null ) ? json['viewParameters'] as String : "",
    // imageName: (json['imageName'] != null ) ? json['imageName'] as String : "",
    // colorName: (json['colorName'] != null ) ? json['colorName'] as String : "",
    // userId: (json['userId'] != null ) ? json['userId'] as String : "",
    // groupNameAra: (json['groupNameAra'] != null ) ? json['groupNameAra'] as String : "",
    // groupLatName: (json['groupLatName'] != null ) ? json['groupLatName'] as String : "",
    // groupName: (json['groupName'] != null ) ? json['groupName'] as String : "",
    // viewNameSearchTable: (json['viewNameSearchTable'] != null ) ? json['viewNameSearchTable'] as String : "",
    // viewNameSearchField: (json['viewNameSearchField'] != null ) ? json['viewNameSearchField'] as String : "",
    // viewNameSelectedFields: (json['viewNameSelectedFields'] != null ) ? json['viewNameSelectedFields'] as String : "",
    // tabName: (json['tabName'] != null ) ? json['tabName'] as String : "",
    // viewCaptionAra: (json['viewCaptionAra'] != null ) ? json['viewCaptionAra'] as String : "",
    // viewCaptionEng: (json['viewCaptionEng'] != null ) ? json['viewCaptionEng'] as String : "",
    // viewCaption: (json['viewCaption'] != null ) ? json['viewCaption'] as String : "",
    // dynamicTransactionScreensTableName: (json['dynamicTransactionScreensTableName'] != null ) ? json['dynamicTransactionScreensTableName'] as String : "",
    // parameter: (json['parameter'] != null ) ? json['parameter'] as String : "",
    // shortCut: (json['shortCut'] != null ) ? json['shortCut'] as String : "",

    //blockModule: (json['blockModule'] != null ) ?json['blockModule'] as bool :false ,

    // isDraft: (json['isDraft'] != null ) ?json['isDraft'] as bool :false ,
    // isService: (json['isService'] != null ) ?json['isService'] as bool :false ,
    // isSynchronized: (json['isSynchronized'] != null ) ?json['isSynchronized'] as bool :false ,
    // noHavePermission: (json['noHavePermission'] != null ) ?json['noHavePermission'] as bool :false ,
    // isFavoriteMenu: (json['isFavoriteMenu'] != null ) ?json['isFavoriteMenu'] as bool :false ,
    // isMiniERP: (json['isMiniERP'] != null ) ?json['isMiniERP'] as bool :false ,
    // isUseYear: (json['isUseYear'] != null ) ?json['isUseYear'] as bool :false ,
    // isUseGeneralSerial: (json['isUseGeneralSerial'] != null ) ?json['isUseGeneralSerial'] as bool :false ,


    );
  }

  @override
  String toString() {
    return 'Trans{ name: $formName }';
  }
}


