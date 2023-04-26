class Employee {
  final int id;
  final String name;
  final int age;
  final String imageUrl;

  Employee({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrl,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['employee_name'],
      age: json['employee_age'],
      imageUrl: json['profile_image'],
    );
  }
}
