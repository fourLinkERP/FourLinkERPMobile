
String descriptionData="";
class Login {
  String? token ;
  String? refreshToken;
  String? refreshTokenExpiryTime;
  String? userCode;
  String? empCode;

  Login({this.token,
    this.refreshToken,
    this.refreshTokenExpiryTime,
    this.userCode,
    this.empCode,
    });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpiryTime: json['refreshTokenExpiryTime'] as String,
      userCode: json['userCode'] as String,
      empCode: json['empCode'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{token: $token, refreshToken: $refreshToken }';
  }
}






// Our demo Branchs

// List<Customer> demoBranches = [
//   Customer(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Customer(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

