import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/api_service.dart';
import '../models/employee_model.dart';


class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeBloc = EmployeeBlocImpl(httpClient: http.Client());

    return Scaffold(
      //appBar: AppBar(title: Text('Employees')),
      body: StreamBuilder<List<Employee>>(
        stream: employeeBloc.getEmployees(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('Age: ${employee.age}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
