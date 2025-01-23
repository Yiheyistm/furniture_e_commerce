import 'dart:typed_data';
import 'package:furniture_e_commerce/core/global/config.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:http/http.dart' as http;

class ApiConsumer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    var requestApi = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));

    requestApi.files.add(
      await http.MultipartFile.fromPath(
        "image_file",
        imagePath,
      ),
    );
    Config config = locator<Config>();

    requestApi.headers
        .addAll({"X-API-Key": config.apiKeyRemoveImageBackground});

    final responseFromaApi = await requestApi.send();

    if (responseFromaApi.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(responseFromaApi);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception("Error Occured: ${responseFromaApi.statusCode}");
    }
  }
}
