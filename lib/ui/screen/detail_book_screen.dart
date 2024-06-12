import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ujilevel_laravel_perpus/ui/screen/menunggu_screen.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/semua_buku.dart';

import '../../util.dart';

class DetailBookScreen extends StatelessWidget {
  final String slug;
  static String baseUrl = Util.baseUrl;

  DetailBookScreen({required this.slug});

  Future<Map<String, dynamic>> _fetchBookDetail() async {
    print(slug);
    final response = await http.get(Uri.parse('$baseUrl/api/detail-buku/$slug'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['buku'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchBookDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final buku = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        '$baseUrl/storage/buku/${buku['image']}',
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Center(
                        child: Text(
                          buku['judul'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Inika",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 1),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SemuaBukuBerdasarkan()));
                        },
                        child: Text(
                          'By Morgan Housel',
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoCard(
                          label: 'Rating',
                          value: buku['rata_rata_rating'],
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                          icon: Icons.star,
                          iconColor: Colors.yellow,
                        ),
                        InfoCard(
                          label: 'Halaman',
                          value: buku['jumlah_halaman'].toString(),
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                        ),
                        InfoCard(
                          label: 'Bahasa',
                          value: buku['bahasa'],
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                        ),
                        InfoCard(
                          label: 'Tipe',
                          value: buku['tipe'],
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Synopsis',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      buku['deskripsi'],
                      style: TextStyle(fontFamily: "Inter", fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Penerbit : Mentari Timur Jaya',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ISBN : ${buku['isbn']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tanggal Publish : ${buku['tanggal_terbit']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenungguScreen(userId: 3,)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                          'Pinjam',
                          style: TextStyle(
                              fontFamily: "Inika",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String fontFamily;
  final FontWeight fontWeight;
  final IconData? icon;
  final Color? iconColor;

  InfoCard({
    required this.label,
    required this.value,
    required this.fontFamily,
    required this.fontWeight,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: fontWeight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                SizedBox(width: 4), // Add space between icon and text
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    fontWeight: fontWeight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
