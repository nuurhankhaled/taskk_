class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'mobile': mobile,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    mobile: json['mobile'],
  );
}
