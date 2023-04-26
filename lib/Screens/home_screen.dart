import 'package:final_review/Screens/tab_1.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          EmployeeList(),
          // Widgets for Tab 2
          Center(child: Text('Tab 2')),
          // Widgets for Tab 3
          Center(child: Text('Tab 3')),
        ],
      ),
    );
  }
}
