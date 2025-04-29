class UserLogin {
  final String? id;
  final String? password;
  final String? roles;
  final List<String>? pages;

  UserLogin({
    this.id,
    this.password,
    this.roles,
    this.pages,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      id: json['id'],
      password: json['password'],
      roles: json['roles'],
      pages: json['pages'] != null 
          ? List<String>.from(json['pages'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'roles': roles,
      'pages': pages,
    };
  }

  void forEach(void Function(String key, dynamic value) action) {
    toJson().forEach(action);
  }
}
