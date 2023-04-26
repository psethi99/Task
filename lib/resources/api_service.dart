import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/EmployeeBloc.dart';
import '../models/employee_model.dart';

class EmployeeBlocImpl implements EmployeeBloc {
  final http.Client _httpClient;

  EmployeeBlocImpl({required http.Client httpClient})
      : _httpClient = httpClient;

  @override
  Stream<List<Employee>> getEmployees() async* {
    final response = await _httpClient.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      final employees = jsonList.map((json) => Employee.fromJson(json)).toList();
      yield employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
