import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoaded({required this.employees});

  @override
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError({required this.message});

  @override
  List<Object> get props => [message];
}
