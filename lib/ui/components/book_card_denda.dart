import 'package:flutter/material.dart';

import '../../util.dart';

class BookCardDenda extends StatelessWidget {
  final String image;
  final String judul;
  final String jumlah;
  static String baseUrl = Util.baseUrl;
  

  BookCardDenda({required this.image, required this.judul, required this.jumlah});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '$baseUrl/storage/buku/$image',
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Jumlah denda',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    color: Colors.grey.shade300,
                    child: Text(
                      jumlah,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Menunggu pembayaran',
                        style: TextStyle(
                          fontFamily: "Inika",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}