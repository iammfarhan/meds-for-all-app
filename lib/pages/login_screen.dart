// ignore_for_file: missing_return
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email, password;
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
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                      image: AssetImage('assets/images/AppLogo.png'),
                      width: 220,
                      height: 220),
                ],
              ),
              const Text('Welcome!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailTextController,
                          obscureText: false,
                          enableSuggestions: true,
                          autocorrect: !false,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: Color(0xffA7E92F), width: 2)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 15, 15, 15),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.mail),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: Color(0xffA7E92F), width: 2))),
                          // onSaved: (newValue) => email = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                errors.contains('kEmailNullError')) {
                              removeError(error: 'kEmailNullError');
                            } else if (value.isNotEmpty) {
                              addError(error: 'kInvalidEmailError');
                              return null;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: 'kEmailNullError');
                              removeError(error: 'kInvalidEmailError');
                              return 'Email is required!';
                            } else if (value.isNotEmpty) {
                              addError(error: 'kInvalidEmailError');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(fontSize: 14),
                          controller: passwordTextController,
                          obscureText: true,
                          enableSuggestions: !true,
                          autocorrect: !true,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: Color(0xffA7E92F), width: 2)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 15, 15, 15),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: Color(0xffA7E92F), width: 2))),

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
                                if (_formKey.currentState!.validate()) {
                                  signin();
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color(0xffA7E92F),
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: const BorderSide(
                                            color: Color(0xffA7E92F),
                                          ))))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        "Not a Member yet?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        child: const Text('SignUp here',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/reset');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text)
          .then((value) => Navigator.pushReplacementNamed(context, '/home'));
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            elevation: 1,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 150),
            content: Text(
              "No record found.",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.message == 'The email address is badly formatted.') {
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
              "Invalid password.",
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
