import 'package:chitchat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chitchat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'Register_Screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String email = '';
String password = '';
bool e_validate = false;
bool p_validate = false;
bool showSpinner = false;

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  void createUserWithEmailPassword(String e, String p) async {
    final newUser =
        await _auth.createUserWithEmailAndPassword(email: e, password: p);
    if (newUser != null) {
      showSpinner = false;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
        (route) => false,
      );
    }
  }

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
      body: ModalProgressHUD(
        color: kprimarycolor,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              MyTextField(
                hint: 'Email',
                result: 'email',
                result_validate: e_validate,
                inputType: TextInputType.emailAddress,
                obscure_text: false,
              ),
              SizedBox(
                height: 15.0,
              ),
              MyTextField(
                hint: 'Password',
                result: 'password',
                result_validate: p_validate,
                obscure_text: true,
              ),
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
                        showSpinner = true;
                        try {
                          email.isEmpty
                              ? e_validate = true
                              : e_validate = false;
                          password.isEmpty
                              ? p_validate = true
                              : p_validate = false;
                          if (e_validate || p_validate) {
                            print('Please enter fields.');
                            showSpinner = false;
                          } else {
                            print('Email is $email');
                            print('Password is $password');
                            createUserWithEmailPassword(email, password);
                          }
                        } catch (e) {
                          print(e);
                          showSpinner = false;
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
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    @required this.hint,
    @required this.result,
    @required this.result_validate,
    this.obscure_text,
    this.inputType,
  });
  final String hint;
  final String result;
  final bool result_validate;
  var obscure_text;
  var inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      cursorColor: Colors.black,
      obscureText: obscure_text,
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
