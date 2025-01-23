import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'package:furniture_e_commerce/core/features/main/services/api_consumer.dart';
import 'package:furniture_e_commerce/core/global/config.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';

class FileUploadController {
  final Config _config = locator<Config>();

  Future<String> uploadFileToCloudinary(
      {required String tempFilePath, required String uploadPreset}) async {
    Logger().i(
        "uploadFileToCloudinary {tempFilePath: $tempFilePath, uploadPreset: $uploadPreset}");
    try {
      final String uploadUrl =
          "https://api.cloudinary.com/v1_1/${_config.cloudName}/image/upload";

      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['api_key'] = _config.apiKey
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', tempFilePath));

      final response = await request.send();
      Logger().i("uploadFileToCloudinary {response: ${response.statusCode}}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        return responseData['secure_url'];
      } else {
        Fluttertoast.showToast(msg: "Upload Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Logger().e(e);
    }
    return "";
  }

  Future<Uint8List> chooseImageSource(ImageSource source, context, Function(String)? onDone) async {
    Navigator.pop(context);
    Uint8List? imageFileUint8List;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();
        onDone!(imagePath);
        imageFileUint8List =
            await ApiConsumer().removeImageBackgroundApi(imagePath);

        return imageFileUint8List;
      }
    } catch (errorMsg) {
      print(
        errorMsg.toString(),
      );
      Fluttertoast.showToast(msg: errorMsg.toString());
    }
    return imageFileUint8List!;
  }

  Future<String?> saveToTemporaryFile(Uint8List imageBytes) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);
    return file.path;
  }
}
