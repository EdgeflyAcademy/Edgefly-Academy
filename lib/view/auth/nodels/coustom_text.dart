class User {
  String name, email, password, phone, category, institution;

  User(
    this.name,
    this.email,
    this.password,
    this.phone,
    this.category,
    this.institution,
  );

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'category': category,
      'institution': institution,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['email'],
      map['password'],
      map['phone'],
      map['category'],
      map['institution'],
    );
  }
}
