import '../models/employee_model.dart';
abstract class EmployeeBloc {
  Stream<List<Employee>> getEmployees();
}