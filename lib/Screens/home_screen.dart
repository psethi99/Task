import 'package:final_review/Screens/tab_1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bloc/employee_bloc.dart';
import '../resources/employee_respository.dart';
import '../bloc/employee_event.dart';
import 'Online_users.dart';
import 'offline_users.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _employeeBloc = EmployeeBloc(
        employeeRepository: EmployeeRepository(), 
        //httpClient: http.Client()
        );
    _employeeBloc.add(GetEmployee());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _employeeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Employee Data', icon: Icon(Icons.group),),
            Tab(text: 'Online', icon: Icon(Icons.wifi),),
            Tab(text: 'Offline', icon: Icon(Icons.airplanemode_active),),
          ],
        ),
      ),
      body: BlocProvider<EmployeeBloc>.value (
        value: _employeeBloc,
        //create: (_) => EmployeeBloc(employeeRepository: EmployeeRepository()),
        child: TabBarView(
          controller: _tabController,
          children: [
            //Tab 1
            EmployeeList(employees: [],),
            // Tab 2
            OnlineUser(),
            // Tab 3
            OfflineUser(),
          ],
        ),
      ),
    );
  }
}
