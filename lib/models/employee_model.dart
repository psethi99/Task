class Employee {
  final int id;
  final String name;
  final int age;

  Employee({required this.id, required this.name, required this.age});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['employee_name'],
      age: json['employee_age'],
    );
  }
}
