// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_e_commerce/core/controllers/auth_controller.dart';
import 'package:furniture_e_commerce/core/helper/alert_helper.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class MyAuthProvider extends ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final AuthConroller _authConroller = locator<AuthConroller>();
  // password textfiled controller
  final TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  // Re-entered password textfield controller
  final TextEditingController _reEnterPassword = TextEditingController();

  TextEditingController get reEnterPassword => _reEnterPassword;

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  TextEditingController get oldPassword => _oldPassword;
  TextEditingController get newPassword => _newPassword;

  // Loader state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // set loader state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Start the signup process
  Future<void> startSignup({
    required BuildContext context,
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      // start the loader
      setLoading(true);
      // start creating the user
      await _authConroller
          .signupUser(context, email, password, userName)
          .then((value) {
        startFetchUserData(context);
        setLoading(false);
      });
    } catch (e) {
      Logger().w(e);
      setLoading(false);
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  // sign out function
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Start the login process
  Future<void> startLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);

      await _authConroller.loginUser(context, email, password).then((value) {
        startFetchUserData(context);
        setLoading(false);
      });
    } catch (e) {
      Logger().w(e);
      setLoading(false);
      Fluttertoast.showToast(msg: e.toString());

      AlertHelpers.showAlert(context, e.toString());
    }
  }

  //  Reset User Password Function

  final TextEditingController _resetEmail = TextEditingController();

  TextEditingController get resetEmail => _resetEmail;

  // Start the login process
  Future<void> sendPasswordResetEmail(
      {required BuildContext context, required String resetEmail}) async {
    try {
      // validate the input
      if (_resetEmail.text.isNotEmpty) {
        // start the loader
        setLoading(true);
        // start creating the user
        await _authConroller.sendEmail(context, resetEmail).then((value) {
          setLoading(false);
        });
      }
    } catch (e) {
      Logger().w(e);
      setLoading(false);
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  // userModel object to store the user data
  UserModel _userModel = locator<UserModel>();
  UserModel get userModel => _userModel;

  // start fetch user data data
  Future<void> startFetchUserData(BuildContext context) async {
    try {
      User user = _authConroller.getCurrentUser();
      await _authConroller.fetchUserData(user.uid).then((value) {
        if (value != null) {
          _userModel = value;
          notifyListeners();
        } else {
          AlertHelpers.showAlert(context, "User not found");
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  // Pick image from uplaod and update the user profile
  final ImagePicker picker = ImagePicker();

  // file object
  File _image = File("");
  File get image => _image;

  Future<void> selectImage(BuildContext context) async {
    try {
      // Pick an image.
      final XFile? pickFile =
          await picker.pickImage(source: ImageSource.gallery);
      Logger().i(pickFile?.path);

      if (pickFile != null) {
        _image = File(pickFile.path);
        notifyListeners();

        setLoading(true);

        // start uploading the image
        final imageUrl = await _authConroller.uploadAndUpdateProfileImage(
            _image, _userModel.uid);

        if (imageUrl.isNotEmpty) {
          _image = File("");

          _userModel.img = imageUrl;
          notifyListeners();
          setLoading(false);
        } else {
          AlertHelpers.showAlert(context, "error uploading the image");
        }
      } else {
        Logger().w("Image not selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  // Update user profile (username and email)
  Future<void> updateUserProfile(
      BuildContext context, String newUserName) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      setLoading(true);

      // Update username and email in FirebaseAuth
      // await user?.updatePassword(newPassword);
      await user?.updateDisplayName(newUserName);

      // Update in Firestore
      await users.doc(user?.uid).update({
        'userName': newUserName,
        //  'password': newPassword,
      });

      // Update the local user model
      _userModel.userName = newUserName;
      // _userModel!.password = newPassword;
      notifyListeners();

      setLoading(false);
      AlertHelpers.showAlert(context, "Profile updated successfully",
          type: DialogType.success);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      AlertHelpers.showAlert(context, e.message ?? "An error occurred");
    }
  }

  // Validate if passwords match
  bool validatePasswords(BuildContext context) {
    if (_password.text != _reEnterPassword.text) {
      Logger().w("Passwords do not match");
      AlertHelpers.showAlert(context, "Passwords do not match");
      return false;
    }
    return true;
  }

  Future<void> resetPassword(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    // Create credential with old password
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!, password: _oldPassword.text);

    try {
      // Reauthenticate user with old password
      await user.reauthenticateWithCredential(credential).then((_) async {
        // If reauthentication is successful, update to the new password
        await user.updatePassword(_newPassword.text);
        Logger().i("Password updated successfully");

        // Clear the password controllers
        _oldPassword.clear();
        _newPassword.clear();
        AlertHelpers.showAlert(context, "Password updated successfully",
            type: DialogType.success);
      });
    } on FirebaseAuthException catch (e) {
      Logger().e("Error updating password: ${e.message}");
      AlertHelpers.showAlert(
          context, e.message ?? "An error occurred during password update");
    }
  }
}
