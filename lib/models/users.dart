class User {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  User({
    required this.firstName, 
    required this.lastName, 
    required this.email, 
    required this.mobile});

  // Convert User object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
    };
  }

  // Convert Map object to a User object
  static User fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobile: map['mobile'],
    );
  }
}
