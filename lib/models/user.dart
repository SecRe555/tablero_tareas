class UserModel {
  final String username;
  final String email;
  final String name;
  final String lastname;
  final String? password;
  final String? confirmPassword;

  UserModel({
    required this.username,
    required this.email,
    required this.name,
    required this.lastname,
    this.password,
    this.confirmPassword,
  });

  @override
  String toString() {
    return 'User(username: $username, email: $email, name: $name, lastname: $lastname, password: ${password != null ? "***" : "null"}, confirmPassword: ${confirmPassword != null ? "***" : "null"})';
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'lastname': lastname,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  List<dynamic> toList() {
    return [username, email, name, lastname, password, confirmPassword];
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      lastname: map['lastname'] ?? '',
      password: map['password'],
      confirmPassword: map['confirmPassword'],
    );
  }
}
