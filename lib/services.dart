import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ujilevel_laravel_perpus/util.dart';

class HistoryService {
  static Future<void> getUserHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      print('No token found');
      return;
    }

    final String apiUrl = '${Util.baseUrl}/api/history';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        // Process the history data
        final List<dynamic> sedangDipinjam = responseData['sedang_dipinjam'];
        final List<dynamic> sudahDipinjam = responseData['sudah_dipinjam'];

        print('Sedang Dipinjam: $sedangDipinjam');
        print('Sudah Dipinjam: $sudahDipinjam');
      } else {
        // Handle the case when the response is not successful
        print('Failed to retrieve history');
      }
    } else {
      // Handle the error
      print('Error retrieving history: ${response.statusCode}');
    }
  }
}

class HomePageService {
  static Future<List<dynamic>> fetchBukuList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      throw Exception('Token not found');
    }

    final String apiUrl = '${Util.baseUrl}/api/homepage';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['bukus'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class BookDetailService{
  static Future<Map<String, dynamic>> fetchBookDetail(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final String apiUrl = '${Util.baseUrl}/api/detail-buku/$slug';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class MenungguService {
  static Future<Map<String, dynamic>> fetchMenungguData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      throw Exception('Token not found');
    }

    final String apiUrl = '${Util.baseUrl}/api/menunggu';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}