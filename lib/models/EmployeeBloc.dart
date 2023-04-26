import '../models/employee_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_review/models/employee_model.dart';

abstract class EmployeeBloc1 {
  Stream<List<Employee>> getEmployees();
}

class EmployeeBlocImpl implements EmployeeBloc1 {
  final http.Client _httpClient;
  late StreamController<List<Employee>> _employeeController;

  EmployeeBlocImpl({required http.Client httpClient})
      : _httpClient = httpClient {
    _employeeController = StreamController<List<Employee>>.broadcast();
  }

  @override
  Stream<List<Employee>> getEmployees() async* {
    try {
      final response = await _httpClient.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
      if (response.statusCode == 200) {
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        final employees = jsonList.map((json) => Employee.fromJson(json)).toList();
        _employeeController.sink.add(employees);
        yield employees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      _employeeController.addError(e);
    }
  }

  void dispose() {
    _employeeController.close();
  }
}
