import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isLogin = true;
  Box userBox = Hive.box('LoginData');
  void toggleAuthMode() {
    isLogin = !isLogin;
    emit(AuthToggle(isLogin: isLogin));
  }

  Future<void> login(
      {required String enteredEmail, required String enteredPassword}) async {
    emit(AuthLoading());

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: enteredEmail, password: enteredPassword);
      print(userCredential);
      emit(LoginSuccess());
      userBox.put('email', enteredEmail);
      userBox.put('password', enteredPassword);
    } on FirebaseAuthException catch (error) {
      emit(AuthFailed(error: error.message ?? 'Authentication failed'));
    }
  }

  Future<void> signup(
      {required String enteredEmail,
      required String enteredPassword,
      required String enteredUsername,
      required File? selectedImage}) async {
    emit(AuthLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: enteredEmail, password: enteredPassword);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("user_image")
          .child("${userCredential.user!.uid}.jpg");
      await storageRef.putFile(selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        'username': enteredUsername,
        'email': enteredEmail,
        'imageUrl': imageUrl
      });
      emit(SignupSuccess());
    } on FirebaseAuthException catch (error) {
      emit(AuthFailed(error: error.message ?? 'Authentication failed'));
    }
  }
}
