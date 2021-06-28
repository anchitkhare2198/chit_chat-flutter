import 'package:chitchat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chitchat_flutter/screens/register_screen.dart';
import 'package:chitchat_flutter/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String email = '';
String password = '';
bool e_validate = false;
bool p_validate = false;
bool property = false;
bool showSpinner = false;

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   User currentUser = _auth.currentUser;
  //
  //   if (currentUser != null) {
  //     print('UID is ${currentUser.uid}');
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => ChatScreen()));
  //     });
  //   } else {
  //     print('Null');
  //   }
  // }

  void signInWithEmalPassword(String e, String p) async {
    final newUser =
        await _auth.signInWithEmailAndPassword(email: e, password: p);
    if (newUser != null) {
      showSpinner = false;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
        (route) => false,
      );
    }
  }

  // void checkUserError(String e) {
  //   showSpinner = false;
  //   if (e is PlatformException) {
  //     if (e.code == 'ERROR_WRONG_PASSWORD') {
  //       print('Wrong password');
  //     } else if (e.code == 'ERROR_INVALID_EMAIL') {
  //       print('Wrong Email');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo.png'),
                        height: 60.0,
                      ),
                    ),
                    // DefaultTextStyle(
                    //   style: TextStyle(
                    //     fontSize: 45.0,
                    //     fontWeight: FontWeight.w900,
                    //     color: Colors.black,
                    //   ),
                    //   child: AnimatedTextKit(
                    //     animatedTexts: [TypewriterAnimatedText('Chit Chat')],
                    //   ),
                    // ),
                    Text(
                      'Chit Chat',
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                MyTextField(
                  hint: 'Email',
                  result: 'email',
                  result_validate: e_validate,
                  obscure_text: false,
                  inputType: TextInputType.emailAddress,
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
                  height: 35.0,
                ),
                Material(
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
                            signInWithEmalPassword(email, password);
                          }
                        } catch (e) {
                          print('yo');
                        }
                      });
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return RegisterScreen();
                        //     },
                        //   ),
                        // );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: kprimarycolor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
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
