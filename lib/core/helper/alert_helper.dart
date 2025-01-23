import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertHelpers {
  static AwesomeDialog? _awesomeDialog;

  /// shows a dialog
  
  static void showAlert(BuildContext context, String desc,
      {DialogType type = DialogType.error}) {
    _awesomeDialog = AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.rightSlide,
      title: type == DialogType.success ? "Success" : 'Error',
      desc: desc,
      btnCancelOnPress: () {
      
        _awesomeDialog?.dismiss(); // Dismiss the dialog
      },
      btnOkOnPress: () {
  
        _awesomeDialog?.dismiss(); // Dismiss the dialog
      },
    )..show();
  }
}
