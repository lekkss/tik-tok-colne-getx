import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/model/user.dart' as model;
import 'package:tik_tok/views/screens/auth/login_scren.dart';
import 'package:tik_tok/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User? get user => _user.value;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
  //Upload image

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          "Profile Picture", "You have sucessfully updated your profile photo");
    }
    _pickedImage = Rx<File?>(
      File(pickedImage!.path),
    );
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Rgister user
  Future<void> registerUser(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //Save out user to ath firebase and store
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
        );
        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          "Error Creating Account",
          "Please Enter all thr fields",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        debugPrint("log success");
      } else {
        Get.snackbar(
          "Error Logging in",
          "Please Enter all thr fields",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error logging in",
        e.toString(),
      );
    }
  }
}
