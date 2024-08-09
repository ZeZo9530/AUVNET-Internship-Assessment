import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:store_app/cubits/auth/auth_cubit.dart';
import 'package:store_app/widgets/user_image.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _isAuth = false;
  File? _selectedImage;
  Box userBox = Hive.box('LoginData');

  @override
  void initState() {
    super.initState();
    _isLoggedin();
  }

  void _isLoggedin() {
    if (userBox.get('email') != null) {
      String email = userBox.get('email');
      String password = userBox.get('password');
      BlocProvider.of<AuthCubit>(context)
          .login(enteredEmail: email, enteredPassword: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: 200,
              height: 50,
              child: const Text(
                'AUVNET Store',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthToggle) {
                  setState(() {
                    _isLogin = state.isLogin;
                  });
                }
                if (state is AuthLoading) {
                  setState(() {
                    _isAuth = true;
                  });
                }
                if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                  ));
                  setState(() {
                    _isAuth = false;
                  });
                }
                if (state is LoginSuccess || state is SignupSuccess) {
                  Navigator.of(context).pushReplacementNamed('homeScreen');
                }
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLogin)
                              UserImagePicker(
                                onPicked: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
                            if (!_isLogin)
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Username"),
                                validator: (value) =>
                                    value!.isEmpty || value.length < 4
                                        ? "Please enter a username"
                                        : null,
                                onSaved: (value) {
                                  _enteredUsername = value!;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Email Address"),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (_isAuth) const CircularProgressIndicator(),
                            if (!_isAuth)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: () {
                                  final isValid =
                                      _formKey.currentState!.validate();

                                  if (!_isLogin) {
                                    if (!isValid || _selectedImage == null) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    BlocProvider.of<AuthCubit>(context).signup(
                                        enteredEmail: _enteredEmail,
                                        enteredPassword: _enteredPassword,
                                        enteredUsername: _enteredUsername,
                                        selectedImage: _selectedImage);
                                  } else {
                                    if (!isValid) {
                                      return;
                                    }
                                    _formKey.currentState!.save();

                                    BlocProvider.of<AuthCubit>(context).login(
                                        enteredEmail: _enteredEmail,
                                        enteredPassword: _enteredPassword);
                                  }
                                },
                                child: Text(_isLogin ? "Login" : "Sign up"),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!_isAuth)
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .toggleAuthMode();
                                },
                                child: Text(_isLogin
                                    ? "Create new account"
                                    : "I already have an account"),
                              )
                          ],
                        )),
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
