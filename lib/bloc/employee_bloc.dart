import '../models/employee_model.dart';
import '../resources/employee_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  final http.Client httpClient;
  EmployeeBloc({
    required this.employeeRepository,
    required this.httpClient}) : super(EmployeeInitial());

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    if (event is GetEmployee) {
      yield EmployeeLoading();
      try {
        final List<Employee> employees = await employeeRepository.getEmployees();
        yield EmployeeLoaded(employees: employees);
      } catch (e) {
        yield EmployeeError(message: e.toString());
      }
    }
  }
}
