import 'package:flutter/material.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  var _initValue = {
    'userName': '',
    'email': '',
    'password': '',
  };
  var _authMode = AuthMode.Signup;
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Text('SignUp', style: Theme.of(context).textTheme.title),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 320 : 260),
                width: deviceSize.width * 0.75,
                child: Form(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'User Name'),
                      initialValue: _initValue['userName'],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a user name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _initValue['userName'] = value as String;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _initValue['email'] = value as String;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _initValue['password'] = value as String;
                      },
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        child: Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                        onPressed: _submit,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow[700]),
                        ),
                      ),
                    TextButton(
                        child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                        onPressed: _switchAuthMode,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.yellow[900]),
                        )),
                  ]),
                )))
          ]),
        ));
  }
}
