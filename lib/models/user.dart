class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  int id;
  String email;
  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}
