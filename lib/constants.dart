import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/viewmodel/auth_viewmodel.dart';
import 'package:tik_tok/views/screens/add_video_screen.dart';
import 'package:tik_tok/views/screens/profile_screen.dart';
import 'package:tik_tok/views/screens/search_screen.dart';
import 'package:tik_tok/views/screens/video_screen.dart';

List pages = [
  VideoScreen(),
  SearchSceen(),
  const AddVideoScreen(),
  const Text("Messages Screen"),
  ProfileScreen(
    uid: authControler.user!.uid,
  ),
];

//Colors
const backgrondColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//controller
var authControler = AuthController.instance;
