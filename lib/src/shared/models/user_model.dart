import 'dart:convert';

class UserModel {
  final String name;
  final String phone;
  final String email;
  final String cpf;
  final String birthday;
  final String password;
  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.cpf,
    required this.birthday,
    required this.password,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? cpf,
    String? birthday,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      birthday: birthday ?? this.birthday,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'cpf': cpf,
      'birthday': birthday,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      cpf: map['cpf'],
      birthday: map['birthday'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(name: $name,phone: $phone,email: $email,cpf: $cpf,birthday: $birthday, password: $password)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is UserModel && other.value == value;
  // }

  // @override
  // int get hashCode => value.hashCode;
}
