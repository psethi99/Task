class Employee {
  final int id;
  final String employeeName;
  final int employeeAge;
  final int employeeSalary;
  //final String imageUrl;

  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeAge,
    required this.employeeSalary,
    //required this.imageUrl,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeName: json['employee_name'],
      employeeAge: json['employee_age'],
      employeeSalary: json['employee_salary']
      //imageUrl: json['profile_image'],
    );
  }
}
