// To parse this JSON data, do
//
//     final Customer = CustomerFromJson(jsonString);
import 'dart:convert';


List<Customer> CustomerFromJson(data) {
  var a = List<Customer>.from(json.decode(data).map((x) => Customer.fromJson(x)));
  return a;
}

String CustomerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.id = "",
    this.identification = "",
    this.names = "",
    this.surnames = "",
    this.email = "",
    this.cellPhone = "",
    this.weight = "0",
    this.tall = "0",
    this.plan,
    this.user
  });

  String id;
  String identification;
  String names;
  String surnames;
  String email;
  String cellPhone;
  String weight;
  String tall;
  Plan? plan;
  CustomerUser? user;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    identification: json["identification"],
    names: json["names"],
    surnames: json["surnames"],
    email: json["email"],
    cellPhone: json["cellPhone"],
    weight: json["weight"].toString(),
    tall: json["tall"].toString(),
    plan: Plan.fromJson(json["plan"]),
    user: CustomerUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "names": names,
    "surnames": surnames,
    "email": email,
    "cellPhone": cellPhone,
    "weight": weight,
    "tall": tall,
    "plan": plan?.toJson(),
  };
}

class Plan {
  Plan({
    this.id = "",
    this.name = "",
    this.duration = "0",
  });

  String id;
  String name;
  String duration;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    name: json["name"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "duration": duration,
  };
}

class CustomerUser {
  String userName;
  String password;

  CustomerUser({
    this.userName = "",
    this.password = "",
  });

  factory CustomerUser.fromJson(Map<String, dynamic> json) => CustomerUser(
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password
    };
  }
}
