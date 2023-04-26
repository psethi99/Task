import 'package:final_review/resources/api_service.dart';

import '../models/employee_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_review/models/employee_model.dart';

abstract class EmployeeBloc {
  Stream<List<Employee>> getEmployees();
  void dispose();
}

class EmployeeBlocImpl implements EmployeeBloc {
  final http.Client httpClient;
  //late StreamController<List<Employee>> _employeeController;

  EmployeeBlocImpl({required this.httpClient });

  @override
  Stream<List<Employee>> getEmployees() async* {
    try {
      final data = await ApiService.get('/employees');
      final List<Employee> employees = (data['data'] as List)
          .map((e) => Employee.fromJson(e))
          .toList();
      yield employees;
    } catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  void dispose() {}
}

