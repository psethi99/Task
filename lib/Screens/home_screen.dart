import 'package:final_review/Screens/Offline_users.dart';
import 'package:final_review/Screens/Online_users.dart';
import 'package:final_review/Screens/tab_1.dart';
import 'package:flutter/material.dart';
import '../models/EmployeeBloc.dart';
import 'package:http/http.dart' as http;
//import '../resources/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late EmployeeBlocImpl employeeBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    employeeBloc = EmployeeBlocImpl(httpClient: http.Client());
  }

  @override
  void dispose() {
    _tabController.dispose();
    employeeBloc.dispose();
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
            Tab(text: 'API Data'),
            Tab(text: 'Online'),
            Tab(text: 'Offline'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Widgets for Tab 1
          EmployeeList(employeeBloc: employeeBloc),
          // Widgets for Tab 2
          OnlineUserList(),
          // Widgets for Tab 3
          OfflineUserList(),
        ],
      ),
    );
  }
}
