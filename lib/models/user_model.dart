class UserRegisterModel {
  final String username;
  final String email;
  final String name;
  final String lastname;
  final String? password;
  final String? confirmPassword;

  UserRegisterModel({
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

  factory UserRegisterModel.fromMap(Map<String, dynamic> map) {
    return UserRegisterModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      lastname: map['lastname'] ?? '',
      password: map['password'],
      confirmPassword: map['confirmPassword'],
    );
  }
}

class UserSupabase {
  final String id;
  final String? role;
  final String email;
  final String? phone;
  final String? lastSignInAt;
  final String username;
  final String name;
  final String lastName;
  final DateTime? birthday;
  final String? profilePhoto;

  UserSupabase({
    required this.id,
    this.role,
    required this.email,
    this.phone,
    this.lastSignInAt,
    required this.username,
    required this.name,
    required this.lastName,
    this.birthday,
    this.profilePhoto,
  });

  factory UserSupabase.empty() {
    return UserSupabase(
      id: '',
      email: '',
      username: '',
      name: '',
      lastName: '',
    );
  }

  UserSupabase copyWith({
    String? id,
    String? role,
    String? email,
    String? phone,
    String? lastSignInAt,
    String? username,
    String? name,
    String? lastName,
    DateTime? birthday,
    String? profilePhoto,
  }) {
    return UserSupabase(
      id: id ?? this.id,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      username: username ?? this.username,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'email': email,
      'phone': phone,
      'lastSignInAt': lastSignInAt,
      'username': username,
      'name': name,
      'lastName': lastName,
      'birthday': birthday,
      'profilePhoto': profilePhoto,
    };
  }

  List<dynamic> toList() {
    return [
      id,
      role,
      email,
      phone,
      lastSignInAt,
      username,
      name,
      lastName,
      birthday,
      profilePhoto,
    ];
  }

  @override
  String toString() {
    return 'UserSupabase(id: $id, role: $role, email: $email, phone: $phone, lastSignInAt: $lastSignInAt, username: $username, name: $name, lastName: $lastName, birthday: $birthday, profilePhoto: $profilePhoto)';
  }
}
