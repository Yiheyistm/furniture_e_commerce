// ignore_for_file: non_constant_identifier_names

import 'package:furniture_e_commerce/core/global/load_api.dart';

class Config {
  late final String apiKeyRemoveImageBackground;
  late final String apiNameRemoveImageBackgroun;
  late final String cloudName;
  late final String apiKey;
  late final String apiSecret;

  late final String chapa_api_key;

  Config() {
    loadApiKey().then((config) {
      apiKeyRemoveImageBackground = config['API_KEY_REMOVE_IMAGE_BACKGROUND'];
      apiNameRemoveImageBackgroun = config['API_NAME_REMOVE_IMAGE_BACKGROUND'];
      cloudName = config['CLOUD_NAME'];
      apiKey = config['API_KEY'];
      apiSecret = config['API_SECRET'];
      chapa_api_key = config['CHAPA_API_KEY'];
    });
  }
}
