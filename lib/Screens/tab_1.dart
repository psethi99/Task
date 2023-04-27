import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_review/models/employee_model.dart';
import 'package:final_review/bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';

class EmployeeList extends StatefulWidget {
  final List<Employee> employees;
  EmployeeList({required this.employees});

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late final EmployeeBloc _employeeBloc;

  @override
  void initState() {
    super.initState();
    _employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    _employeeBloc.add(GetEmployee());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } 
        else if (state is EmployeeLoaded) {
          return ListView.builder(
            itemCount: state.employees.length,
            itemBuilder: (context, index) {
              final employee = state.employees[index];
              return ListTile(
                title: Text('ID: ${employee.id}   Name: ${employee.employeeName}'),
                subtitle: Text('Salary: ${employee.employeeSalary}   Age: ${employee.employeeAge}'),
              );
            },
          );
        }
        else if (state is EmployeeError) {
          return Center(
            child: Text(state.message),
          );
        }
        else {
          return const SizedBox.shrink();
        } 
      },
    );
  }

  @override
  void dispose() {
    _employeeBloc.close();
    super.dispose();
  }
}
