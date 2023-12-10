class MyUser {
  static const String collectionName = 'users';
  String id;
  String password;

  MyUser(
      {required this.id,
        required this.password});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'] as String,
      password: json['password'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': password
    };
  }
}
