import 'package:flutter/material.dart';

class SemuaBukuBerdasarkan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penulis: Ingrid Chabbert',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/fotobuku.jpg',
                  scale: 4,
                  height: 250, // Ubah tinggi menjadi sesuai
                ),
                SizedBox(width: 8), // Gantilah dengan lebar yang sesuai
                Image.asset(
                  'assets/images/fotobuku.jpg',
                  scale: 4,
                  height: 250,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/fotobuku.jpg',
                  scale: 4,
                  height: 250,
                ),
                SizedBox(width: 8), // Gantilah dengan lebar yang sesuai
                Image.asset(
                  'assets/images/fotobuku.jpg',
                  scale: 4,
                  height: 250,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
