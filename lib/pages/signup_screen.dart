// ignore_for_file: missing_return

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email, password, usersname;
  bool remember = false;
  final List<String> errors = [];
// func with named parameter
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/images/AppLogo1.png'),
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Signup here!',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userNameTextController,
                            obscureText: false,
                            enableSuggestions: !false,
                            autocorrect: !false,
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: Color(0xff8C52FF), width: 2),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 15, 15, 15),
                                labelText: 'Username',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: Color(0xff8C52FF), width: 2))),
                            // onSaved: (newValue) => usersname = newValue,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Username is required!';
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailTextController,
                            obscureText: false,
                            enableSuggestions: !false,
                            autocorrect: !false,
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                    color: Color(0xff8C52FF), width: 2),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 15, 15, 15),
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff8C52FF),
                                  width: 2,
                                ),
                              ),
                            ),
                            // onSaved: (newValue) => email = newValue,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required!';
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordTextController,
                            obscureText: true,
                            enableSuggestions: !true,
                            autocorrect: !true,
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                    color: Color(0xff8C52FF), width: 2),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 15, 15, 15),
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff8C52FF),
                                  width: 2,
                                ),
                              ),
                            ),
                            // onSaved: (newValue) => password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty &&
                                  errors.contains('kPassNullError')) {
                                removeError(error: 'kPassNullError');
                              } else if (value.length >= 6) {
                                removeError(error: 'kShortPassError');
                              }
                              // In case a user removed some characters below the threshold, show alert
                              else if (value.length < 6 && value.isNotEmpty) {
                                addError(error: 'kShortPassError');
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                addError(error: 'kPassNullError');
                                removeError(error: 'kShortPassError');
                                return 'Password is required!';
                              } else if (value.length < 6 && value.isNotEmpty) {
                                addError(error: 'kShortPassError');
                                return 'Password must be 6 or > 6 digits.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                signup();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xff8C52FF)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                      color: Color(0xff8C52FF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a member?"),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: const Text(
                              'Login here',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff8C52FF),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text)
          .then(
        (value) {
          FocusScope.of(context).unfocus();
          Navigator.pushReplacementNamed(context, '/login');
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.message == 'The email address is badly formatted.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            elevation: 1,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 150),
            content: Text(
              "Invalid E-mail Format.",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.message ==
          'The email address is already in use by another account.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            elevation: 1,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 150),
            content: Text(
              "Account already exist.",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.message == 'Given String is empty or null.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            elevation: 1,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 150),
            content: Text(
              "Invalid e-mail Format.",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.message ==
          'The password is invalid or the user does not have a password.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            elevation: 1,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 150),
            content: Text(
              "Account already exist!",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
      print(e.toString());
    }
  }
}
