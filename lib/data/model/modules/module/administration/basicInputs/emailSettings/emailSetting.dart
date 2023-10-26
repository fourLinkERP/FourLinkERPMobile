

class EmailSetting {
  int? smtpPort ;
  String? emailSettingCode ;
  String?  emailSettingNameAra;
  String?  emailSettingNameEng;
  String?  smtpServer;
  String?  userDisplayName;
  String?  userName;
  String?  userPassword;
  bool  isEnableSsl;





  EmailSetting({
    this.smtpPort ,
    this.emailSettingCode ,
    this. emailSettingNameAra,
    this. emailSettingNameEng,
    this. smtpServer,
    this. userDisplayName,
    this. userName,
    this. userPassword,
    this.isEnableSsl=false

    //image
    });

  factory EmailSetting.fromJson(Map<String, dynamic> json) {
    return EmailSetting(

        smtpPort: (json['smtpPort'] != null) ? json['smtpPort'] as int : 0,

        emailSettingCode: (json['emailSettingCode'] != null ) ? json['emailSettingCode'] as String : "",
        emailSettingNameAra: (json['emailSettingNameAra'] != null ) ? json['emailSettingNameAra'] as String : "",
        emailSettingNameEng: (json['emailSettingNameEng'] != null ) ? json['emailSettingNameEng'] as String : "",
        smtpServer: (json['smtpServer'] != null ) ? json['smtpServer'] as String : "",
        userDisplayName: (json['userDisplayName'] != null ) ? json['userDisplayName'] as String : "",
        userName: (json['userName'] != null ) ? json['userName'] as String : "",
        userPassword: (json['userPassword'] != null ) ? json['userPassword'] as String : "",
        isEnableSsl: (json['isEnableSsl'] != null ) ? json['isEnableSsl'] as bool : false,

    );
  }

  @override
  String toString() {
    return 'Trans{ name: $emailSettingCode }';
  }
}






// Our demo EmailSettings

// List<EmailSetting> demoEmailSettinges = [
//   EmailSetting(
//       id: 1,
//       name: "Maadi - EmailSetting",
//       description: descriptionData
//   ),
//   EmailSetting(
//       id: 2,
//       name: "Tahrir - EmailSetting",
//       description: descriptionData
//   )
// ];

