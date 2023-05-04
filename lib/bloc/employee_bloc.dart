import '../models/employee_model.dart';
import 'dart:async';
import '../resources/employee_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  late StreamSubscription _employeeSubscription;

  EmployeeBloc({required this.employeeRepository})
      : super(EmployeeLoading()) {
    on<GetEmployee>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final employees = await employeeRepository.fetchEmployees();
        emit(EmployeeLoaded(employees: employees));
      } catch (e) {
        emit(EmployeeError(message: 'Failed to load. Please try again later.'));
      }
    });
  }
/*
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    yield EmployeeLoading();
    if (event is GetEmployee) {
      try {
        final employees = await employeeRepository.fetchEmployees();
        yield EmployeeLoaded(employees: employees);
      } catch (e) {
        yield EmployeeError(message: 'Failed to load. Please try again later.');
      }
    }
  }
*/

  @override
  Future<void> close() {
    _employeeSubscription.cancel();
    return super.close();
  }
}

