

class UserDetails {
  int custId;
  String fullName;
  String email;
  int phoneNo;
  String address;
  String password;
  //  String jwt;
  UserDetails(
      {this.custId,
      this.fullName,
      this.email,
      this.phoneNo,
      this.address,
      this.password});
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        custId: json['cust_id'],
        fullName: json['fullname'],
        email: json['email'],
        phoneNo: json['phoneno'],
        address: json['address'],
        password: json['password']);
  }
//   getDetails() async {
//     SharedPreferences store = await SharedPreferences.getInstance();
//     print("getting jwt from the device");
//       String token = store.getString('jwt');

// if(token!=null){
//     Map jwt = json.decode(
//         ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));
//     return UserDetails.fromJson(jwt);
//   }
//   return null;
//   }
}
