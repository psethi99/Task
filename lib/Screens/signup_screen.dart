import 'package:final_review/Screens/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/database_helper.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/img5.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('User Sign-Up'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical:20, horizontal: 25),
          child: Form(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/img2.png', height: 30),
                      Text(' Welcome User ', style: TextStyle(fontSize: 26)),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2),
                      labelText: 'First Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18.0),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Last Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18.0),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (!isValidMobileNumber(value)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // If form is valid, submit the data
                          submitData();
                        }
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 18),),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
    void submitData() async {
    // User Input
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final mobile = _mobileController.text;

    // TODO: Implement code to submit user data
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Email: $email');
    print('Mobile Number: $mobile');

    // Clearing the form fields 
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobileController.clear();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
    // If there is no internet connectivity, save the data to SQLite
    await DBHelper.insert('user', {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'is_upload': 0 // Set is_upload to 0 to indicate that the data has not been uploaded to Firebase yet
    });

    // Msg for local storage
    //ScaffoldMessenger.of(context).showSnackBar(
      //SnackBar(content: Text('User data saved to local storage'), backgroundColor: Colors.orange,),
    //);

    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    
  } 
  else {
    // If there is internet connectivity, send the data to Firebase
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'is_upload': 1 // Set is_upload to 1 to indicate that the data has been uploaded to Firebase
    });
  }

    // Display a msg on submitting the data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data submitted successfully'), backgroundColor: Colors.green,),
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  bool isValidEmail(String email) {
    // Check if the email is valid using a regular expression
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidMobileNumber(String mobile) {
    // Check if the mobile number is valid
    final mobileRegExp = RegExp(r'^\d{10}$');
    return mobileRegExp.hasMatch(mobile);
  }

}