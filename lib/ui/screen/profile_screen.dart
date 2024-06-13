import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ujilevel_laravel_perpus/ui/screen/login_screen.dart';
import '../../util.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      return null;
    }

    final String apiUrl = '${Util.baseUrl}/api/user';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Handle the error
      return null;
    }
  }

  static Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when there is no token
      return;
    }

    final String apiUrl = '${Util.baseUrl}/api/logout';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      prefs.remove('token'); // Remove the token from SharedPreferences
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Navigate to the login screen
    } else {
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          } else {
            final user = snapshot.data!;
            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(100, 165, 255, 1),
                            Color.fromRGBO(238, 240, 253, 1),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          SizedBox(height: 150),
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assets/images/fotobuku.jpg'),
                            backgroundColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      itemProfile('Username', user['username'] ?? 'N/A', Icons.person),
                      const SizedBox(height: 15),
                      itemProfile('Name', '${user['first_name']} ${user['last_name']}' ?? 'N/A', Icons.person),
                      const SizedBox(height: 15),
                      SizedBox(width: double.infinity),
                      ElevatedButton(
                        onPressed: () => logout(context),
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
