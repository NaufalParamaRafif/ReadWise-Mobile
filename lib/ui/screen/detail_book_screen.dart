import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/services.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/homepage_screen.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/menunggu_screen.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/semua_buku.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util.dart';

class DetailBookScreen extends StatelessWidget {
  final String slug;
  static String baseUrl = Util.baseUrl;

  DetailBookScreen({required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: BookDetailService.fetchBookDetail(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        '$baseUrl/storage/buku/${data['buku']['image']}',
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Center(
                        child: Text(
                          data['buku']['judul'],
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
                          'By ${data['penulis']}',
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
                          value: data['buku']['rata_rata_rating'],
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                          icon: Icons.star,
                          iconColor: Colors.yellow,
                        ),
                        InfoCard(
                          label: 'Halaman',
                          value: data['buku']['jumlah_halaman'].toString(),
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                        ),
                        InfoCard(
                          label: 'Bahasa',
                          value: data['buku']['bahasa'],
                          fontFamily: "Inika",
                          fontWeight: FontWeight.w200,
                        ),
                        InfoCard(
                          label: 'Tipe',
                          value: data['buku']['tipe'],
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
                      data['buku']['deskripsi'],
                      style: TextStyle(fontFamily: "Inter", fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Status Ketersediaan : ${data['buku']['status_ketersediaan'] == 1 ? 'Tersedia' : 'Tidak tersedia'}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Category : ${data['category']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Penerbit : ${data['penerbit']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ISBN : ${data['buku']['isbn']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tanggal Publish : ${data['buku']['tanggal_terbit']}',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20),
                    if (data['status_buku'] == '' && data['buku']['status_ketersediaan'] == 1)
                      InkWell(
                        onTap: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          final String? token = prefs.getString('token');

                          if (token == null) {
                            // Handle the case when there is no token
                            throw Exception('Token not found');
                          }
                          final response = await http.post(
                            Uri.parse('${Util.baseUrl}/api/mengantri-peminjaman/$slug'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token',
                            },
                          );

                          if (response.statusCode == 200) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenungguScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${response.statusCode} | Gagal meminjam buku!')),
                            );
                          }
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    else if (data['status_buku'] == 'mengantri_peminjaman')
                      InkWell(
                        onTap: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          final String? token = prefs.getString('token');

                          if (token == null) {
                            // Handle the case when there is no token
                            throw Exception('Token not found');
                          }
                          final response = await http.delete(
                            Uri.parse('${Util.baseUrl}/mengantri-peminjaman/$slug'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token',
                            },
                          );

                          if (response.statusCode == 200) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePageScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal membatalkan antrian!')),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Batal antri peminjaman',
                              style: TextStyle(
                                fontFamily: "Inika",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    else if (data['status_buku'] == 'mengantri_pengembalian')
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Mengantri pengembalian...',
                            style: TextStyle(
                              fontFamily: "Inika",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else if (data['status_buku'] == 'mengantri_denda')
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Menunggu pembayaran denda',
                            style: TextStyle(
                              fontFamily: "Inika",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else if (data['status_buku'] == 'dipinjam')
                      InkWell(
                        onTap: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          final String? token = prefs.getString('token');

                          if (token == null) {
                            // Handle the case when there is no token
                            throw Exception('Token not found');
                          }
                          final response = await http.post(
                            Uri.parse('${Util.baseUrl}/api/mengantri-pengembalian/$slug'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token',
                            },
                          );

                          if (response.statusCode == 200) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenungguScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${response.statusCode} | Gagal mengembalikan buku!')),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Kembalikan',
                              style: TextStyle(
                                fontFamily: "Inika",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
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
