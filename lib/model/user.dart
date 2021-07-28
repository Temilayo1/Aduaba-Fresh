class Register {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;

  Register(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword});
}

class User {
  String userID;
  String firstName;
  String lastName;
  Null avatarUrl;
  String phoneNumber;
  String email;
  String token;
  String refreshTokenExpiration;

  User(
      {this.userID,
      this.firstName,
      this.lastName,
      this.avatarUrl,
      this.phoneNumber,
      this.email,
      this.token,
      this.refreshTokenExpiration});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    token = json['token'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['avatarUrl'] = this.avatarUrl;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['token'] = this.token;
    data['refreshTokenExpiration'] = this.refreshTokenExpiration;
    return data;
  }
}

// class User {
//   String userId;
//   String firstName;
//   String lastName;
//   String email;
//   String phoneNumber;
//   String img;
//   String token;
//   String renewalToken;
//
//   User(
//       {this.userId,
//       this.firstName,
//       this.lastName,
//       this.email,
//       this.phoneNumber,
//       this.img,
//       this.token,
//       this.renewalToken});
//
//   User copyWith(
//       {String userId,
//       String firstName,
//       String lastName,
//       String phoneNumber,
//       String email,
//       String img,
//       String token,
//       String renewalToken}) {
//     return User(
//         userId: userId ?? this.userId,
//         firstName: firstName ?? this.firstName,
//         lastName: lastName ?? this.lastName,
//         phoneNumber: phoneNumber ?? this.phoneNumber,
//         email: email ?? this.email,
//         img: img,
//         token: token ?? this.token,
//         renewalToken: renewalToken ?? this.renewalToken);
//   }
//
//   // now create converter
//
//   factory User.fromJson(Map<String, dynamic> responseData) {
//     return User(
//       userId: responseData['id'] as String,
//       firstName: responseData['firstName'] as String,
//       lastName: responseData['lastName'] as String,
//       email: responseData['Email'] as String,
//       img: responseData['avataUrl'] as String,
//       phoneNumber: responseData['phoneNumber'] as String,
//       token: responseData['token'] as String,
//       renewalToken: responseData['token'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.userId;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['email'] = this.email;
//     data['phoneNumber'] = this.phoneNumber;
//     return data;
//   }
// }
