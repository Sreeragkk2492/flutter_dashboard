import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class StorageServices extends GetxService {
  late SharedPreferences? _prefs;
  final _isInitialized = false.obs;
  final _isWeb = GetPlatform.isWeb;

  StorageServices();

  static Future<StorageServices> init() async {
    final service = StorageServices();
    await service._initStorage();
    return service;
  }

  Future<void> _initStorage() async {
    try {
      if (_isWeb) {
        _isInitialized.value = true;
      } else {
        _prefs = await SharedPreferences.getInstance();
        _isInitialized.value = true;
      }
    } catch (e) {
      print('Error initializing storage: $e');
    }
  }

  Future<String> read(String key) async {
    if (!_isInitialized.value) {
      print('StorageServices not initialized. Initializing now...');
      await _initStorage();
    }
    try {
      if (_isWeb) {
        return html.window.localStorage[key] ?? "";
      } else {
        return _prefs?.getString(key) ?? "";
      }
    } catch (e) {
      print('Error reading from storage: $e');
      return "";
    }
  }

  Future<bool> write(String key, String? value) async {
    if (!_isInitialized.value) {
      print('StorageServices not initialized. Initializing now...');
      await _initStorage();
    }
    try {
      if (value == null) {
        return await delete(key);
      }
      if (_isWeb) {
        html.window.localStorage[key] = value;
        return true;
      } else {
        return await _prefs!.setString(key, value);
      }
    } catch (e) {
      print('Error writing to storage: $e');
      return false;
    }
  }

  Future<bool> delete(String key) async {
    if (!_isInitialized.value) {
      print('StorageServices not initialized. Initializing now...');
      await _initStorage();
    }
    try {
      if (_isWeb) {
        html.window.localStorage.remove(key);
        return true;
      } else {
        return await _prefs!.remove(key);
      }
    } catch (e) {
      print('Error deleting from storage: $e');
      return false;
    }
  }
}