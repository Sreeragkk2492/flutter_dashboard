import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageServices extends GetxService {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  static init() async {
    Get.put(StorageServices(), permanent: true);
  }

  Future<String> read(String key) async {
    final result = await storage.read(key: key);

    return result ?? "";
  }

  Future<String> write(String key, String? value) async {
    await storage.write(key: key, value: value);

    return value ?? "";
  }

  Future delete(String key) async {
    await storage.delete(key: key);
    
  }
}