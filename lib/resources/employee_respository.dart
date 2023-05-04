import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/employee_model.dart';

class EmployeeRepository {
  final String _baseUrl = 'http://dummy.restapiexample.com/api/v1';
  final http.Client _httpClient;

  EmployeeRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Employee>> fetchEmployees() async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/employees'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
