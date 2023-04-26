import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/EmployeeBloc.dart';
import '../models/employee_model.dart';

class EmployeeBloc {
  final http.Client _httpClient;

  EmployeeBloc({required http.Client httpClient})
      : _httpClient = httpClient;

  StreamController<List<Employee>> _employeeStreamController =
      StreamController<List<Employee>>.broadcast();

  Stream<List<Employee>> get employeeStream =>
      _employeeStreamController.stream;

  void dispose() {
    _employeeStreamController.close();
  }

  Future<void> getEmployees() async {
    final response = await _httpClient.get(
        Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      final employees =
          jsonList.map((json) => Employee.fromJson(json)).toList();
      _employeeStreamController.add(employees);
    } else {
      throw Exception('Failed to load employees');
    }
  }
}