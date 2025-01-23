// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_e_commerce/core/controllers/file_upload_controller.dart';
import 'package:furniture_e_commerce/core/helper/alert_helper.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/model/user_model.dart';
import 'package:logger/logger.dart';

abstract class IAuthController {}

class AuthConroller {
  final _firebaseAuth = FirebaseAuth.instance;

// Sing up new users function
  Future<void> signupUser(BuildContext context, String email, String password,
      String userName) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((credential) {
        if (credential.user!.email != null) {
          Logger().w("User created successfully");
          // if success save the user data to firebase
          saveUserData(email, userName, credential.user!.uid);
        } else {
          Logger().w("User not created successfully");
        }
      });
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      AlertHelpers.showAlert(context, e.toString());
    }
  }

// create a collection reference called users
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// save extra user data to firebase
  Future<void> saveUserData(String email, String userName, String uid) async {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'userName': userName,
          'email': email,
          'img': AppAssets.profileUrl,
        })
        .then((value) => Logger().i("User Added to Firestore"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  // Login User Function
  Future<void> loginUser(
    BuildContext context,
    String loginEmail,
    String loginPassword,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: loginEmail,
        password: loginPassword,
      );
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      Logger().w(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }

  // send password reset Email Function (Forget password)
  Future<void> sendEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        AlertHelpers.showAlert(context, "Email sent to your inbox",
            type: DialogType.success);
      });
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  // Fetch userData from cloud firestore
  Future<UserModel?> fetchUserData(
    String uid,
  ) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();

      if (documentSnapshot.exists) {
        // Mapping fetch data to user model
        UserModel model =
            UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        Logger().d(model);
        return model;
      } else {
        Logger().e("No data found");
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  final FileUploadController _fileUploadController =
      locator<FileUploadController>();

  // // upload pick image file to the firebase storage bucket and update the user profile
  Future<String> uploadAndUpdateProfileImage(File file, String uid) async {
    try {
      // start uplaoding the file
      final String downloadUrl =
          await _fileUploadController.uploadFileToCloudinary(
        tempFilePath: file.path,
        uploadPreset: "userImages",
      );

      // check if the file is uploaded
      if (downloadUrl.isNotEmpty) {
        await users.doc(uid).update({
          "img": downloadUrl,
        });
        return downloadUrl;
      } else {
        Logger().w("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
