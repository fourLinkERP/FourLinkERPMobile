

class CompanyGeneralSetup {
  int? companyCode ;
  int? branchCode ;
  String? salesInvoicesTypeCode ;
  String?  salesInvoicesReturnTypeCode;
  String?  clubPlayerAccountTypeCode;
  String?  clubMemberAccountTypeCode;
  String?  clubRentUnitAccountTypeCode;
  String?  clubChaletAccountTypeCode;
  String?  clubLockerAccountTypeCode;
  String?  basicInputsVideoUrl;
  String?  transactionsVideoUrl;
  String?  reportsVideoUrl;
  int? basicInputsVideoMinutes ;
  int? transactionsVideoMinutes ;
  int? reportsVideoMinutes ;
  String?  basicInputsArabicDesc;
  String?  basicInputsEnglishDesc;
  String?  transactionsArabicDesc;
  String?  transactionsEnglishDesc;
  String?  reportsArabicDesc;
  String?  reportsEnglishDesc;





  CompanyGeneralSetup({
    this.companyCode,
    this.branchCode,
    this.salesInvoicesTypeCode,
    this. salesInvoicesReturnTypeCode,
    this. clubPlayerAccountTypeCode,
    this. clubMemberAccountTypeCode,
    this. clubRentUnitAccountTypeCode,
    this. clubChaletAccountTypeCode,
    this. clubLockerAccountTypeCode,
    this. basicInputsVideoUrl,
    this. transactionsVideoUrl,
    this. reportsVideoUrl,
    this.basicInputsVideoMinutes,
    this.transactionsVideoMinutes,
    this.reportsVideoMinutes,
    this. basicInputsArabicDesc,
    this. basicInputsEnglishDesc,
    this. transactionsArabicDesc,
    this. transactionsEnglishDesc,
    this. reportsArabicDesc,
    this. reportsEnglishDesc

    //image
    });

  factory CompanyGeneralSetup.fromJson(Map<String, dynamic> json) {
    return CompanyGeneralSetup(

      companyCode: (json['companyCode'] != null) ? json['companyCode'] as int : 0,
      branchCode: (json['branchCode'] != null) ? json['branchCode'] as int : 0,
      basicInputsVideoMinutes: (json['basicInputsVideoMinutes'] != null) ? json['basicInputsVideoMinutes'] as int : 0,
      transactionsVideoMinutes: (json['transactionsVideoMinutes'] != null) ? json['transactionsVideoMinutes'] as int : 0,
      reportsVideoMinutes: (json['reportsVideoMinutes'] != null) ? json['reportsVideoMinutes'] as int : 0,

        salesInvoicesTypeCode: (json['salesInvoicesTypeCode'] != null ) ? json['salesInvoicesTypeCode'] as String : "",
        salesInvoicesReturnTypeCode: (json['salesInvoicesReturnTypeCode'] != null ) ? json['salesInvoicesReturnTypeCode'] as String : "",
        clubPlayerAccountTypeCode: (json['clubPlayerAccountTypeCode'] != null ) ? json['clubPlayerAccountTypeCode'] as String : "",
        clubMemberAccountTypeCode: (json['clubMemberAccountTypeCode'] != null ) ? json['clubMemberAccountTypeCode'] as String : "",
        clubRentUnitAccountTypeCode: (json['clubRentUnitAccountTypeCode'] != null ) ? json['clubRentUnitAccountTypeCode'] as String : "",
        clubChaletAccountTypeCode: (json['clubChaletAccountTypeCode'] != null ) ? json['clubChaletAccountTypeCode'] as String : "",
        clubLockerAccountTypeCode: (json['clubLockerAccountTypeCode'] != null ) ? json['clubLockerAccountTypeCode'] as String : "",
        basicInputsVideoUrl: (json['basicInputsVideoUrl'] != null ) ? json['basicInputsVideoUrl'] as String : "",
        transactionsVideoUrl: (json['transactionsVideoUrl'] != null ) ? json['transactionsVideoUrl'] as String : "",
        reportsVideoUrl: (json['reportsVideoUrl'] != null ) ? json['reportsVideoUrl'] as String : "",
        basicInputsArabicDesc: (json['basicInputsArabicDesc'] != null ) ? json['basicInputsArabicDesc'] as String : "",
        basicInputsEnglishDesc: (json['basicInputsEnglishDesc'] != null ) ? json['basicInputsEnglishDesc'] as String : "",
        transactionsArabicDesc: (json['transactionsArabicDesc'] != null ) ? json['transactionsArabicDesc'] as String : "",
        transactionsEnglishDesc: (json['transactionsEnglishDesc'] != null ) ? json['transactionsEnglishDesc'] as String : "",
        reportsArabicDesc: (json['reportsArabicDesc'] != null ) ? json['reportsArabicDesc'] as String : "",
        reportsEnglishDesc: (json['reportsEnglishDesc'] != null ) ? json['reportsEnglishDesc'] as String : "",

    );
  }

  @override
  String toString() {
    return 'Trans{ name: $salesInvoicesTypeCode }';
  }
}






// Our demo CompanyGeneralSetups

// List<CompanyGeneralSetup> demoCompanyGeneralSetupes = [
//   CompanyGeneralSetup(
//       id: 1,
//       name: "Maadi - CompanyGeneralSetup",
//       description: descriptionData
//   ),
//   CompanyGeneralSetup(
//       id: 2,
//       name: "Tahrir - CompanyGeneralSetup",
//       description: descriptionData
//   )
// ];

