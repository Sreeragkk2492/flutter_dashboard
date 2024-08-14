import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageServices extends GetxService {
  late FlutterSecureStorage storage;

  StorageServices() {
    // Initialize with web-specific options
    storage = FlutterSecureStorage(
      webOptions: WebOptions(
        dbName: 'myDb',
        publicKey: 'some_public_key',
      ),
    );
  }

  static Future<void> init() async {
    await Get.putAsync(() async => StorageServices());
  }

  Future<String> read(String key) async {
    try {
      final result = await storage.read(key: key);
      return result ?? "";
    } catch (e) {
      print('Error reading from storage: $e');
      return "";
    }
  }

  Future<String> write(String key, String? value) async {
    try {
      await storage.write(key: key, value: value);
      return value ?? "";
    } catch (e) {
      print('Error writing to storage: $e');
      return "";
    }
  }

  Future<void> delete(String key) async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      print('Error deleting from storage: $e');
    }
  }
}