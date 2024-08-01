import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Httpservice {
  static Future<Map<String, dynamic>> getJwt(String username, String password) async {
    debugPrint('Starting getJwt function');
     try {
      final uri = Uri.parse('http://13.60.173.158/user/company_admin_login_page?username=$username&password=$password');
      debugPrint('Requesting URL: $uri');

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jwt = jsonDecode(response.body);
        final token = jwt['token'];
        debugPrint('Extracted token: $token');

        if (token != null) {
          // Store JWT using SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          debugPrint('JWT stored successfully');

          return {'success': true, 'token': token};
        } else {
          return {'success': false, 'error': 'Token not found in response'};
        }
      } else {
        return {'success': false, 'error': 'Server returned status code: ${response.statusCode}', 'body': response.body};
      }
    } catch (e, stackTrace) {
      debugPrint('Caught exception: $e');
      debugPrint('Stack trace: $stackTrace');
      return {'success': false, 'error': e.toString()};
    }
  }

}