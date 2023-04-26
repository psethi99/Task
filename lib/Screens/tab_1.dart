import 'dart:async';
import 'package:flutter/material.dart';
import 'package:final_review/models/employee_model.dart';
import 'package:final_review/models/EmployeeBloc.dart';
import 'package:http/http.dart' as http;

class EmployeeList extends StatefulWidget {
  EmployeeList({Key? key, required this.employeeBloc}) : super(key: key);
  final EmployeeBloc employeeBloc;

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late StreamSubscription _subscription;
  //final _bloc = EmployeeBlocImpl(httpClient: http.Client());

  @override
  void initState() {
    super.initState(); 
    _subscription = widget.employeeBloc.getEmployees().listen((employees) {
      // handle new data
    }, onError: (error) {
      // handle error
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Employee>>(
      stream: widget.employeeBloc.getEmployees(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final employees = snapshot.data!;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return ListTile(
                title: Text('ID: ${employee.id}   Name: ${employee.employeeName} '),
                subtitle: Text('Salary: ${employee.employeeSalary}   Age: ${employee.employeeAge}')
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
