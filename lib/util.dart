import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static String baseUrl = 'http://192.168.1.4:8000';

  static Future<void> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      return;
    }

    final String apiUrl = '$baseUrl/api/user';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Use the user info
      print(responseData['user']);
    } else {
      // Handle the error
      print('Error retrieving user info');
    }
  }
}
