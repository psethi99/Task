import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
//import '../models/EmployeeBloc.dart';
import '../models/employee_model.dart';

class EmployeeRepository {
  static const _baseUrl = 'http://dummy.restapiexample.com/api/v1';

  Future<dynamic> getEmployees() async {
    final response = await http.get(Uri.parse('$_baseUrl/employees'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

}