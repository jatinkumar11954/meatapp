
class Address {
  String value;

  Address({this.value});
  factory Address.fromJson(Map<dynamic, dynamic> json) {
    return Address(value: json["newaddress"]);
  }
}
