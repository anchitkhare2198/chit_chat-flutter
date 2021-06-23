import 'package:flutter/material.dart';
import 'package:chitchat_flutter/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'Register_Screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String email = '';
String password = '';
bool e_validate = false;
bool p_validate = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            MyTextField(
                hint: 'Email', result: 'email', result_validate: e_validate),
            SizedBox(
              height: 15.0,
            ),
            MyTextField(
                hint: 'Password',
                result: 'password',
                result_validate: p_validate),
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: Material(
                color: kprimarycolor,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      email.isEmpty ? e_validate = true : e_validate = false;
                      password.isEmpty ? p_validate = true : p_validate = false;
                      if (e_validate || p_validate) {
                        print('Please enter fields.');
                      } else {
                        print('Email is $email');
                        print('Password is $password');
                        //Go to main screen after logging In.
                      }
                    });
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField(
      {@required this.hint,
      @required this.result,
      @required this.result_validate});
  final String hint;
  final String result;
  final bool result_validate;
  // final String inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(
          fontSize: 18.0,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //hintText: hint,
        //hintStyle: TextStyle(
        //fontSize: 18.0,
        //),
        errorText: result_validate ? 'This field cannot be empty.' : null,
      ),
      onChanged: (value) {
        if (result == 'email') {
          email = value;
        } else if (result == 'password') {
          password = value;
        }
      },
    );
  }
}