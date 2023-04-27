import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OfflineUser extends StatefulWidget {
  @override
  _OfflineUserState createState() => _OfflineUserState();
}

class _OfflineUserState extends State<OfflineUser> {
  List<Map<String, dynamic>> _sqliteData = [];

  @override
  void initState() {
    super.initState();
    _fetchSQLiteData();
  }

  void _fetchSQLiteData() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
    );
    final List<Map<String, dynamic>> sqliteData = await db.query('user');
    setState(() {
      _sqliteData = sqliteData;
    });
  }

  Future<void> _syncData(BuildContext context) async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Send data to Firebase
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      for (Map<String, dynamic> data in _sqliteData) {
        usersCollection.add({
          'first_name': data['first_name'],
          'last_name': data['last_name'],
          'email': data['email'],
          'mobile': data['mobile'],
        });
      }
      // Offline Data sync msg
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data synced successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } 
    else {
      // No internet Connectivity msg
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _sqliteData.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> data = _sqliteData[index];
                return ListTile(
                  title: Text(_sqliteData[index]['first_name'] + ' ' + _sqliteData[index]['last_name']),
                  subtitle: Text(_sqliteData[index]['email']),
                  trailing: Text(_sqliteData[index]['mobile']),
                );
              },
            ),
          ),
          _buildSyncButton(context),
        ],
      ),
    );
  }

  Widget _buildSyncButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _syncData(context),
      icon: const Icon(Icons.sync),
      label: Text('Sync'),
    );
  }
}
