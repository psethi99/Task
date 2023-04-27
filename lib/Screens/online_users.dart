import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineUser extends StatefulWidget {
  const OnlineUser({super.key});

  @override
  _OnlineUserState createState() => _OnlineUserState();
}

Future<List<DocumentSnapshot>> getUserData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  return querySnapshot.docs;
}

class _OnlineUserState extends State<OnlineUser> {
  List<DocumentSnapshot> userData = [];

  @override
  void initState() {
    super.initState();
    getUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(userData[index]['first_name'] + ' ' + userData[index]['last_name']),
              subtitle: Text(userData[index]['email']),
              trailing: Text(userData[index]['mobile']),
            );
          },
        ),
      ),
    );
  }
}