import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OnlineUser extends StatefulWidget {
  const OnlineUser({super.key});

  @override
  _OnlineUserState createState() => _OnlineUserState();
}

Future<List<DocumentSnapshot>> getUserData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
  return querySnapshot.docs;
}

class _OnlineUserState extends State<OnlineUser> {
  List<DocumentSnapshot> userData = [];

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No internet connection'), backgroundColor: Colors.red,
      ));
    } else {
      getUserData().then((data) {
        setState(() {
          userData = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        child: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: Colors.greenAccent, width: 1),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: Text(userData[index]['first_name'] + ' ' + userData[index]['last_name'], style: TextStyle(fontSize: 18),),
                subtitle: Text(userData[index]['email'], style: TextStyle(fontSize: 15, color: Colors.black),),
                trailing: Text(userData[index]['mobile'], style: TextStyle(fontSize: 16),),
              ),
            );
          },
        ),
      ),
    );
  }
}
