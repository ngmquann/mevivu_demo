class User {
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String phone;

  User({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      image: json["image"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "image": image,
      "phone": phone,
    };
  }
}
