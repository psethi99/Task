class OnlineUser {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final bool isUpload;

  OnlineUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.isUpload});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'isUpload': isUpload ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'OnlineUser{firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, isUpload: $isUpload}';
  }
}

class OfflineUser {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final bool isUpload;

  OfflineUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.isUpload});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'isUpload': isUpload ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'OfflineUser{firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, isUpload: $isUpload}';
  }
}