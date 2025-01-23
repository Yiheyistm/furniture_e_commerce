import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  bool hasData(String key) {
    return _box.hasData(key);
  }

  void setData(String key, dynamic value) {
    _box.write(key, value);
  }

  dynamic getData(String key) {
    return _box.read(key);
  }

  void removeData(String key) {
    _box.remove(key);
  }

  void eraseData() {
    _box.erase();
  }
  List<dynamic>? getListData(String key){
     return _box.read<List>(key);
  }
bool writeIfNull(String key, dynamic value) {
    if (!hasData(key)) {
      setData(key, value);
      return true;
    }
    return false;
  }
  
}
